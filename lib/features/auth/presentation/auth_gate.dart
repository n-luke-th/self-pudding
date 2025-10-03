import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pudding/features/auth/providers/auth_providers.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Sign In Anonymously'),
          onPressed: () {
            // We use ref.read() inside a callback to call a function on the provider.
            ref.read(authRepositoryProvider).signInAnonymously();
          },
        ),
      ),
    );
  }
}
