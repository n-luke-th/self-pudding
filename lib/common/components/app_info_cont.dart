import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pudding/common/components/view_wrappers.dart'
    show warningBarWrapper;
import 'package:pudding/common/parts.dart';
import 'package:pudding/core/models/app_info_model.dart';
import 'package:pudding/core/providers/app_info_provider.dart'
    show appInfoProvider;

class AppInfoCont extends ConsumerWidget {
  final BoxDecoration? containerDecoration;
  const AppInfoCont({super.key, this.containerDecoration});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appInfoAsyncValue = ref.watch(appInfoProvider);
    return appInfoAsyncValue.maybeWhen(
      data: (data) => cont(context, data),
      error: (error, stackTrace) => _reportErr(error: error, st: stackTrace),
      orElse: () => _reportErr(),
    );
  }

  Widget _reportErr({Object? error, StackTrace? st, String? optionalStr}) {
    return warningBarWrapper(
      e: error,
      st: st,
      errorValue: optionalStr ?? "Failed to load version",
      errorKey: "Package info error",
    );
  }

  Widget cont(BuildContext ctx, AppInfoModel data) {
    return Container(
      width: MediaQuery.sizeOf(ctx).width,
      decoration: containerDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("running on ${data.platform}"),
          Text("v${data.version}"),
        ],
      ),
    ).blurry(
      blur: 10,
      elevation: 16,
      color: Colors.transparent,
      padding: Parts.defaultEdgeInsetsAll,
    );
  }
}
