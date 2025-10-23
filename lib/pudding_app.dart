import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart'
    show FlutterSmartDialog;
import 'package:pudding/common/components/full_page_loading.dart'
    show FullPageLoading;
import 'package:pudding/common/components/view_wrappers.dart'
    show errorPageWrapper, pageViewWrapper;
import 'package:pudding/core/logger/logger_providers.dart'
    show logger, TalkerRouteObserver;
import 'package:pudding/core/models/appbar_cfg_model.dart';
import 'package:pudding/core/navigation/navigation.dart' show navigatorKey;
import 'package:pudding/core/providers/firebase_providers.dart'
    show firebaseInitProvider;
import 'package:pudding/features/auth/presentation/auth_gate.dart'
    show AuthGate;

class PuddingApp extends ConsumerWidget {
  const PuddingApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pudding',
      navigatorKey: navigatorKey,
      builder: FlutterSmartDialog.init(),
      navigatorObservers: [
        TalkerRouteObserver(logger),
        FlutterSmartDialog.observer,
      ],
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
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
