import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pudding/common/components/icon_btns.dart' show closeBtn;
import 'package:pudding/common/components/loading_overlay.dart';
import 'package:pudding/common/components/view_wrappers.dart'
    show layoutBuilder;
import 'package:pudding/common/parts.dart';
import 'package:pudding/common/utils/show_and.dart';
import 'package:pudding/features/auth/providers/auth_providers.dart';
import 'package:validatorless/validatorless.dart' show Validatorless;

/// panel for user to fill in their login credentials (email + password) to signin
class SigninEmailPanel extends ConsumerStatefulWidget {
  const SigninEmailPanel({super.key});

  @override
  ConsumerState<SigninEmailPanel> createState() => _SigninEmailPanelState();
}

class _SigninEmailPanelState extends ConsumerState<SigninEmailPanel> {
  final emailCtl = TextEditingController();
  final pswdCtl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool passwordVisible = false;

  @override
  void dispose() {
    emailCtl.dispose();
    pswdCtl.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  Future<void> handleSignIn() async {
    // We use ref.read() inside a callback to call a function on the provider.
    try {
      if (formKey.currentState!.validate()) {
        LoadingOverlay.showDefaultLoading(msg: "Signing you in");
        await ref
            .read(authRepositoryProvider)
            .signInWithEmail(email: emailCtl.text.trim(), pwd: pswdCtl.text);
        pswdCtl.clear();
        emailCtl.clear();
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
    return BlurryContainer(
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
              child: closeBtn(
                onPressed: () => SmartDialog.dismiss(force: true),
              ),
            ),
            // test toast only
            // Align(
            //   alignment: AlignmentGeometry.topLeft,
            //   child: IconButton.outlined(
            //     onPressed: () => showErrorToastAndThrow(
            //       msg: "invalid-credential",
            //       msgDetails:
            //           "Given credential is incorrect, malformed or has expired.",
            //     ),
            //     icon: Icon(Icons.abc_outlined),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Container renderCont({double heightFactor = 0.5, double widthFactor = 0.9}) {
    return Container(
      height: MediaQuery.sizeOf(context).height * heightFactor,
      width: MediaQuery.sizeOf(context).width * widthFactor,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: Parts.defaultBorderRadius,
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 8, spreadRadius: 0.2),
        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: signinPanelElements(),
        ),
      ),
    );
  }

  List<Widget> signinPanelElements() {
    return [
      Padding(
        padding: Parts.smallEdgeInsetsAll,
        child: TextFormField(
          // email field
          controller: emailCtl,
          decoration: InputDecoration(
            errorMaxLines: 2,
            labelText: 'email',
            // hintText: "pudding@lukecreated.com",
            icon: const Icon(LucideIcons.mail),
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
        ),
      ),
      Padding(
        padding: Parts.smallEdgeInsetsAll,
        child: TextFormField(
          // password
          controller: pswdCtl,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            errorMaxLines: 2,
            labelText: 'password',

            // hintText: "strong-password",
            icon: const Icon(LucideIcons.lockKeyhole),
            suffixIcon: IconButton(
              icon: Icon(
                passwordVisible ? LucideIcons.eye : LucideIcons.eyeOff,
                color: Theme.of(context).hintColor,
              ),
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
            ),
          ),
          validator: Validatorless.required("required your password!"),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.go,
          onFieldSubmitted: (value) => handleSignIn(),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),

          obscureText: !passwordVisible,
        ),
      ),

      Padding(
        padding: Parts.smallEdgeInsetsAll,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: Parts.defaultShapeOutlinedBorder,
            enableFeedback: true,
            elevation: 16,
            minimumSize: Size.square(65),
          ),
          onPressed: () async => await handleSignIn(),
          child: Text("SIGNIN", textAlign: TextAlign.center),
        ),
      ),
    ];
  }
}
