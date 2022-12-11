import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/scribe.dart';

class UserServices {
  final CollectionReference userRef =
      FirebaseFirestore.instance.collection('users');

  Future<UserCredential> createUser(String email, String password) async {
    return FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> loginUser(String email, String password) async {
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> addUser(
    BuildContext context,
    String userId,
    String displayName,
    String avatarUrl,
    String profession,
  ) async {
    Scribe user = Scribe(
      userId: userId,
      displayName: displayName,
      avatarUrl: avatarUrl,
      profession: profession,
    );
    await userRef.add(user.toMap());
    return;
  }
}
