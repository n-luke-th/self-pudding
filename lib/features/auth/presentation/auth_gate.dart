import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:pudding/core/components/page_view_wrappers.dart';
import 'package:pudding/features/auth/presentation/signin_anony.dart';
import 'package:pudding/features/auth/providers/auth_providers.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return pageViewWrapper(
      body: Center(
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
                builder: (context) => SigninAnonyPanel(),
                permanent: true,
                alignment: Alignment.centerRight,
                usePenetrate: true,
                clickMaskDismiss: false,
              ),
              label: const Text("Sign in with password"),
            ),
          ],
        ),
      ),
    );
  }
}
