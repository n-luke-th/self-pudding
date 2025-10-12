import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart'
    show SmartDialog;
import 'package:pudding/common/components/app_info_cont.dart';
import 'package:pudding/common/components/full_page_loading.dart';
import 'package:pudding/common/components/view_wrappers.dart';
import 'package:pudding/core/models/appbar_cfg_model.dart';
import 'package:pudding/features/auth/presentation/signin_anony.dart';
import 'package:pudding/features/auth/presentation/signin_email.dart';
import 'package:pudding/features/auth/providers/auth_providers.dart';
import 'package:pudding/features/collections/presentation/collections_list_screen.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);
    return authState.when(
      data: (user) {
        if (user == null) {
          return pageViewWrapper(
            extendBodyBehindAppBar: true,
            extendBody: true,
            showEndDrawer: false,
            appBarCfg: AppbarCfgModel(
              titleStr: "Welcome!",
              overrideActions: const [],
            ),
            body: loginOptionsSelectionView(),
            bottomSheet: AppInfoCont(),
          );
        } else {
          SmartDialog.dismiss(force: true);
          return const CollectionsListScreen();
        }
      },
      loading: () => FullPageLoading.df,
      error: (err, stack) => errorPageWrapper(errorValue: err.toString()),
    );
  }

  Center loginOptionsSelectionView() {
    const double spacing = 24.0;
    return Center(
      child: layoutBuilder(
        smallLayout: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: spacing,
          children: [renderSigninAnonyBtn(), renderSigninEmailBtn()],
        ),
        bigLayout: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: spacing,
          children: [renderSigninAnonyBtn(), renderSigninEmailBtn()],
        ),
      ),
    );
  }

  ElevatedButton renderSigninAnonyBtn() {
    return ElevatedButton.icon(
      onPressed: () => SmartDialog.show(
        keepSingle: true,
        builder: (context) => SigninAnonyPanel(),
        alignment: Alignment.centerLeft,
        usePenetrate: true,
        clickMaskDismiss: false,
      ),
      label: const Text("Sign in anonymously"),
    );
  }

  ElevatedButton renderSigninEmailBtn() {
    return ElevatedButton.icon(
      onPressed: () => SmartDialog.show(
        keepSingle: true,
        builder: (context) => SigninEmailPanel(),
        alignment: Alignment.centerRight,
        usePenetrate: true,
        clickMaskDismiss: false,
      ),
      label: const Text("Sign in with email"),
    );
  }
}
