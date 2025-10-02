import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pudding/core/firebase_providers.dart' show firestoreProvider;
import 'package:pudding/features/puddings/data/pudding_model.dart';
import 'package:pudding/features/puddings/data/puddings_repository.dart';

/// Provider for the [PuddingsRepository].
final puddingsRepositoryProvider = Provider<PuddingsRepository>((ref) {
  return PuddingsRepository(ref.watch(firestoreProvider));
});

/// A StreamProvider that needs to take an argument (the collectionId).
/// We use the ".family" modifier for this.
final puddingsStreamProvider = StreamProvider.autoDispose
    .family<List<Pudding>, String>((ref, collectionId) {
      // We pass the collectionId to the repository method.
      return ref
          .watch(puddingsRepositoryProvider)
          .getPuddingsStream(collectionId);
    });
