import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

IconButton closeBtn({
  String tooltip = "close",
  double size = 32,
  required void Function()? onPressed,
  Color iconColor = Colors.red,
}) {
  return IconButton(
    tooltip: tooltip, // TODO: localize
    iconSize: 32,
    enableFeedback: true,
    onPressed: onPressed,
    icon: Icon(LucideIcons.circleX600, color: iconColor),
  );
}
