import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthStatus {
  final bool success;
  final dynamic content;
  AuthStatus({required this.success, required this.content});
}

class AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepository({required this.firebaseAuth});

  Future<AuthStatus> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthStatus(success: true, content: userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      final String message;
      switch (e.code) {
        case "invalid-credential":
          message = "Wrong email or password.";
        default:
          message = "There was an error logging in. Please try again later.";
      }
      return AuthStatus(success: false, content: message);
    }
  }

  Future<AuthStatus> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthStatus(success: true, content: userCredential.user!.uid);
    } on FirebaseAuthException {
      final message = "Failed to sign up. Please try again later.";
      return AuthStatus(success: false, content: message);
    }
  }

  Future<void> signOut() async {
    firebaseAuth.signOut();
  }

  Future<void> sendPasswordResetLink(String email) async {
    firebaseAuth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() => firebaseAuth.currentUser != null;

  String getCurrentUserId() {
    if (isLoggedIn()) {
      return firebaseAuth.currentUser!.uid;
    } else {
      throw Exception("You are not signed in");
    }
  }

  Future<void> _initializeGoogleSignIn() async {
    return GoogleSignIn.instance.initialize();
  }

  Future<AuthStatus> signInWithGoogle() async {
    await _initializeGoogleSignIn();
    final account = await GoogleSignIn.instance.authenticate(
      scopeHint: ["email", "profile"],
    );

    final GoogleSignInAuthentication gAuth = account.authentication;
    final credential = GoogleAuthProvider.credential(idToken: gAuth.idToken);
    try {
      final UserCredential userCred = await firebaseAuth.signInWithCredential(
        credential,
      );
      return AuthStatus(
        success: true,
        content: userCred.user,
      ); //userCred.user is null for new account
    } on FirebaseAuthException catch (e) {
      final String message;
      switch (e.code) {
        default:
          message = "There was an error logging in. Please try again later.";
      }
      return AuthStatus(success: false, content: message);
    }
  }
}

final Provider<AuthRepository> authRepositoryProvider =
    Provider<AuthRepository>((ref) {
      return AuthRepository(firebaseAuth: FirebaseAuth.instance);
    });
