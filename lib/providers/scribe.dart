import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Scribe with ChangeNotifier {
  String? _uid;
  String? _token;
  DateTime? _expiryDate;
  Timer? _authTimer;
  String? _name;
  String? _avatarUrl;

  final CollectionReference scribeRef =
      FirebaseFirestore.instance.collection('scribes');

  Future<UserCredential> loginScribe(String email, String password) async {
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> createScribe(String email, String password) async {
    return FirebaseAuth.instance.createUserWithEmailAndPassword(
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
