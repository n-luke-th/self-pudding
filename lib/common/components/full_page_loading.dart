import 'package:flutter/material.dart'
    show Center, CircularProgressIndicator, Scaffold;

/// all in one class to handle full page loading indicator
///
/// for overlay indicator please refer for `loading_overlay.dart`
class FullPageLoading {
  const FullPageLoading._();

  /// default loading
  static const Scaffold df = Scaffold(
    body: Center(child: CircularProgressIndicator()),
  );
}
