import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:pudding/common/components/btns.dart'
    show closeIconBtn, bigTextOnlyBtn;
import 'package:pudding/common/components/loading_overlay.dart';
import 'package:pudding/common/components/view_wrappers.dart'
    show layoutBuilder;
import 'package:pudding/common/parts.dart';
import 'package:pudding/common/utils/show_and.dart';
import 'package:pudding/features/auth/providers/auth_providers.dart';

/// panel to confirm user for anonymous sign in
class SigninAnonyPanel extends ConsumerWidget {
  const SigninAnonyPanel({super.key});

  Future<void> handleSignInAnonymously(WidgetRef ref) async {
    // We use ref.read() inside a callback to call a function on the provider.

    try {
      LoadingOverlay.showDefaultLoading(msg: "Signing you in anonymously");
      await ref.read(authRepositoryProvider).signInAnonymously();
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
  Widget build(BuildContext context, WidgetRef ref) {
    return BlurryContainer(
      blur: 2.5,
      padding: Parts.zeroEdgeInsets,
      child: Padding(
        padding: Parts.defaultEdgeInsetsAll,
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: [
            layoutBuilder(
              smallLayout: renderCont(
                ctx: context,
                heightFactor: 0.3,
                ref: ref,
              ),
              bigLayout: renderCont(ctx: context, heightFactor: 0.6, ref: ref),
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
    );
  }

  Container renderCont({
    required BuildContext ctx,
    required WidgetRef ref,
    double heightFactor = 0.4,
  }) {
    return Container(
      height: MediaQuery.sizeOf(ctx).height * heightFactor,
      decoration: Parts.defaultBoxDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 0,
        children: signinPanelElements(ref),
      ),
    );
  }

  List<Widget> signinPanelElements(WidgetRef ref) {
    return [
      bigTextOnlyBtn(
        onPressed: () async => await handleSignInAnonymously(ref),
        // TODO: localize
        text: const Text(
          "Confirm signin anonymously",
          softWrap: true,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ),
    ];
  }
}
