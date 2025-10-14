import 'package:flutter/material.dart' show GlobalKey, NavigatorState;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

NavigatorState get nav => navigatorKey.currentState!;
