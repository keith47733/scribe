import 'package:cloud_firestore/cloud_firestore.dart';

class Grimoire {
  final String? pageId;
  final String? userId;
  final String? author;
  final Timestamp? created;
  final String? photoUrls;
  final String? title;
  final String? content;

  Grimoire({
    required this.pageId,
    required this.userId,
    required this.author,
    required this.created,
    required this.photoUrls,
    required this.title,
    required this.content,
  });

  factory Grimoire.fromDocument(QueryDocumentSnapshot pageData) {
    return Grimoire(
      pageId: pageData.id,
      userId: pageData.get('uid'),
      author: pageData.get('author'),
      created: pageData.get('created'),
      photoUrls: pageData.get('photo_urls'),
      title: pageData.get('title'),
      content: pageData.get('content'),
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
