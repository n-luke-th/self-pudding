import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pudding/common/components/btns.dart'
    show closeIconBtn, bigTextOnlyBtn;
import 'package:pudding/common/components/loading_overlay.dart';
import 'package:pudding/common/components/view_wrappers.dart'
    show layoutBuilder;
import 'package:pudding/common/parts.dart';
import 'package:pudding/common/utils/show_and.dart';
import 'package:pudding/features/auth/providers/auth_providers.dart';
import 'package:validatorless/validatorless.dart' show Validatorless;

/// panel for user to create login credentials using their email and password (signup)
class SignupEmailPanel extends ConsumerStatefulWidget {
  const SignupEmailPanel({super.key});

  @override
  ConsumerState<SignupEmailPanel> createState() => _SigninEmailPanelState();
}

class _SigninEmailPanelState extends ConsumerState<SignupEmailPanel> {
  final emailCtl = TextEditingController();
  final pswdCtl = TextEditingController();
  final pswd2Ctl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final pswdFocus = FocusNode(debugLabel: 'pswdFocus');
  final pswd2Focus = FocusNode(debugLabel: 'pswd2Focus');
  bool passwordVisible = false;
  bool passwordVisible2 = false;

  @override
  void dispose() {
    emailCtl.dispose();
    pswdCtl.dispose();
    pswd2Ctl.dispose();
    pswdFocus.dispose();
    pswd2Focus.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  Future<void> handleSignUp() async {
    // We use ref.read() inside a callback to call a function on the provider.
    try {
      if (formKey.currentState!.validate()) {
        LoadingOverlay.showDefaultLoading(msg: "Signing you up");
        await ref
            .read(authRepositoryProvider)
            .signUpWithEmail(email: emailCtl.text.trim(), pwd: pswdCtl.text);
        pswdCtl.clear();
        pswd2Ctl.clear();
      }
      // SmartDialog.dismiss(force: true);
    } catch (e, st) {
      if (e is FirebaseAuthException) {
        showErrorToastAndLog(e: e, st: st, msg: e.code, msgDetails: e.message);
      } else {
        showErrorToastAndLog(e: e, st: st, msg: e.toString());
      }
    } finally {
      LoadingOverlay.dismissLoading(force: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlurryContainer(
        blur: 2.5,
        padding: Parts.zeroEdgeInsets,
        child: Padding(
          padding: Parts.defaultEdgeInsetsAll,
          child: Stack(
            alignment: AlignmentGeometry.center,
            children: [
              layoutBuilder(
                smallLayout: renderCont(),
                bigLayout: renderCont(widthFactor: 0.7, heightFactor: 0.85),
              ),
              Align(
                alignment: AlignmentGeometry.topRight,
                child: closeIconBtn(
                  onPressed: () => SmartDialog.dismiss(force: true),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container renderCont({double heightFactor = 0.5, double widthFactor = 0.9}) {
    return Container(
      height: MediaQuery.sizeOf(context).height * heightFactor,
      width: MediaQuery.sizeOf(context).width * widthFactor,
      decoration: Parts.defaultBoxDecoration,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: signupPanelElements(),
        ),
      ),
    );
  }

  List<Widget> signupPanelElements() {
    return [
      Padding(
        padding: Parts.smallEdgeInsetsAll,
        child: TextFormField(
          // email field
          controller: emailCtl,
          decoration: const InputDecoration(
            errorMaxLines: 2,
            labelText: 'email',
            // hintText: "pudding@lukecreated.com",
            icon: Icon(LucideIcons.mail),
          ),
          // TODO: add localized text for email validator
          validator: Validatorless.multiple([
            Validatorless.email("required a valid email!"),
            Validatorless.required("required a valid email!"),
          ]),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          onFieldSubmitted: (value) => pswdFocus.requestFocus(),
        ),
      ),

      _pswdBox(
        ctl: pswdCtl,
        pswdFocus: pswdFocus,
        passwordVisible: passwordVisible,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (value) => pswd2Focus.requestFocus(),
        validator:
            // TODO: localize
            Validatorless.multiple([
              Validatorless.required("required your password!"),
              Validatorless.min(6, "required at least 6 characters!"),
            ]),
        onSuffixPressed: () => setState(() {
          passwordVisible = !passwordVisible;
        }),
      ),

      _pswdBox(
        ctl: pswd2Ctl,
        pswdFocus: pswd2Focus,
        labelText: "confirm password",
        validator: (_) {
          if (pswd2Ctl.text == pswdCtl.text && pswdCtl.text.isNotEmpty) {
            return null;
          } else {
            // TODO: localize
            return "passwords not match!";
          }
        },
        onSuffixPressed: () => setState(() {
          passwordVisible2 = !passwordVisible2;
        }),
        passwordVisible: passwordVisible2,
        // onFieldSubmitted: (_) async => await handleSignUp(),
      ),

      bigTextOnlyBtn(
        onPressed: () async => await handleSignUp(),
        // TODO: localize
        text: const Text("SIGNUP", textAlign: TextAlign.center),
      ),
    ];
  }

  Padding _pswdBox({
    required TextEditingController ctl,
    required String? Function(String?)? validator,
    required void Function()? onSuffixPressed,
    required bool passwordVisible,
    required FocusNode pswdFocus,
    void Function(String)? onFieldSubmitted,
    String labelText = 'password',
    TextInputAction textInputAction = TextInputAction.done,
  }) {
    return Padding(
      padding: Parts.smallEdgeInsetsAll,
      child: TextFormField(
        // password
        controller: ctl,
        focusNode: pswdFocus,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          errorMaxLines: 2,
          labelText: labelText,

          // hintText: "strong-password",
          icon: const Icon(LucideIcons.lockKeyhole),
          suffixIcon: IconButton(
            icon: Icon(
              passwordVisible ? LucideIcons.eye : LucideIcons.eyeOff,
              color: Theme.of(context).hintColor,
            ),
            onPressed: onSuffixPressed,
          ),
        ),
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        obscureText: !passwordVisible,
      ),
    );
  }
}
