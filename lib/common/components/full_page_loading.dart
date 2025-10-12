import 'package:flutter/material.dart'
    show Center, CircularProgressIndicator, Scaffold;

class FullPageLoading {
  const FullPageLoading._();

  /// default loading
  static const Scaffold df = Scaffold(
    body: Center(child: CircularProgressIndicator()),
  );
}
