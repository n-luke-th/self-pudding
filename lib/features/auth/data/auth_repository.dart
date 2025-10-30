import 'package:firebase_auth/firebase_auth.dart';
import 'package:pudding/core/logger/logger_providers.dart';

// The AuthRepository is responsible for handling authentication logic.
class AuthRepository {
  final FirebaseAuth _auth;

  AuthRepository(this._auth);

  // A stream to listen to authentication state changes.
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  bool get isSignIn => currentUser != null;

  String? get currentUserId => _auth.currentUser?.uid;

  List<UserInfo>? get currentUserProvidersData =>
      _auth.currentUser?.providerData;

  String? get currentUserDisplayName => _auth.currentUser?.displayName;

  String? get currentUserEmail => _auth.currentUser?.email;

  String? get currentUserProfilePicUrl => _auth.currentUser?.photoURL;

  DateTime? get userAccCreationTime => _auth.currentUser?.metadata.creationTime;

  DateTime? get userLastSignInTime =>
      _auth.currentUser?.metadata.lastSignInTime;

  bool? get currentUserIsEmailVerified => _auth.currentUser?.emailVerified;

  String? get currentLanguageCode => _auth.languageCode;

  String? get currentUserDisplayNameOrEmail =>
      isSignIn ? (currentUserDisplayName ?? currentUserEmail) : null;

  /// method for create an account with email and password
  Future<UserCredential> signUpWithEmail({
    required String email,
    required String pwd,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pwd,
      );
    } catch (e, st) {
      logger.error("Sign-up with email process has error", e, st);
      rethrow;
    } finally {
      logger.verbose("sign-up with email process done");
    }
  }

  /// method for sign-in with given email and password
  Future<UserCredential> signInWithEmail({
    required String email,
    required String pwd,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: pwd,
      );
    } catch (e, st) {
      logger.error("Sign-in with email process has error", e, st);
      rethrow;
    } finally {
      logger.verbose("sign-in with email process done");
    }
  }

  /// A simple method for anonymous sign-in
  Future<UserCredential> signInAnonymously() async {
    try {
      return await _auth.signInAnonymously();
    } catch (e, st) {
      logger.error("Sign in anonymously process has error", e, st);
      rethrow;
    } finally {
      logger.verbose("sign-in anonymously process done");
    }
  }

  /// signs user out of the session
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e, st) {
      logger.error("Sign out process has error", e, st);
      rethrow;
    } finally {
      logger.verbose("sign out process done");
    }
  }

  static String getReadableErrorMessageDetails(FirebaseAuthException e) {
    switch (e.code) {
      /// below are shared cases
      case 'invalid-email':
        return 'The provided email address is not valid.';
      case "operation-not-allowed":
        return "The requested operation is not allowed";
      case 'weak-password':
        return 'The password provided is too weak.';
      case "user-disabled":
        return "This account is currently disabled, please contact our support.";
      case 'email-already-in-use':
        return 'There is already an account exists with this email.';
      case "invalid-credential":
        return "Given credential is incorrect, malformed or has expired.";

      /// below are sign in related
      case 'user-not-found':
        return 'No user found with provided credentials';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case "invalid-verification-code":
        return "the verification code of the credential is not valid.";

      /// below are forgot password related
      case "auth/invalid-email":
        return "The provided email address is not valid.";
      case "auth/missing-android-pkg-name":
        return "An Android package name must be provided if the Android app is required to be installed.";
      case "auth/missing-continue-uri":
        return "A continue URL must be provided in the request.";
      case "auth/missing-ios-bundle-id":
        return "An iOS Bundle ID must be provided if an App Store ID is provided.";
      case "auth/invalid-continue-uri":
        return "The continue URL provided in the request is invalid.";
      case "auth/unauthorized-continue-uri":
        return "The domain of the continue URL is not whitelisted. Whitelist the domain in the Firebase console.";
      case "auth/user-not-found":
        return "No user account found that is associated with the provided email address";
      case "expired-action-code":
        return "Given code has expired.";
      case "invalid-action-code":
        return "Given code is invalid, likely the code is malformed or has already been used";

      /// others
      case "requires-recent-login":
        return "You are required to verify your identity before process.";
      case "user-token-expired" || "auth/user-token-expired":
        return "Login credential is no longer valid, please logout & sign in again.";

      /// default error msg
      default:
        return e.message!;
    }
  }
}
