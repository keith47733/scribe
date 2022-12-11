import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBuVUCsjfkMKE9RPNcMT0d-bPiAQT4oS_M",
          authDomain: "scribe-8377c.firebaseapp.com",
          projectId: "scribe-8377c",
          storageBucket: "scribe-8377c.appspot.com",
          messagingSenderId: "353333916188",
          appId: "1:353333916188:web:674d4c309affd0262365d9"));
  runApp(const MyApp());
}
