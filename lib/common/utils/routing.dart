import 'package:flutter/material.dart'
    show BuildContext, MaterialPageRoute, Navigator, RouteSettings;
import 'package:pudding/core/logger/logger_providers.dart'
    show TalkerScreen, logger;
import 'package:pudding/features/collections/data/collection_model.dart';
import 'package:pudding/features/puddings/presentation/puddings_screen.dart';

/// a class that use for routing between pages
class Routing {
  const Routing._();

  /// pop the last page in the stack
  static void popPage(BuildContext context) {
    return Navigator.of(context).pop();
  }

  /// push to the developer logs page
  static Future<Object> pushToDevLogPage(BuildContext context) async {
    return await Navigator.of(context).push(
      MaterialPageRoute(
        settings: RouteSettings(name: "dev-log"),
        builder: (context) => TalkerScreen(talker: logger),
      ),
    );
  }

  /// push to the puddings list page in a specific collection
  static Future<Object> pushToPuddingsScreen(
    BuildContext context, {
    required TheCollection collection,
  }) async {
    return await Navigator.of(context).push(
      MaterialPageRoute(
        settings: RouteSettings(name: collection.id),

        builder: (context) => PuddingsScreen(
          collectionId: collection.id,
          collectionTitle: collection.title,
        ),
      ),
    );
  }
}
