import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:firebase_core/firebase_core.dart' show Firebase, FirebaseApp;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show Provider, FutureProvider;
import 'package:pudding/firebase_options.dart' show DefaultFirebaseOptions;

/* 
simple providers to expose the Firebase instances.
use this so we don't have to write `.instance` everywhere.

 */
/// Firebase init app
final firebaseInitProvider = FutureProvider<FirebaseApp>((ref) async {
  return await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
});

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});
