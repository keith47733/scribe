import 'package:cloud_firestore/cloud_firestore.dart';

class Scribe {
  final String? docId;
  final String? userId;
  final String? displayName;
  final String? avatarUrl;
  final String? profession;

  Scribe({
    this.docId,
    this.userId,
    this.displayName,
    this.avatarUrl,
    this.profession,
  });

  // factory method will convert from Map<String, dynamic> to User class object from a QueryDocumentSnapshot passed to method and accepted as variable userData. A document key value can be abstracted from userData using .get('key')
  factory Scribe.fromDocument(QueryDocumentSnapshot userData) {
    return Scribe(
      docId: userData.id,
      userId: userData.get('uid'),
      displayName: userData.get('display_name'),
      avatarUrl: userData.get('avatar_url'),
      profession: userData.get('profession'),
    );
  }

  // Similarly, this will convert a user object to a Map<String, dynamic> (that can be written to FirebaseFirestore document)
  Map<String, dynamic> toMap() {
    return {
      'uid': userId,
      'display_name': displayName,
      'avatar_url': avatarUrl,
      'profession': profession,
    };
  }
}
