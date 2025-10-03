import 'package:flutter/material.dart'
    show AppBar, Text, Widget, EndDrawerButton;

class AppbarCfgModel extends AppBar {
  final String titleStr;
  AppbarCfgModel({
    super.key,
    // super.actions,
    super.actionsIconTheme,
    super.actionsPadding,
    super.animateColor,
    super.automaticallyImplyLeading,
    super.backgroundColor,
    // super.title,
    super.bottom,
    super.bottomOpacity,
    super.centerTitle,
    super.clipBehavior,
    super.elevation,
    super.excludeHeaderSemantics,
    super.flexibleSpace,
    super.forceMaterialTransparency,
    super.foregroundColor,
    super.iconTheme,
    super.leading,
    super.leadingWidth,
    super.notificationPredicate,
    super.primary,
    super.scrolledUnderElevation,
    super.shadowColor,
    super.shape,
    super.surfaceTintColor,
    super.systemOverlayStyle,
    super.titleSpacing,
    super.titleTextStyle,
    super.toolbarHeight,
    super.toolbarOpacity,
    super.toolbarTextStyle,
    super.useDefaultSemanticsOrder,
    this.titleStr = "Pudding",
  });

  @override
  Widget? get title => Text(titleStr);

  @override
  List<Widget>? get actions => [EndDrawerButton()];
}
