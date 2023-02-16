import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // eklendi 4.01

  Future<User?> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }
  // Future<User> changePassword(String password) async {
  //   var user = await _auth.currentUser!.updatePassword(password);
  //   await _auth.signOut();
  //   return user.user;
  // }

  signOut() async {
    return await _auth.signOut();
  }

  Future<void> deleteUser() async {
    if (_auth.currentUser != null) {
      await _firestore
          .collection("Person")
          .doc(_auth.currentUser!.uid)
          .delete();
      await _auth.currentUser!.delete();
    } else {
      debugPrint('Kullanici oturum acmadigi icin silinemez');
    }
  }

  Future<User?> createPerson(String name, String email, String password) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    //FIRESTORE SİLME EKLEME İŞLEMİ
    await _firestore
        .collection("Person")
        .doc(user.user?.uid)
        .set({'userName': name, 'email': email});

    return user.user;
  }
}
