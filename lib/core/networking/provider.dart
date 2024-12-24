import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:design_pattern/core/model/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  // Singleton instance
  static final UserProvider _instance = UserProvider._internal();

  // Factory constructor to return the same instance
  factory UserProvider() => _instance;

  // Private constructor
  UserProvider._internal();

  // Firebase services
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  static const String usersCollection = "users";

  Future<void> signUp(String name, String email, String password) async {
    _setLoading(true);
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        AuthModel authModel = AuthModel(
          id: currentUser.uid,
          name: name,
          email: email,
          role: "receptionist", // Default: receptionist role
        );
        await _firestore.collection(usersCollection).doc(currentUser.uid).set(authModel.toMap());
      } else {
        throw Exception("User creation failed");
      }
    } on FirebaseAuthException catch (error) {
      _handleFirebaseError(error);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> login(String email, String password) async {
    _setLoading(true);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      _handleFirebaseError(error);
    } finally {
      _setLoading(false);
    }
  }

  Future<AuthModel?> getUserData() async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      throw Exception("No user is currently signed in");
    }

    final userDoc = await _firestore.collection(usersCollection).doc(currentUser.uid).get();
    if (userDoc.exists) {
      final data = userDoc.data()!;
      return AuthModel.fromMap({
        ...data,
        'role': data['role'] ?? "receptionist", // Default role
      });
    } else {
      throw Exception("User data not found in the database");
    }
  }

  Future<bool> isUserAdmin() async {
    final userData = await getUserData();
    return userData?.role == 'admin'; // Check if the user is an admin
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _handleFirebaseError(FirebaseAuthException error) {
    if (error.code == "invalid-email") {
      throw Exception("Invalid email");
    } else if (error.code == "weak-password") {
      throw Exception("Password too weak");
    } else if (error.code == "user-not-found") {
      throw Exception("No user found for that email");
    } else if (error.code == "wrong-password") {
      throw Exception("Incorrect password");
    } else {
      throw Exception("Operation failed: ${error.message}");
    }
  }
}
