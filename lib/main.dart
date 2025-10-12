import 'dart:async' show runZonedGuarded;

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart'
    show FlutterSmartDialog;
import 'package:pudding/common/components/full_page_loading.dart';
import 'package:pudding/common/components/view_wrappers.dart';
import 'package:pudding/core/logger/logger_providers.dart'
    show logger, TalkerRouteObserver;
import 'package:pudding/core/models/appbar_cfg_model.dart';
import 'package:pudding/core/providers/firebase_providers.dart'
    show firebaseInitProvider;
import 'package:pudding/features/auth/presentation/auth_gate.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

void widgetsBindingAndPreserveSplash() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
}

void main() async {
  runZonedGuarded(
    () {
      widgetsBindingAndPreserveSplash();

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
      title: 'Pudding',
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
          showEndDrawer: false,
          body: FullPageLoading.df,
        );
      },
      error: (err, stack) => errorPageWrapper(errorValue: "Init error: $err"),
    );
  }
}
