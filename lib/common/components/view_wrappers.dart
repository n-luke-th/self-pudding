import 'package:blurrycontainer/blurrycontainer.dart' show BlurryContainer;
import 'package:flutter/material.dart';
import 'package:pudding/common/components/drawer_panel.dart';
import 'package:pudding/common/parts.dart';
import 'package:pudding/core/logger/logger_providers.dart'
    show TalkerWrapper, logger;
import 'package:pudding/core/models/appbar_cfg_model.dart' show AppbarCfgModel;
import 'package:talker_flutter/talker_flutter.dart';

/// full page wrapper
Scaffold pageViewWrapper({
  Key? key,
  AppbarCfgModel? appBarCfg,
  Widget? body,
  Widget? floatingActionButton,
  FloatingActionButtonLocation floatingActionButtonLocation =
      FloatingActionButtonLocation.centerFloat,
  FloatingActionButtonAnimator? floatingActionButtonAnimator,
  Widget? bottomNavigationBar,
  Widget? bottomSheet,
  Color? backgroundColor,
  bool extendBody = false,
  bool drawerBarrierDismissible = true,
  bool extendBodyBehindAppBar = false,
  bool showEndDrawer = true,
}) {
  return Scaffold(
    key: key,
    appBar: appBarCfg,
    body: body,
    floatingActionButton: floatingActionButton,
    floatingActionButtonLocation: floatingActionButtonLocation,
    floatingActionButtonAnimator: floatingActionButtonAnimator,
    bottomNavigationBar: bottomNavigationBar,
    bottomSheet: bottomSheet,
    backgroundColor: backgroundColor,
    extendBody: extendBody,
    drawerBarrierDismissible: drawerBarrierDismissible,
    extendBodyBehindAppBar: extendBodyBehindAppBar,
    endDrawer: showEndDrawer == false ? null : DrawerPanel(),
  );
}

/// a full page of error report on screen and log details on console
Scaffold errorPageWrapper({
  Key? key,
  String appBarTitle = "ERROR OCCURRED",
  String errorKey = "Error",
  String errorValue = 'Unexpected error',
  Object? e,
  StackTrace? st,
}) {
  logger.error(errorValue, e, st);
  return pageViewWrapper(
    showEndDrawer: false,
    appBarCfg: AppbarCfgModel(
      titleSpacing: 0.0,
      titleStr: appBarTitle,
      backgroundColor: Colors.red[200],
      overrideActions: const [],
    ),
    body: Center(
      child: TalkerWrapper(
        options: TalkerWrapperOptions(errorTitle: errorKey),
        talker: logger,
        child: Text('$errorKey: $errorValue', maxLines: 2, softWrap: true),
      ),
    ),
  );
}

/// a bar of error report on screen and log details on console
Widget errorBarWrapper({
  String errorKey = "Error",
  String errorValue = 'Unexpected error',
  Object? e,
  StackTrace? st,
}) {
  logger.error(errorValue, e, st);
  return Padding(
    padding: Parts.smallEdgeInsetsAll,
    child: TalkerWrapper(
      options: TalkerWrapperOptions(errorTitle: errorKey),
      talker: logger,
      child: Text('$errorKey: $errorValue', maxLines: 2, softWrap: true),
    ),
  );
}

/// a bar of warning report on screen and log details on console
Widget warningBarWrapper({
  String errorKey = "Warning",
  String errorValue = 'Unexpected error',
  Object? e,
  StackTrace? st,
}) {
  logger.warning(errorValue, e, st);
  return Padding(
    padding: Parts.smallEdgeInsetsAll,
    child: TalkerWrapper(
      options: TalkerWrapperOptions(errorTitle: errorKey),
      talker: logger,
      child: Text('$errorKey: $errorValue', maxLines: 2, softWrap: true),
    ),
  );
}

/// a convenient way for conditional rendering widget based on the screen layout
///
/// default caps at 600 (inclusive) for small layout
LayoutBuilder layoutBuilder({
  required Widget smallLayout,
  required Widget bigLayout,
  int caps = 600,
}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth <= caps) {
        return smallLayout;
      } else {
        return bigLayout;
      }
    },
  );
}

/// creates a blurry background for the given [child]
Widget blurryBackgroundContent({required Widget child, double blur = 2.5}) {
  return Scaffold(
    backgroundColor: Colors.transparent,
    body: BlurryContainer.expand(
      blur: blur,
      padding: Parts.zeroEdgeInsets,
      child: child,
    ),
  );
}
