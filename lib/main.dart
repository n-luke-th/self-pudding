import 'dart:async' show runZonedGuarded;

import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:firebase_core/firebase_core.dart' show Firebase, FirebaseApp;
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart'
    show FlutterNativeSplash;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pudding/core/logger/logger_providers.dart'
    show logger, TalkerRouteObserver, TalkerWrapper;
import 'features/auth/providers/auth_providers.dart';
import 'features/collections/presentation/collections_list_screen.dart';
import 'firebase_options.dart';

void widgetsBindingAndPreserveSplash() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
}

Future<FirebaseApp> initializeFirebaseApp() async {
  return await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

// 1. Wrap your entire app in a "ProviderScope"
// This widget stores the state of all your providers.
void main() async {
  runZonedGuarded(
    () {
      widgetsBindingAndPreserveSplash();
      initializeFirebaseApp();

      FlutterNativeSplash.remove();
      runApp(const ProviderScope(child: Pudding()));
    },
    (e, st) {
      logger.error("Uncaught exception occurred.", e, st);
      logger.handle(e, st, "Uncaught exception occurred.");
    },
  );
}

class Pudding extends ConsumerWidget {
  const Pudding({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We can watch the auth state to decide which screen to show.
    final authState = ref.watch(authStateChangesProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [TalkerRouteObserver(logger)],
      title: 'Collab Collections',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F5F7),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: authState.when(
        data: (User? user) {
          if (user != null) {
            // If logged in, show the main collections screen
            return const CollectionsListScreen();
          }
          // If not logged in, show a simple sign-in button
          return const AuthGate();
        },
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (err, stack) => Scaffold(
          body: Center(
            child: TalkerWrapper(talker: logger, child: Text('Error: $err')),
          ),
        ),
      ),
    );
  }
}

// A simple widget to allow anonymous sign-in for the demo.
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
