/// a data model for information of the app retrieved from the pubspec.yaml and native calls
class AppInfoModel {
  final String version;
  final String buildNumber;
  final String platform;

  AppInfoModel({
    required this.version,
    required this.buildNumber,
    required this.platform,
  });

  @override
  String toString() {
    return '$platform v$version${buildNumber.isNotEmpty ? "+$buildNumber" : null}';
  }
}
