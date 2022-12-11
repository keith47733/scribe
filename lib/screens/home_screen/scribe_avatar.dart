import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../models/scribe.dart';

class ScribeAvatar extends StatefulWidget {
  const ScribeAvatar({super.key});

  @override
  State<ScribeAvatar> createState() => _ScribeAvatarState();
}

class _ScribeAvatarState extends State<ScribeAvatar> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('scribes')
            .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.inversePrimary),
            );
          }
          Scribe currScribe = Scribe.fromDocument(snapshot.data!.docs[0]);
          // return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          //     stream: FirebaseFirestore.instance.collection('users').snapshots(),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const Center(child: CircularProgressIndicator());
          //       }
          //       final usersStream = snapshot.data!.docs.map((document) {
          //         return MUser.fromDocument(document);
          //       }).where((muser) {
          //         print(muser.userId);
          //         return (muser.userId == FirebaseAuth.instance.currentUser!.uid);
          //       }).toList();
          //       MUser currUser = usersStream[0];
          return InkWell(
            onTap: () {},
            child: Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(RADIUS / 2),
              ),
              color: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(SPACING / 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const SizedBox(height: SPACING / 4),
                    _avatar(currScribe.avatarUrl),
                    // const SizedBox(height: SPACING / 8),
                    _scribeName(currScribe.displayName),
                    // const SizedBox(height: SPACING / 4),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _avatar(avatarUrl) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(APP_BAR_HEIGHT * 0.50),
        child: Image.network(
          avatarUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _scribeName(displayName) {
    return Text(
      displayName,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
    );
  }
}
