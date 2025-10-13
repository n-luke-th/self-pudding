import 'package:pudding/common/components/toast_overlay.dart';
import 'package:pudding/core/logger/logger_providers.dart';

/// log error and display the error
Future<void> showErrorToastAndLog({
  Object? e,
  StackTrace? st,
  String msg = "error",
  String? msgDetails,
}) async {
  logger.error(msg, e, st);
  return await ToastOverlay.showErrorToast(msg: msg, details: msgDetails);
}
