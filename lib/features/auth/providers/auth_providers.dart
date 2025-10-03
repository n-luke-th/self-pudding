import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show Provider, StreamProvider;
import 'package:pudding/core/providers/firebase_providers.dart'
    show firebaseAuthProvider;
import 'package:pudding/features/auth/data/auth_repository.dart'
    show AuthRepository;

/// Provider for the AuthRepository itself.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(firebaseAuthProvider));
});

/// A StreamProvider that listens to the auth state.
/// will watch this to know if a user is logged in or out.
final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});

/// A simple provider to get the current user's ID.
final userIdProvider = Provider<String?>((ref) {
  return ref.watch(authRepositoryProvider).currentUserId;
});
