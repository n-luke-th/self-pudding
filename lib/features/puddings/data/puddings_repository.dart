import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:pudding/core/utils/firestore_collections_name.dart';
import 'package:pudding/features/puddings/data/pudding_model.dart';

/// Handles data operations for [Pudding] within a subcollection.
class PuddingsRepository {
  final FirebaseFirestore _firestore;

  PuddingsRepository(this._firestore);

  /// Get a real-time stream of multiple [Pudding] from a specific collection's subcollection.
  Stream<List<Pudding>> getPuddingsStream(
    String collectionId, {
    bool desc = true,
  }) {
    return _firestore
        .collection(FirestoreCollectionsName.collections)
        .doc(collectionId)
        .collection(
          FirestoreCollectionsName.puddings,
        ) // Accessing the subcollection
        .orderBy('timestamp', descending: desc)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Pudding.fromFirestore(doc))
              .toList();
        });
  }

  /// Add a new [pudding] to the subcollection.
  Future<void> addPudding(String collectionId, Pudding pudding) async {
    await _firestore
        .collection(FirestoreCollectionsName.collections)
        .doc(collectionId)
        .collection(FirestoreCollectionsName.puddings)
        .add(pudding.toFirestore());
  }
}
