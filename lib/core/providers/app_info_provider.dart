import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart' show PackageInfo;
import 'package:pudding/core/models/app_info_model.dart';

/// retrieve platform friendly name
String getPlatformName() {
  if (kIsWeb) {
    return 'Web';
  }
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return 'Android';
    case TargetPlatform.iOS:
      return 'iOS';
    case TargetPlatform.windows:
      return 'Windows';
    case TargetPlatform.macOS:
      return 'macOS';
    case TargetPlatform.linux:
      return 'Linux';
    case TargetPlatform.fuchsia:
      return 'Fuchsia';
  }
}

final appInfoProvider = FutureProvider<AppInfoModel>((ref) async {
  // Fetch app info
  final info = await PackageInfo.fromPlatform();

  // Determine the platform
  final platformName = getPlatformName();

  // Return the combined info object
  return AppInfoModel(
    version: info.version,
    buildNumber: info.buildNumber,
    platform: platformName,
  );
});
