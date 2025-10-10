import 'dart:async' show runZonedGuarded;

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart'
    show FlutterNativeSplash;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart'
    show FlutterSmartDialog;
import 'package:pudding/core/components/full_page_loading.dart';
import 'package:pudding/core/components/page_view_wrappers.dart';
import 'package:pudding/core/logger/logger_providers.dart'
    show logger, TalkerRouteObserver;
import 'package:pudding/core/models/appbar_cfg_model.dart';
import 'package:pudding/core/providers/firebase_providers.dart'
    show firebaseInitProvider;
import 'package:pudding/features/auth/presentation/auth_gate.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger_observer.dart';

void widgetsBindingAndPreserveSplash() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
}

// Future<FirebaseApp> initializeFirebaseApp() async {
//   return await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
// }

// 1. Wrap your entire app in a "ProviderScope"
// This widget stores the state of all your providers.
void main() async {
  runZonedGuarded(
    () {
      widgetsBindingAndPreserveSplash();
      // initializeFirebaseApp();

      FlutterNativeSplash.remove();
      runApp(
        ProviderScope(
          observers: [
            TalkerRiverpodObserver(
              talker: logger,
              settings: const TalkerRiverpodLoggerSettings(
                printProviderDisposed: true,
              ),
            ),
          ],
          child: const PuddingApp(),
        ),
      );
    },
    (e, st) {
      logger.error("Uncaught exception occurred.", e, st);
      logger.handle(e, st, "Uncaught exception occurred.");
    },
  );
}

class PuddingApp extends ConsumerWidget {
  const PuddingApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Collab Collections',
      builder: FlutterSmartDialog.init(),
      navigatorObservers: [
        TalkerRouteObserver(logger),
        FlutterSmartDialog.observer,
      ],
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const EntryPoint(),
    );
  }
}

class EntryPoint extends ConsumerWidget {
  const EntryPoint({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final init = ref.watch(firebaseInitProvider);

    return init.when(
      data: (_) => const AuthGate(),
      loading: () {
        return pageViewWrapper(
          appBarCfg: AppbarCfgModel(titleStr: "Initializing"),
          extendBody: true,
          body: FullPageLoading.df,
        );
      },
      error: (err, stack) => errorPageWrapper(e: "Init error: $err"),
    );
  }
}

// class Pd extends ConsumerWidget {
//   const Pd({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // We can watch the auth state to decide which screen to show.
//     final authState = ref.watch(authStateChangesProvider);

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       navigatorObservers: [
//         TalkerRouteObserver(logger),
//         FlutterSmartDialog.observer,
//       ],
//       title: 'Pudding',
//       theme: ThemeData(
//         primarySwatch: Colors.indigo,
//         useMaterial3: true,
//         scaffoldBackgroundColor: const Color(0xFFF5F5F7),
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black,
//           elevation: 0,
//           centerTitle: true,
//         ),
//       ),
//       builder: FlutterSmartDialog.init(),
//       home: authState.when(
//         data: (User? user) {
//           if (user != null) {
//             // If logged in, show the main collections screen
//             SmartDialog.dismiss(force: true);
//             return const CollectionsListScreen();
//           }
//           // If not logged in, show a simple sign-in button
//           return const AuthGate();
//         },
//         loading: () =>
//             const Scaffold(body: Center(child: CircularProgressIndicator())),
//         error: (err, stack) => errorPageWrapper(e: err.toString()),
//       ),
//     );
//   }
// }
