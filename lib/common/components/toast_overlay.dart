import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pudding/common/parts.dart';
import 'package:pudding/core/logger/logger_providers.dart';

/// all in one class to handle custom toast/notification banner
///
class ToastOverlay {
  const ToastOverlay._();
  static const Duration displayTime = Duration(seconds: 3);

  static Future<void> _show({
    required Widget Function(BuildContext) builder,
  }) async => await SmartDialog.show(
    displayTime: displayTime,
    useAnimation: true,
    builder: builder,
  );

  /// display the generic toast
  ///
  /// for combination of show toast and some actions please refer to file `show_and.dart`
  static Future<void> showGeneralToast({
    required String msg,
    String? details,
  }) async {
    return await _show(
      builder: (_) =>
          CustomToast(msg: msg, type: ToastType.generic, msgDetails: details),
    );
  }

  /// display the success toast
  static Future<void> showSuccessToast({
    required String msg,
    String? details,
  }) async {
    return await _show(
      builder: (_) =>
          CustomToast(msg: msg, msgDetails: details, type: ToastType.success),
    );
  }

  /// display the error toast
  ///
  /// for combination of show toast and some actions please refer to file `show_and.dart`
  static Future<void> showErrorToast({
    required String msg,
    String? details,
  }) async {
    return await _show(
      builder: (_) =>
          CustomToast(msg: msg, type: ToastType.error, msgDetails: details),
    );
  }
}

/// used to distinguish different types of toast to display
enum ToastType {
  /// success
  ///
  /// e.g. attempt to such operation is done/success without errors
  success,

  /// failure
  ///
  /// e.g. attempt to such operation is failed to complete
  failure,

  /// warning
  ///
  /// e.g. attempt to such operation is done with warning
  warning,

  /// error
  ///
  /// e.g. attempt to such operation occurred an error or errors
  error,

  /// info
  ///
  /// e.g. such operation displays more information
  info,

  /// generic
  ///
  /// a generic
  generic,
}

// TODO: customize this

/// custom design toast
/// with details panel on-the-go
class CustomToast extends StatelessWidget {
  final ToastType type;
  final String msg;
  final String? msgDetails;
  final Alignment alignment;
  final Icon? overrideIcon;
  final Color? overrideBgColor;
  const CustomToast({
    super.key,
    required this.msg,
    this.msgDetails,
    this.type = ToastType.info,
    this.alignment = Alignment.topCenter,
    this.overrideIcon,
    this.overrideBgColor,
  });

  Icon getIcon() {
    if (overrideIcon != null) {
      return overrideIcon!;
    }
    switch (type) {
      case ToastType.warning:
        return const Icon(LucideIcons.badgeAlert600, color: Colors.black54);
      case ToastType.error:
        return const Icon(LucideIcons.badgeX600, color: Colors.black54);
      case ToastType.failure:
        return const Icon(LucideIcons.circleSlash600, color: Colors.black54);
      case ToastType.info:
        return const Icon(LucideIcons.badgeInfo600, color: Colors.black54);
      case ToastType.success:
        return const Icon(LucideIcons.badgeCheck600, color: Colors.black54);
      case ToastType.generic:
        return const Icon(LucideIcons.bellRing600, color: Colors.black54);
    }
  }

  Color getColor() {
    if (overrideBgColor != null) return overrideBgColor!;
    switch (type) {
      case ToastType.warning:
        return Colors.deepOrange;
      case ToastType.error:
        return Colors.red;
      case ToastType.failure:
        return Colors.blueGrey;
      case ToastType.info:
        return Colors.tealAccent;
      case ToastType.success:
        return Colors.lightGreen;
      case ToastType.generic:
        return Colors.indigoAccent;
    }
  }

  @override
  Widget build(BuildContext _) {
    logger.verbose("${type.name} toast shown: $msg; $msgDetails");

    return SafeArea(
      child: Align(
        alignment: alignment,
        child: InkWell(
          onTap: () async => await showDetailsPanel(),
          child: Container(
            margin: Parts.tinyEdgeInsetsAll,
            padding: Parts.defaultEdgeInsetsAll,
            decoration: BoxDecoration(
              color: getColor(),
              borderRadius: Parts.moreMediumBorderRadius,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                //icon
                Container(
                  margin: Parts.customEdgeInsetsRight(SizingScale.small),
                  child: getIcon(),
                ),

                //msg
                Text(msg, softWrap: true),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showDetailsPanel() async {
    return await SmartDialog.show(
      alignment: Alignment.bottomCenter,
      builder: (ctx) {
        logger.verbose("${type.name} toast details panel shown: $msgDetails");

        return GlassContainer.clearGlass(
          borderRadius: Parts.moreMediumBorderRadius,
          height: MediaQuery.sizeOf(ctx).height * 0.4,
          width: MediaQuery.sizeOf(ctx).height * 0.8,
          gradient: LinearGradient(
            colors: [
              getColor().withValues(alpha: 0.2),
              getColor().withValues(alpha: 0.4),
              getColor().withValues(alpha: 0.6),
              getColor().withValues(alpha: 0.8),
              getColor().withValues(alpha: 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          margin: Parts.smallEdgeInsetsAll,
          padding: Parts.smallEdgeInsetsAll,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                msg,
                style: Theme.of(ctx).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              if (msgDetails != null)
                Text(msgDetails!, textAlign: TextAlign.center),
            ],
          ),
        );
      },
    );
  }
}
