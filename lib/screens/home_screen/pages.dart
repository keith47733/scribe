import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../models/grimoire.dart';

class Pages extends StatelessWidget {
  const Pages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('pages')
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
              Grimoire currPage =
                  Grimoire.fromDocument(snapshot.data!.docs[index]);
              return _page(currPage);
            },
          ),
        );
      },
    );
  }

  Widget _page(Grimoire currPage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: SPACING / 2),
      child: Card(
        elevation: CARD_ELEVATION,
        child: ListTile(
            contentPadding: const EdgeInsets.all(SPACING * 2),
            title: Text(currPage.title!),
            subtitle: Text(currPage.content!)),
      ),
    );
  }
}
