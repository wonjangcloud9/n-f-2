import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resultnomad/features/posts/models/post_model.dart';

class PostsRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> savePost(PostModel data) async {
    await _db.collection('moods').add(data.toJson());
  }

  Future<QuerySnapshot> getPosts() async {
    return await _db.collection('moods').get();
  }
}

final postRepo = Provider((ref) => PostsRepository());
