import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'constants/constants.dart';
import 'screens/getting_started_screen/getting_started_screen.dart';
import 'screens/user_auth_screen/user_auth_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext ctx2, Widget? child) {
        final MediaQueryData data = MediaQuery.of(ctx2);
        return MediaQuery(
          data: data.copyWith(
              textScaleFactor: data.textScaleFactor * TEXT_SCALE_FACTOR),
          child: child!,
        );
      },
      title: 'Scribe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const UserAuthScreen(),
      // home: const GettingStartedScreen(),
    );
  }
}

class GetInfo extends StatelessWidget {
  const GetInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('pages').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('SOMETHING WENT WRONG');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('LOADING....');
          }
          return ListView(
            children: snapshot.data!.docs.map(
              (DocumentSnapshot document) {
                return ListTile(
                  title: Text(document['display_name']),
                  subtitle: Text(document['profession']),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}