import 'package:flutter/widgets.dart' show FocusScope, BuildContext, MediaQuery;

/// unfocus on current focusing content of the current context
void unfocus(BuildContext context) => FocusScope.of(context).unfocus();

/// if current screen is bigger than [caps] or not with
/// default is `600`
bool isBigScreen(BuildContext ctx, {int caps = 600}) =>
    MediaQuery.sizeOf(ctx).width > caps;
