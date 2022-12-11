import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../providers/scribe.dart';

class ScribeServices {
  final CollectionReference scribeRef =
      FirebaseFirestore.instance.collection('scribes');

  Future<UserCredential> createScribe(String email, String password) async {
    return FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> loginScribe(String email, String password) async {
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> addScribe(
    BuildContext context,
    String scribeId,
    String displayName,
    String avatarUrl,
    String profession,
  ) async {
    Scribe scribe = Scribe(
      uid: scribeId,
      name: displayName,
      avatarUrl: avatarUrl,
    );
    await scribeRef.add(scribe.toMap());
    return;
  }
}
