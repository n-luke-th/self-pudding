import 'package:flutter/widgets.dart';

/// reusable parts such as spacing, radius, etc.
class Parts {
  const Parts._();

  /// EdgeInsets.all(8.0);
  static const smallEdgeInsetsAll = EdgeInsets.all(8.0);

  /// EdgeInsets.all(16.0)
  static const defaultEdgeInsetsAll = EdgeInsets.all(16.0);

  /// BorderRadius.circular(16.0)
  static final defaultBorderRadius = BorderRadius.circular(16.0);

  /// BorderRadius.circular(25.0)
  static final aboveDefaultBorderRadius = BorderRadius.circular(25.0);

  /// RoundedSuperellipseBorder(borderRadius: aboveDefaultBorderRadius);
  static final defaultShapeOutlinedBorder = RoundedSuperellipseBorder(
    borderRadius: aboveDefaultBorderRadius,
  );
}
