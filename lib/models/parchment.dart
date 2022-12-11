import 'package:cloud_firestore/cloud_firestore.dart';

class Parchment {
  final String? parchment;
  final String? userId;
  final String? author;
  final Timestamp? created;
  final String? photoUrls;
  final String? title;
  final String? content;

  Parchment({
    required this.parchment,
    required this.userId,
    required this.author,
    required this.created,
    required this.photoUrls,
    required this.title,
    required this.content,
  });

  factory Parchment.fromDocument(QueryDocumentSnapshot parchmentData) {
    return Parchment(
      parchment: parchmentData.id,
      userId: parchmentData.get('uid'),
      author: parchmentData.get('author'),
      created: parchmentData.get('created'),
      photoUrls: parchmentData.get('photo_urls'),
      title: parchmentData.get('title'),
      content: parchmentData.get('content'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': userId,
      'author': author,
      'created': created,
      'photo_urls': photoUrls,
      'title': title,
      'content': content,
    };
  }
}
