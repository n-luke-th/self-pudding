import 'package:flutter/material.dart' show MaterialPageRoute, RouteSettings;
import 'package:pudding/core/logger/logger_providers.dart'
    show TalkerScreen, logger;
import 'package:pudding/core/navigation/navigation.dart';
import 'package:pudding/features/collections/data/collection_model.dart';
import 'package:pudding/features/collections/presentation/cooking_collection_screen.dart';
import 'package:pudding/features/puddings/presentation/puddings_screen.dart';

/// a class that use for routing between pages
class Routing {
  const Routing._();

  /// pop the last page in the stack
  static void popPage() {
    return nav.pop();
  }

  /// push to the developer logs page
  static Future<Object?> pushToDevLogPage() async {
    return await nav.push(
      MaterialPageRoute(
        settings: RouteSettings(name: "dev-log"),
        builder: (_) => TalkerScreen(talker: logger, appBarTitle: "Dev log"),
      ),
    );
  }

  /// push to the puddings list page in a specific collection
  static Future<Object?> pushToPuddingsScreen({
    required TheCollection collection,
  }) async {
    return await nav.push(
      MaterialPageRoute(
        settings: RouteSettings(name: collection.id),
        builder: (_) => PuddingsScreen(
          collectionId: collection.id,
          collectionTitle: collection.title,
        ),
      ),
    );
  }

  /// push to the editable draft of the collection
  static Future<Object?> pushToCollectionDraftScreen() async {
    return await nav.push(
      MaterialPageRoute(
        settings: RouteSettings(name: 'collection-draft'),
        builder: (_) => const CookingCollectionScreen(),
      ),
    );
  }
}
