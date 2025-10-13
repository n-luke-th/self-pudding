import 'package:flutter/widgets.dart';

/// reusable parts such as spacing, radius, etc.
class Parts {
  const Parts._();

  /// EdgeInsets.zero;
  static const zeroEdgeInsets = EdgeInsets.zero;

  /// EdgeInsets.all(4.0);
  static const tinyEdgeInsetsAll = EdgeInsets.all(4.0);

  /// EdgeInsets.all(8.0);
  static const smallEdgeInsetsAll = EdgeInsets.all(8.0);

  /// EdgeInsets.all(16.0)
  static const defaultEdgeInsetsAll = EdgeInsets.all(16.0);

  /// EdgeInsets.all(32.0)
  static const bigEdgeInsetsAll = EdgeInsets.all(32.0);

  /// EdgeInsets.all(64.0)
  static const hugeEdgeInsetsAll = EdgeInsets.all(64.0);

  /// BorderRadius.circular(16.0)
  static final defaultBorderRadius = BorderRadius.circular(16.0);

  /// BorderRadius.circular(25.0)
  static final aboveDefaultBorderRadius = BorderRadius.circular(25.0);

  /// RoundedSuperellipseBorder(borderRadius: aboveDefaultBorderRadius);
  static final defaultShapeOutlinedBorder = RoundedSuperellipseBorder(
    borderRadius: aboveDefaultBorderRadius,
  );
}
