import 'package:flutter/cupertino.dart' show CupertinoDialogAction;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pudding/common/components/app_info_cont.dart';
import 'package:pudding/common/components/btns.dart';
import 'package:pudding/common/components/loading_overlay.dart'
    show LoadingOverlay;
import 'package:pudding/common/parts.dart';
import 'package:pudding/common/utils/utils.dart' show isApple;
import 'package:pudding/core/navigation/routing.dart';
import 'package:pudding/core/providers/app_info_provider.dart'
    show appInfoProvider;
import 'package:pudding/features/auth/providers/auth_providers.dart'
    show authRepositoryProvider;

// TODO: complete this

/// a drawer component
class DrawerPanel extends ConsumerWidget {
  const DrawerPanel({super.key});

  Future<void> _signout(WidgetRef ref) async {
    LoadingOverlay.showDefaultLoading(msg: "Logging out");
    await ref.read(authRepositoryProvider).signOut();
    LoadingOverlay.dismissLoading();
    Routing.popPage();
  }

  void handleSignOut({required BuildContext ctx, required WidgetRef ref}) {
    // TODO: localize
    showAdaptiveDialog(
      requestFocus: true,
      context: ctx,
      builder: (_) {
        return AlertDialog.adaptive(
          title: const Text("Logout from Pudding?"),
          // content: const Text("x"),
          icon: const Icon(Icons.logout_outlined),
          actions: [
            if (isApple()) ...actionsBtnOnApple(ref),
            if (!isApple()) ...[
              filledTextIconBtn(
                onPressed: () => Routing.popPage(),
                text: const Text("CANCEL"),
              ),
              secondaryTextIconBtn(
                onPressed: () async => await _signout(ref),
                text: const Text("LOGOUT"),
              ),
            ],
          ],
        );
      },
    );
  }

  List<Widget> actionsBtnOnApple(WidgetRef ref) {
    return [
      CupertinoDialogAction(
        onPressed: () => Routing.popPage(),
        isDestructiveAction: true,
        isDefaultAction: true,
        child: const Text("CANCEL"),
      ),
      CupertinoDialogAction(
        onPressed: () async => await _signout(ref),
        isDestructiveAction: false,
        isDefaultAction: false,
        child: const Text("LOGOUT"),
      ),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Drawer(
        shape: RoundedRectangleBorder(borderRadius: Parts.defaultBorderRadius),
        width: MediaQuery.sizeOf(context).width * 0.7,
        elevation: 32,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            renderDrawerTop(ref, context),

            Expanded(
              child: GridView(
                shrinkWrap: true,
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                padding: Parts.zeroEdgeInsets,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: SizingScale.tiny.value,
                  mainAxisExtent: MediaQuery.sizeOf(context).height * 0.11,
                ),
                children: [
                  ListTile(
                    title: Text('Item 1'),
                    onTap: () {
                      // Handle tap for Item 1
                    },
                  ),
                  ListTile(
                    title: Text('Item 2'),
                    onTap: () {
                      // Handle tap for Item 2
                    },
                  ),
                  // TODO: fill this information
                  AboutListTile(
                    applicationVersion: ref
                        .read(appInfoProvider)
                        .value
                        ?.version,
                    applicationName: "Pudding",
                  ),
                  ListTile(
                    title: IconButton.filled(
                      onPressed: () => Routing.pushToDevLogPage(),
                      icon: const Icon(
                        Icons.logo_dev_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppInfoCont(
              containerDecoration: BoxDecoration(
                borderRadius: Parts.defaultBorderRadius,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stack renderDrawerTop(WidgetRef ref, BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            margin: Parts.zeroEdgeInsets,
            padding: Parts.defaultEdgeInsetsAll,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Text(
                  "Hi, ${ref.read(authRepositoryProvider).currentUserDisplayNameOrEmail!}",
                  style: Theme.of(context).textTheme.headlineSmall,
                  maxLines: 2,
                  softWrap: true,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton.outlined(
            onPressed: () => handleSignOut(ctx: context, ref: ref),
            icon: const Icon(Icons.logout_outlined),
          ),
        ),
      ],
    );
  }
}
