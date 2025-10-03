import 'package:flutter/material.dart';
import 'package:pudding/core/components/drawer_panel.dart';
import 'package:pudding/core/logger/logger_providers.dart'
    show TalkerWrapper, logger;
import 'package:pudding/core/models/appbar_cfg_model.dart' show AppbarCfgModel;

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
    endDrawer: DrawerPanel(),
  );
}

Scaffold errorPageWrapper({
  Key? key,
  String appBarTitle = "ERROR OCCURRED",
  String e = 'Unexpected error',
}) {
  return pageViewWrapper(
    appBarCfg: AppbarCfgModel(
      titleSpacing: 0.0,
      titleStr: appBarTitle,
      backgroundColor: Colors.red[200],
    ),
    body: Center(
      child: TalkerWrapper(talker: logger, child: Text('Error: $e')),
    ),
  );
}
