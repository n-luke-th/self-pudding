import 'dart:async' show runZonedGuarded;

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pudding/core/logger/logger_providers.dart' show logger;
import 'package:pudding/pudding_app.dart' show PuddingApp;
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
