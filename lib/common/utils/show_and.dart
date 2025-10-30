import 'package:pudding/common/components/toast_overlay.dart';
import 'package:pudding/core/logger/logger_providers.dart';

/// log error and display the error toast
Future<void> showErrorToastAndLog({
  Object? e,
  StackTrace? st,
  String msg = "error",
  String? msgDetails,
}) async {
  logger.error(msg, e, st);
  return await ToastOverlay.showErrorToast(msg: msg, details: msgDetails);
}

/// log msg and display the success toast
Future<void> showSuccessToastAndLog({
  String msg = "Success",
  String? msgDetails,
}) async {
  logger.verbose(msg);
  return await ToastOverlay.showSuccessToast(msg: msg, details: msgDetails);
}

// TODO: add other toast type (e.g. success)
