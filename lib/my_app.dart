import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'variables/constants.dart';
import 'screens/getting_started_screen.dart';
import 'screens/scribe_auth_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext ctx1, Widget? child) {
        final MediaQueryData data = MediaQuery.of(ctx1);
        return MediaQuery(
          data: data.copyWith(
              textScaleFactor: data.textScaleFactor * TEXT_SCALE_FACTOR),
          child: child!,
        );
      },
      title: 'Grimoire',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const ScribeAuthScreen(),
      // home: const GettingStartedScreen(),
    );
  }
}
