import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:pudding/core/firestore_collections_name.dart';
import 'package:pudding/features/collections/data/collection_model.dart';

/// This repository handles all data operations for [TheCollection].
class CollectionsRepository {
  final FirebaseFirestore _firestore;

  CollectionsRepository(this._firestore);

  // Get a real-time stream of collections for a specific user.
  Stream<List<TheCollection>> getCollectionsStreamAsOwner(String userId) {
    return _firestore
        .collection(FirestoreCollectionsName.collections)
        .where('ownerId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => TheCollection.fromFirestore(doc))
              .toList();
        });
  }

  /// Get a real-time stream of collections where user is one of the collaborator(s).
  Stream<List<TheCollection>> getCollectionsStreamAsCollab(String userId) {
    return _firestore
        .collection(FirestoreCollectionsName.collections)
        .where('collaborators', arrayContains: userId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => TheCollection.fromFirestore(doc))
              .toList();
        });
  }

  // Add a new collection document.
  Future<void> addCollection(TheCollection collection) async {
    await _firestore.collection('collections').add(collection.toFirestore());
  }
}
