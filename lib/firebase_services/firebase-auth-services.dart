import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Registers a user with email and password, then stores additional user data in Firestore
  Future<User?> signUpWithEmailAndPassword(
      String name, String email, String phone, String password) async {
    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      print("All fields are required.");
      return null;
    }

    try {

      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );


      String uid = credential.user!.uid;


      await _firestore.collection('Users').doc(uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'uid': uid,
      });


      User? user = credential.user;
      await user?.updateDisplayName(name);
      await user?.reload();

      return user;
    } on FirebaseAuthException catch (e) {


      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else {
        print('Some error occurred: ${e.message}');
      }
      return null;
    } catch (e) {
      print("Unexpected error: $e");
      return null;
    }
  }

  /// Signs in a user with email and password
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      print("Email and password fields cannot be empty.");
      return null;
    }

    try {

      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      return credential.user;
    } on FirebaseAuthException catch (e) {


      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print('Some error occurred: ${e.message}');
      }
      return null;
    } catch (e) {
      print("Unexpected error: $e");
      return null;
    }
  }
}
