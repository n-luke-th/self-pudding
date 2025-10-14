import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pudding/common/parts.dart';

/// a beautiful close icon button component
IconButton closeIconBtn({
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

/// an icon button for edit and read only mode swither
///
/// [look]=>  1 for filled, 2 for tonal, 0 or any other for outlined,
/// please check the localize text to match the locale
IconButton editableModeIconBtnSwitch({
  int look = 0,
  required void Function()? onPressed,
  required bool isSelected,
  List<String> tooltip = const ["read only mode", 'edit mode'],
  double size = 32,
}) {
  final style = IconButton.styleFrom(enableFeedback: true, iconSize: size);
  const editableIcon = Icon(LucideIcons.pencil);
  const readOnlyIcon = Icon(LucideIcons.pencilOff);
  switch (look) {
    case 1:
      return IconButton.filled(
        style: style,
        onPressed: onPressed,
        icon: editableIcon,
        selectedIcon: readOnlyIcon,
        tooltip: tooltip[isSelected ? 0 : 1],
        isSelected: isSelected,
      );
    case 2:
      return IconButton.filledTonal(
        style: style,
        onPressed: onPressed,
        icon: editableIcon,
        selectedIcon: readOnlyIcon,
        tooltip: tooltip[isSelected ? 0 : 1],
        isSelected: isSelected,
      );
    default:
      return IconButton.outlined(
        style: style,
        onPressed: onPressed,
        icon: editableIcon,
        selectedIcon: readOnlyIcon,
        tooltip: tooltip[isSelected ? 0 : 1],
        isSelected: isSelected,
      );
  }
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
    style: ElevatedButton.styleFrom(enableFeedback: true),
    onPressed: onPressed,
    label: text,
    icon: icon,
    iconAlignment: iconAlignment,
  );
}

/// secondary(outlined) style text and icon button
OutlinedButton secondaryTextIconBtn({
  required void Function()? onPressed,
  required Text text,
  Widget? icon,
  IconAlignment? iconAlignment,
}) {
  return OutlinedButton.icon(
    style: OutlinedButton.styleFrom(enableFeedback: true),
    onPressed: onPressed,
    label: text,
    icon: icon,
    iconAlignment: iconAlignment,
  );
}

/// filled style text and icon button
FilledButton filledTextIconBtn({
  required void Function()? onPressed,
  required Text text,
  Widget? icon,
  IconAlignment? iconAlignment,
  bool tonal = false,
}) {
  final style = FilledButton.styleFrom(enableFeedback: true);
  if (tonal) {
    return FilledButton.tonalIcon(
      style: style,
      onPressed: onPressed,
      label: text,
      icon: icon,
      iconAlignment: iconAlignment,
    );
  } else {
    return FilledButton.icon(
      style: style,
      onPressed: onPressed,
      label: text,
      icon: icon,
      iconAlignment: iconAlignment,
    );
  }
}
