import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pudding/common/components/btns.dart'
    show closeIconBtn, bigTextOnlyBtn, clearTextFieldIconBtn;
import 'package:pudding/common/components/loading_overlay.dart';
import 'package:pudding/common/components/view_wrappers.dart'
    show layoutBuilder, blurryBackgroundContent;
import 'package:pudding/common/parts.dart';
import 'package:pudding/common/utils/show_and.dart';
import 'package:pudding/common/utils/utils.dart' show unfocus;
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
  final pswdFocus = FocusNode(debugLabel: 'pswdFocus');
  bool passwordVisible = false;

  @override
  void dispose() {
    emailCtl.dispose();
    pswdCtl.dispose();
    pswdFocus.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  Future<void> handleSignIn() async {
    // We use ref.read() inside a callback to call a function on the provider.
    try {
      if (formKey.currentState!.validate()) {
        LoadingOverlay.showDefaultLoading(msg: "Signing you in");
        return await ref
            .read(authRepositoryProvider)
            .signInWithEmail(email: emailCtl.text.trim(), pwd: pswdCtl.text)
            .then((_) {
              SmartDialog.dismiss(force: true);
              Future.delayed(
                const Duration(milliseconds: 10),
                () => showSuccessToastAndLog(
                  msg: "Welcome to Pudding!",
                  msgDetails: ref
                      .read(authRepositoryProvider)
                      .currentUserDisplayNameOrEmail,
                ),
              );
            });
      }
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
    return blurryBackgroundContent(
      child: Padding(
        padding: Parts.defaultEdgeInsetsAll,
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: [
            layoutBuilder(
              smallLayout: renderCont(),
              bigLayout: renderCont(widthFactor: 0.7),
            ),
            Align(
              alignment: AlignmentGeometry.topRight,
              child: closeIconBtn(
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

  Container renderCont({double widthFactor = 0.9}) {
    return Container(
      // height: MediaQuery.sizeOf(context).height * heightFactor,
      width: MediaQuery.sizeOf(context).width * widthFactor,
      decoration: Parts.defaultBoxDecoration,
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: signinPanelElements(),
          ),
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
          autocorrect: false,
          decoration: InputDecoration(
            errorMaxLines: 2,
            labelText: 'email',
            // hintText: "pudding@lukecreated.com",
            icon: const Icon(LucideIcons.mail),
            // suffix: clearTextFieldIconBtn(onPressed: () => emailCtl.clear()),
          ),
          // TODO: add localized text for email validator
          validator: Validatorless.multiple([
            Validatorless.email("required a valid email!"),
            Validatorless.required("required a valid email!"),
          ]),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onTapOutside: (event) => unfocus(context),
          onFieldSubmitted: (value) => pswdFocus.requestFocus(),
        ),
      ),
      Padding(
        padding: Parts.smallEdgeInsetsAll,
        child: TextFormField(
          // password
          controller: pswdCtl,
          focusNode: pswdFocus,
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
          onTapOutside: (event) => unfocus(context),
          obscureText: !passwordVisible,
        ),
      ),

      Padding(
        padding: Parts.customEdgeInsetsVertical(SizingScale.small),
        child: bigTextOnlyBtn(
          onPressed: () async => await handleSignIn(),
          // TODO: localize
          text: const Text("SIGNIN", textAlign: TextAlign.center),
        ),
      ),
    ];
  }
}
