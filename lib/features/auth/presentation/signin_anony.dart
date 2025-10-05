import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:pudding/core/components/loading_overlay.dart';
import 'package:pudding/core/components/page_view_wrappers.dart';
import 'package:pudding/features/auth/providers/auth_providers.dart';

class SigninAnonyPanel extends ConsumerWidget {
  const SigninAnonyPanel({super.key});

  Future<void> handleSignInAnonymously(WidgetRef ref) async {
    // We use ref.read() inside a callback to call a function on the provider.
    LoadingOverlay.showDefaultLoading(msg: "Signing you in");
    await ref.read(authRepositoryProvider).signInAnonymously();
    LoadingOverlay.dismissLoading();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return pageViewWrapper(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
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
                      shape: RoundedSuperellipseBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      enableFeedback: true,
                      elevation: 16,
                      minimumSize: Size.square(65),
                    ),
                    onPressed: () async => await handleSignInAnonymously(ref),
                    child: Text(
                      "Confirm signin anonymously",
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
