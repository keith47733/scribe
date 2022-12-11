import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grimoire/variables/global.dart';

import '../../utils/utils.dart';
import '../../variables/constants.dart';
import '../../providers/parchment.dart';

class BuildGrimoire extends StatelessWidget {
  const BuildGrimoire({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('parchments')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (ctx1, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LinearProgressIndicator(
              color: Theme.of(context).colorScheme.inversePrimary);
        }
        return Expanded(
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx2, index) {
              Parchment currParchment =
                  Parchment.fromDocument(snapshot.data!.docs[index]);
              return _parchment(ctx2, currParchment);
            },
          ),
        );
      },
    );
  }

  Widget _parchment(ctx2, currParchment) {
    Size size = MediaQuery.of(ctx2).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SPACING,
        horizontal: SPACING * 4,
      ),
      child: Card(
        elevation: CARD_ELEVATION,
        color: Theme.of(ctx2).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(SPACING),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(formatDateFromTimestamp(currParchment.created),
                      style: Theme.of(ctx2).textTheme.titleLarge!.copyWith(
                          color: Theme.of(ctx2).colorScheme.secondary,
                          fontWeight: FontWeight.bold)),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete_forever,
                      color: Theme.of(ctx2).colorScheme.secondary,
                      size: ICON_SIZE,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SPACING / 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(formatTimeFromTimestamp(currParchment.created),
                      style: Theme.of(ctx2).textTheme.titleMedium!.copyWith(
                          color: Theme.of(ctx2).colorScheme.tertiary)),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      color: Theme.of(ctx2).colorScheme.tertiary,
                      size: ICON_SIZE,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SPACING),
              Center(
                child: SizedBox(
                  height: size.height * 0.4,
                  child: Image.asset(
                    'assets/images/image.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: SPACING),
              Text(currParchment.title,
                  style: Theme.of(ctx2).textTheme.titleMedium!.copyWith(
                      color: Theme.of(ctx2).colorScheme.onSurface,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: SPACING),
              Text(currParchment.content,
                  style: Theme.of(ctx2).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(ctx2).colorScheme.onSurface,
                      fontWeight: FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }

  // child: ListTile(
  //     contentPadding: const EdgeInsets.all(SPACING * 2),
  //     title: Text(currParchment.title!),
  //     subtitle: Text(currParchment.content!)),

}
