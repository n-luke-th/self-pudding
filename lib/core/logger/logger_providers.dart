export 'package:talker_flutter/talker_flutter.dart'
    show TalkerScreen, TalkerRouteObserver, TalkerWrapper;
import 'package:talker/talker.dart'
    show Talker, TalkerKey, TalkerSettings, TimeFormat;

final logger = Talker(
  settings: TalkerSettings(
    timeFormat: TimeFormat.yearMonthDayAndTime,
    titles: {TalkerKey.error: 'Pudding error'},
  ),
);
