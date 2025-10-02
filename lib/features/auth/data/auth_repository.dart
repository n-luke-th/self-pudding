import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pudding/core/firebase_providers.dart';
import 'package:pudding/core/logger/logger_providers.dart';

// The AuthRepository is responsible for handling authentication logic.
class AuthRepository {
  final FirebaseAuth _auth;

  AuthRepository(this._auth);

  // A stream to listen to authentication state changes.
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// method for sign-in with given email and password.
  Future<void> signInWithEmail({
    required String email,
    required String pwd,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: pwd);
    } catch (e, st) {
      // TODO: handle this error properly.
      logger.handle(e, st, "Sign-in with email process has error");
    } finally {
      logger.verbose("sign-in with email process done");
    }
  }

  /// A simple method for anonymous sign-in.
  Future<void> signInAnonymously() async {
    try {
      await _auth.signInAnonymously();
    } catch (e, st) {
      // TODO: handle this error properly.

      logger.handle(e, st, "Sign in anonymously process has error");
    } finally {
      logger.verbose("sign-in anonymously process done");
    }
  }

  String? get currentUserId => _auth.currentUser?.uid;
}
