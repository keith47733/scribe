import 'package:cloud_firestore/cloud_firestore.dart';

class Scribe {
  final String? docId;
  final String? scribeId;
  final String? displayName;
  final String? avatarUrl;
  final String? profession;

  Scribe({
    this.docId,
    this.scribeId,
    this.displayName,
    this.avatarUrl,
    this.profession,
  });

  // factory method will convert from Map<String, dynamic> to User class object from a QueryDocumentSnapshot passed to method and accepted as variable userData. A document key value can be abstracted from userData using .get('key')
  factory Scribe.fromDocument(QueryDocumentSnapshot scribeData) {
    return Scribe(
      docId: scribeData.id,
      scribeId: scribeData.get('uid'),
      displayName: scribeData.get('display_name'),
      avatarUrl: scribeData.get('avatar_url'),
      profession: scribeData.get('profession'),
    );
  }

  // Similarly, this will convert a user object to a Map<String, dynamic> (that can be written to FirebaseFirestore document)
  Map<String, dynamic> toMap() {
    return {
      'uid': scribeId,
      'display_name': displayName,
      'avatar_url': avatarUrl,
      'profession': profession,
    };
  }
}
