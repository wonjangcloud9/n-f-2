import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resultnomad/features/posts/models/post_model.dart';

class PostsRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> savePost(PostModel data) async {
    await _db.collection('moods').add(data.toJson());
  }

  Future<QuerySnapshot> getPosts() async {
    return await _db
        .collection('moods')
        .orderBy(
          'createdAt',
          descending: true,
        )
        .get();
  }

  Future<void> deletePost(String id) async {
    final target =
        await _db.collection("moods").where('id', isEqualTo: id).get();
    _db.collection("moods").doc(target.docs[0].id).delete().then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }
}

final postRepo = Provider((ref) => PostsRepository());
