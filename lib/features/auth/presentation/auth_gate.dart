import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart'
    show SmartDialog;
import 'package:pudding/core/components/full_page_loading.dart';
import 'package:pudding/core/components/page_view_wrappers.dart';
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
            appBarCfg: AppbarCfgModel(titleStr: "Welcome!"),

            body: loginOptionsSelectionView(),
          );
        } else {
          SmartDialog.dismiss(force: true);
          return const CollectionsListScreen();
        }
      },
      loading: () => FullPageLoading.df,
      error: (err, stack) => errorPageWrapper(e: err.toString()),
    );
  }

  Center loginOptionsSelectionView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 32,
        children: [
          ElevatedButton.icon(
            onPressed: () => SmartDialog.show(
              builder: (context) => SigninAnonyPanel(),
              permanent: true,
              alignment: Alignment.centerRight,
              usePenetrate: true,
              clickMaskDismiss: false,
            ),
            label: const Text("Sign in anonymously"),
          ),
          // TODO: customize
          ElevatedButton.icon(
            onPressed: () => SmartDialog.show(
              builder: (context) => SigninEmailPanel(),
              permanent: true,
              alignment: Alignment.centerRight,
              usePenetrate: true,
              clickMaskDismiss: false,
            ),
            label: const Text("Sign in with email"),
          ),
        ],
      ),
    );
  }
}
