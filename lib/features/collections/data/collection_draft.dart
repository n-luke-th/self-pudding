import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:flutter_riverpod/flutter_riverpod.dart' show Notifier;
import 'package:pudding/features/collections/data/collection_model.dart';
import 'package:pudding/features/collections/data/visibility_enum.dart';

/// class that contains cooking methods
/// to create the final product of [TheCollection]
/// through the provider
///
/// also known as `CookingCollectionMethods`
class CollectionDraft extends Notifier<TheCollection?> {
  @override
  build() {
    return null;
  }

  bool get isNullNow => state == null;

  TheCollection? get obj => state;

  // set collection(TheCollection c) => state = c;

  /// replace the value to the given [collection]
  void replaceWhole(TheCollection collection) {
    state = collection;
  }

  /// force the value to be `null`
  ///
  /// optionally get a copy of the value before being `null` by set [getCopy] to `true`
  TheCollection? setNull({bool getCopy = false}) {
    final copied = state?.copyWith();
    state = null;
    if (getCopy) {
      return copied;
    }
    return null;
  }

  /// construct new instance of [TheCollection]
  /// intentionally to be a draft instance of final product
  void createDraft({required Timestamp now, required String uid}) {
    state = TheCollection(
      title: "",
      createdAt: now,
      lastUpdatedAt: now,
      id: "",
      ownerId: uid,
      visibility: VisibilityEnum.private,
      tags: const [],
    );
  }

  /// replace current title to [newTitle]
  void updateTitle({required String newTitle, required Timestamp now}) {
    state = state?.copyWith(title: newTitle, lastUpdatedAt: now);
  }

  /// replace important meta data such as
  /// title, tags, etc.
  void updateImportantProps({
    String? newTitle,
    required Timestamp now,
    String? newDes,
    List<String>? tags,
    bool sameCreateUpdateTime = false,
  }) {
    state = state?.copyWith(
      title: newTitle,
      description: newDes,
      lastUpdatedAt: now,
      createdAt: sameCreateUpdateTime ? now : null,
      tags: tags,
    );
  }
}
