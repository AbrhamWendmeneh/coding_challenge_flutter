import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email. Please register first.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
      return null;
    } catch (e) {
      debugPrint('Error occurred while signing in: $e');
      return null;
    }
  }

  // Register with email and password
  Future<User?> register(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      debugPrint('Error occurred while registering: $e');
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint('Error occurred while signing out: $e');
    }
  }

  // Get current user
  User? currentUser() {
    try {
      return _auth.currentUser;
    } catch (e) {
      debugPrint('Error occurred while getting current user: $e');
      return null;
    }
  }

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }
}
