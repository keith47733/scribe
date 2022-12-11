import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../models/parchment.dart';

class BuildGrimoire extends StatelessWidget {
  const BuildGrimoire({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('parchments')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.inversePrimary),
          );
        }
        return Expanded(
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              Parchment currParchment =
                  Parchment.fromDocument(snapshot.data!.docs[index]);
              return _parchment(currParchment);
            },
          ),
        );
      },
    );
  }

  Widget _parchment(currParchment) {
    return Padding(
      padding: const EdgeInsets.only(bottom: SPACING / 2),
      child: Card(
        elevation: CARD_ELEVATION,
        child: ListTile(
            contentPadding: const EdgeInsets.all(SPACING * 2),
            title: Text(currParchment.title!),
            subtitle: Text(currParchment.content!)),
      ),
    );
  }
}
