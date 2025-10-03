import 'package:flutter_riverpod/flutter_riverpod.dart'
    show Provider, StreamProvider;
import 'package:pudding/core/providers/firebase_providers.dart'
    show firestoreProvider;
import 'package:pudding/features/auth/providers/auth_providers.dart'
    show userIdProvider;
import 'package:pudding/features/collections/data/collection_model.dart';
import 'package:pudding/features/collections/data/collections_repository.dart'
    show CollectionsRepository;

/// Provider for the [CollectionsRepository].

final collectionsRepositoryProvider = Provider<CollectionsRepository>((ref) {
  return CollectionsRepository(ref.watch(firestoreProvider));
});

/// A StreamProvider that provides the list of collections for the current user.
/// It watches the userIdProvider, so if the user changes, this stream will rebuild.
final collectionsStreamProviderAsOwner =
    StreamProvider.autoDispose<List<TheCollection>>((ref) {
      final userId = ref.watch(userIdProvider);
      if (userId == null) {
        // If no user is logged in, return an empty stream.
        return Stream.value([]);
      }
      // Otherwise, get the stream from the repository.
      return ref
          .watch(collectionsRepositoryProvider)
          .getCollectionsStreamAsOwner(userId);
    });

/// A StreamProvider that provides the list of collections for that current user is one of the collaborator(s).
/// It watches the userIdProvider, so if the user changes, this stream will rebuild.
final collectionsStreamProviderAsCollab =
    StreamProvider.autoDispose<List<TheCollection>>((ref) {
      final userId = ref.watch(userIdProvider);
      if (userId == null) {
        // If no user is logged in, return an empty stream.
        return Stream.value([]);
      }
      // Otherwise, get the stream from the repository.
      return ref
          .watch(collectionsRepositoryProvider)
          .getCollectionsStreamAsCollab(userId);
    });
