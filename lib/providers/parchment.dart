import 'package:cloud_firestore/cloud_firestore.dart';

class Parchment {
  final String? scribeId;
  final String? author;
  final Timestamp? created;
  final String? photoUrls;
  final String? title;
  final String? content;

  Parchment({
    required this.scribeId,
    required this.author,
    required this.created,
    required this.photoUrls,
    required this.title,
    required this.content,
  });

  factory Parchment.fromDocument(QueryDocumentSnapshot parchmentData) {
    return Parchment(
      scribeId: parchmentData.get('uid'),
      author: parchmentData.get('author'),
      created: parchmentData.get('created'),
      photoUrls: parchmentData.get('photo_urls'),
      title: parchmentData.get('title'),
      content: parchmentData.get('content'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': scribeId,
      'author': author,
      'created': created,
      'photo_urls': photoUrls,
      'title': title,
      'content': content,
    };
  }
}
