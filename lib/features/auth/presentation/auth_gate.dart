import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart'
    show SmartDialog;
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pudding/common/components/app_info_cont.dart';
import 'package:pudding/common/components/btns.dart'
    show defaultTextIconBtn, filledTextIconBtn;
import 'package:pudding/common/components/full_page_loading.dart';
import 'package:pudding/common/components/view_wrappers.dart';
import 'package:pudding/common/parts.dart';
import 'package:pudding/core/models/appbar_cfg_model.dart';
import 'package:pudding/features/auth/presentation/signin_anony.dart';
import 'package:pudding/features/auth/presentation/signin_email.dart';
import 'package:pudding/features/auth/presentation/signup_email.dart';
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
            extendBody: false,
            showEndDrawer: false,
            appBarCfg: AppbarCfgModel(
              titleStr: "Welcome!",
              overrideActions: const [],
            ),
            body: loginOptionsSelectionView(),
            floatingActionButton: renderSignupEmailBtn(),
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

  Padding renderSignupEmailBtn() {
    return Padding(
      padding: Parts.bigEdgeInsetsAll,
      child: filledTextIconBtn(
        // TODO: localize
        text: const Text("Create account"),
        icon: const Icon(LucideIcons.plus),
        onPressed: () async => await SmartDialog.show(
          builder: (_) => const SignupEmailPanel(),
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }

  ElevatedButton renderSigninAnonyBtn() {
    return defaultTextIconBtn(
      onPressed: () async => await SmartDialog.show(
        keepSingle: true,
        builder: (_) => const SigninAnonyPanel(),
        alignment: Alignment.centerLeft,
        usePenetrate: true,
        clickMaskDismiss: false,
      ), //TODO: localize
      text: const Text("Sign in anonymously"),
      icon: const Icon(LucideIcons.hatGlasses),
    );
  }

  ElevatedButton renderSigninEmailBtn() {
    return defaultTextIconBtn(
      onPressed: () async => await SmartDialog.show(
        keepSingle: true,
        builder: (_) => const SigninEmailPanel(),
        alignment: Alignment.centerRight,
        usePenetrate: true,
        clickMaskDismiss: false,
      ), //TODO: localize
      text: const Text("Sign in with email"),
      icon: const Icon(LucideIcons.mail),
    );
  }
}
