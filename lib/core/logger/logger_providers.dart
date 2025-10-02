export 'package:talker_flutter/talker_flutter.dart'
    show TalkerScreen, TalkerRouteObserver, TalkerWrapper;
import 'package:talker/talker.dart'
    show Talker, TalkerKey, TalkerSettings, TimeFormat;

final logger = Talker(
  // add riverpod observer when support version 3.0.0+
  // observer: null,
  settings: TalkerSettings(
    timeFormat: TimeFormat.yearMonthDayAndTime,
    titles: {TalkerKey.error: 'Pudding error'},
  ),
);
