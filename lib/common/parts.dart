import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';

/// reusable parts such as spacing, radius, etc.
class Parts {
  const Parts._();

  /// full custom offset in [SizingScale] unit
  ///
  /// equivalent to `EdgeInsets.only(left:left.value,right:right.value,top:top.value,bottom:bottom.value)`
  static EdgeInsets customEdgeInsetsFull({
    SizingScale? left,
    SizingScale? right,
    SizingScale? top,
    SizingScale? bottom,
  }) {
    return EdgeInsets.only(
      left: left?.value ?? SizingScale.zero.value,
      right: right?.value ?? SizingScale.zero.value,
      top: top?.value ?? SizingScale.zero.value,
      bottom: bottom?.value ?? SizingScale.zero.value,
    );
  }

  /// custom offset from the left of in [SizingScale] unit
  ///
  /// equivalent to `EdgeInsets.only(left:ss.value)`
  static EdgeInsets customEdgeInsetsLeft(SizingScale ss) =>
      customEdgeInsetsFull(left: ss);

  /// custom offset from the right of in [SizingScale] unit
  ///
  /// equivalent to `EdgeInsets.only(right:ss.value)`
  static EdgeInsets customEdgeInsetsRight(SizingScale ss) =>
      customEdgeInsetsFull(right: ss);

  /// custom offset from the top of in [SizingScale] unit
  ///
  /// equivalent to `EdgeInsets.only(top:ss.value)`
  static EdgeInsets customEdgeInsetsTop(SizingScale ss) =>
      customEdgeInsetsFull(top: ss);

  /// custom offset from the bottom of in [SizingScale] unit
  ///
  /// equivalent to `EdgeInsets.only(bottom:ss.value)`
  static EdgeInsets customEdgeInsetsBottom(SizingScale ss) =>
      customEdgeInsetsFull(bottom: ss);

  /// custom offset vertically of in [SizingScale] unit
  ///
  /// equivalent to `EdgeInsets.symmetric(vertical: ss.value)`
  static EdgeInsets customEdgeInsetsVertical(SizingScale ss) {
    return EdgeInsets.symmetric(vertical: ss.value);
  }

  /// custom offset horizontally of in [SizingScale] unit
  ///
  /// equivalent to `EdgeInsets.symmetric(horizontal: ss.value)`
  static EdgeInsets customEdgeInsetsHorizontal(SizingScale ss) {
    return EdgeInsets.symmetric(horizontal: ss.value);
  }

  /// EdgeInsets.zero;
  static const zeroEdgeInsets = EdgeInsets.zero;

  /// EdgeInsets.all(4.0);
  static const tinyEdgeInsetsAll = EdgeInsets.all(4.0);

  /// EdgeInsets.all(8.0);
  static const smallEdgeInsetsAll = EdgeInsets.all(8.0);

  /// EdgeInsets.all(12.0)
  static const lessMediumEdgeInsetsAll = EdgeInsets.all(12.0);

  /// EdgeInsets.all(16.0)
  static const defaultEdgeInsetsAll = EdgeInsets.all(16.0);

  /// EdgeInsets.all(25.0)
  static const moreMediumEdgeInsetsAll = EdgeInsets.all(25.0);

  /// EdgeInsets.all(32.0)
  static const bigEdgeInsetsAll = EdgeInsets.all(32.0);

  /// EdgeInsets.all(64.0)
  static const hugeEdgeInsetsAll = EdgeInsets.all(64.0);

  /// EdgeInsets.symmetric(vertical: 16.0)
  static const defaultEdgeInsetsVertical = EdgeInsets.symmetric(vertical: 16.0);

  /// EdgeInsets.symmetric(horizontal: 16.0)
  static const defaultEdgeInsetsHorizontal = EdgeInsets.symmetric(
    horizontal: 16.0,
  );

  /// BorderRadius.circular(16.0)
  static final defaultBorderRadius = BorderRadius.circular(16.0);

  /// BorderRadius.circular(25.0)
  static final moreMediumBorderRadius = BorderRadius.circular(25.0);

  /// RoundedSuperellipseBorder(borderRadius: moreMediumBorderRadius);
  static final defaultShapeOutlinedBorder = RoundedSuperellipseBorder(
    borderRadius: moreMediumBorderRadius,
  );

  static final BoxDecoration defaultBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: Parts.defaultBorderRadius,
    boxShadow: [
      BoxShadow(color: Colors.grey, blurRadius: 8, spreadRadius: 0.2),
    ],
  );
}

/// enum for sizing scale commonly used in defining such value in UI elements
enum SizingScale {
  // listing from less to more

  /// zero(0.0)
  zero(0.0),

  /// tiny(4.0)
  tiny(4.0),

  /// small(8.0)
  small(8.0),

  /// less medium(12.0)
  lessMedium(12.0),

  /// default(16.0)
  df(16.0),

  /// more medium(25.0)
  moreMedium(25.0),

  /// big(32.0)
  big(32.0),

  /// huge(64.0)
  huge(64.0);

  final double value;

  const SizingScale(this.value);

  /// method to get sizing scale value from [SizingScale] enum
  static double getValueFromSS(SizingScale ss) {
    return ss.value;
  }
}
