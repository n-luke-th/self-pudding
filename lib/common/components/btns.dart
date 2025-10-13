import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pudding/common/parts.dart';

/// a beautiful close button component
IconButton closeBtn({
  String tooltip = "close",
  double size = 40,
  required void Function()? onPressed,
  Color iconColor = Colors.red,
}) {
  return IconButton(
    tooltip: tooltip, // TODO: localize
    iconSize: size,
    enableFeedback: true,
    onPressed: onPressed,
    icon: Icon(LucideIcons.circleX600, color: iconColor),
  );
}

/// big size button with text only
Padding bigTextOnlyBtn({
  required void Function()? onPressed,
  bool addPadding = true,
  Text text = const Text("BTN"),
}) {
  return Padding(
    padding: addPadding ? Parts.smallEdgeInsetsAll : Parts.zeroEdgeInsets,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: Parts.defaultShapeOutlinedBorder,
        enableFeedback: true,
        elevation: 16,
        minimumSize: const Size.square(65),
      ),
      onPressed: onPressed,
      child: text,
    ),
  );
}

/// default size button with text and icon
ElevatedButton defaultTextIconBtn({
  required void Function()? onPressed,
  required Text text,
  Widget? icon,
  IconAlignment? iconAlignment,
}) {
  return ElevatedButton.icon(
    onPressed: onPressed,
    label: text,
    icon: icon,
    iconAlignment: iconAlignment,
  );
}

FilledButton filledTextIconBtn({
  required void Function()? onPressed,
  required Text text,
  Widget? icon,
  IconAlignment? iconAlignment,
}) {
  return FilledButton.icon(
    onPressed: onPressed,
    label: text,
    icon: icon,
    iconAlignment: iconAlignment,
  );
}
