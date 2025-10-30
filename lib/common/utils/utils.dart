import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/widgets.dart'
    show BuildContext, FocusScope, MediaQuery, TargetPlatform;

/// unfocus on current focusing content of the current context
void unfocus(BuildContext context) => FocusScope.of(context).unfocus();

/// if current screen is bigger than [caps] or not with
/// default is `600`
bool isBigScreen(BuildContext ctx, {int caps = 600}) =>
    MediaQuery.sizeOf(ctx).width > caps;

/// determine that the device is Apple device or not
bool isApple() {
  switch (defaultTargetPlatform) {
    case TargetPlatform.iOS || TargetPlatform.macOS:
      return true;
    default:
      return false;
  }
}
