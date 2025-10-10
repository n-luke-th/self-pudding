import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:pudding/core/components/loading_overlay.dart';
import 'package:pudding/core/components/page_view_wrappers.dart';
import 'package:pudding/core/components/parts.dart';
import 'package:pudding/features/auth/providers/auth_providers.dart';

class SigninEmailPanel extends ConsumerWidget {
  SigninEmailPanel({super.key});
  final emailCtl = TextEditingController();
  final pswdCtl = TextEditingController();

  Future<void> handleSignIn(WidgetRef ref) async {
    // We use ref.read() inside a callback to call a function on the provider.
    LoadingOverlay.showDefaultLoading(msg: "Signing you in");
    await ref
        .read(authRepositoryProvider)
        .signInWithEmail(email: emailCtl.text.trim(), pwd: pswdCtl.text);
    LoadingOverlay.dismissLoading();
    SmartDialog.dismiss(force: true);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return pageViewWrapper(
      body: Center(
        child: Padding(
          padding: Parts.defaultEdgeInsetsAll,
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: Parts.defaultBorderRadius,
              boxShadow: [
                BoxShadow(color: Colors.grey, blurRadius: 8, spreadRadius: 0.2),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 16,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: Parts.defaultShapeOutlinedBorder,
                      enableFeedback: true,
                      elevation: 16,
                      minimumSize: Size.square(65),
                    ),
                    onPressed: () async => await handleSignIn(ref),
                    child: Text(
                      "SIGNIN",
                      softWrap: true,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => SmartDialog.dismiss(force: true),
                  child: const Text('back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
