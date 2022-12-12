import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Scribe with ChangeNotifier {
  String? _uid;
  String? _name;
  String? _avatarUrl;
  String? _token;
  DateTime? _expiryDate;
  Timer? _authTimer;

  final CollectionReference scribeRef =
      FirebaseFirestore.instance.collection('scribes');

  bool get isAuth {
    if (token == null) {
      return false;
    }
    return true;
  }

  String? get uid {
    if (_token == null) {
      return null;
    }
    if (_expiryDate == null) {
      return null;
    }
    if (_expiryDate!.isBefore(DateTime.now())) {
      return null;
    }
    return _uid;
  }

  String? get name {
    if (_token == null) {
      return null;
    }
    if (_expiryDate == null) {
      return null;
    }
    if (_expiryDate!.isBefore(DateTime.now())) {
      return null;
    }
    return _name;
  }

  String? get avatarUrl {
    if (_token == null) {
      return null;
    }
    if (_expiryDate == null) {
      return null;
    }
    if (_expiryDate!.isBefore(DateTime.now())) {
      return null;
    }
    return _avatarUrl;
  }

  String? get token {
    if (_token == null) {
      return null;
    }
    if (_expiryDate == null) {
      return null;
    }
    if (_expiryDate!.isBefore(DateTime.now())) {
      return null;
    }
    return _token;
  }

  Future<void> fetchScribeData(uid) async {
    final scribeData = await scribeRef.where('uid', isEqualTo: uid).get();
    if (scribeData.docs.isEmpty) {
      throw Exception;
    }
    _name = scribeData.docs[0]['display_name'];
    _avatarUrl = scribeData.docs[0]['avatar_url'];
  }

  Future<void> setScribeData(uid) async {
    final scribeData = {
      'uid': uid,
      'display_name': 'CHANGE IN FIREBASE FIRESTORE',
      'avatar_url': 'CHANGE IN FIREBASE FIRSTORE',
    };
    await scribeRef.add(scribeData);
  }

  Future<bool> tryAutoLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('session_data')) {
        throw Exception('Does not contain session data');
      }
      final sessionData = prefs.getString('session_data')!;
      final decodedSessionData = jsonDecode(sessionData);
      _uid = decodedSessionData['uid'];
      _token = decodedSessionData['token'];
      _expiryDate = DateTime.parse(decodedSessionData['token_expiry_date']);
      if (_expiryDate!.isBefore(DateTime.now())) {
        throw Exception('Token is expired');
      }
      _resetAutoLogoutTimer();
      await fetchScribeData(_uid);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (auth.user == null) {
        throw Exception('LOGIN User is null');
      }

      _uid = auth.user!.uid;
      await fetchScribeData(_uid);

      _token = await auth.user!.getIdToken();
      if (_token == null) {
        throw Exception('LOGIN token is null');
      }

      _expiryDate = DateTime.now().add(const Duration(minutes: 60));
      _resetAutoLogoutTimer();

      final prefs = await SharedPreferences.getInstance();
      final sessionData = json.encode(
        {
          'uid': _uid,
          'token': _token,
          'token_expiry_date': _expiryDate!.toIso8601String(),
        },
      );
      prefs.setString('session_data', sessionData);

      notifyListeners();

      return true;
    } catch (error) {
      print('LOGIN ERROR: ${error.toString()}');
      return false;
    }
  }

  Future<bool> createScribe(String email, String password) async {
    try {
      final UserCredential scribe =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await setScribeData(scribe.user!.uid);

      await login(email, password);

      return true;
    } catch (error) {
      print('CREATE USER ERROR: ${error.toString()}');
      return false;
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();

    _uid = '';
    _token = '';
    _avatarUrl = '';
    _name = '';

    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }

  void _resetAutoLogoutTimer() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final sessionTimeSeconds =
        _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: sessionTimeSeconds), logout);
  }
}
