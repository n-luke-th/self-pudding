import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:flutter_riverpod/flutter_riverpod.dart' show Notifier;
import 'package:pudding/features/collections/data/collection_model.dart';
import 'package:pudding/features/collections/data/visibility_enum.dart';

class CollectionDraft extends Notifier<TheCollection?> {
  @override
  build() {
    return null;
  }

  bool get isNullNow => state == null;

  TheCollection? get obj => state;

  // set collection(TheCollection c) => state = c;

  void replaceWhole(TheCollection collection) {
    state = collection;
  }

  TheCollection? setNull({bool getCopy = false}) {
    final copied = state?.copyWith();
    state = null;
    if (getCopy) {
      return copied;
    }
    return null;
  }

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
    state?.copyWith(title: newTitle, lastUpdatedAt: now);
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
    state?.copyWith(
      title: newTitle,
      description: newDes,
      lastUpdatedAt: now,
      createdAt: sameCreateUpdateTime ? now : null,
      tags: tags,
    );
  }
}
