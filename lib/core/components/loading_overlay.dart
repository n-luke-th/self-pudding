import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:pudding/core/components/page_view_wrappers.dart';

class LoadingOverlay {
  const LoadingOverlay._();

  static void showDefaultLoading() async {
    await SmartDialog.showLoading(
      animationType: SmartAnimationType.scale,
      useAnimation: true,
      maskWidget: Placeholder(),
      builder: (_) => const Center(child: FlutterLogo()),
    );
  }

  static void dismissLoading() async {
    await SmartDialog.dismiss(status: SmartStatus.loading);
  }

  static Widget showFullPageLoading() {
    return pageViewWrapper(body: Center());
  }
}
