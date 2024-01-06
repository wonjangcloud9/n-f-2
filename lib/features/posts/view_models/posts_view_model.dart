import 'dart:async';
import 'dart:core';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resultnomad/features/posts/models/post_model.dart';
import 'package:resultnomad/features/posts/repos/posts_repo.dart';

class PostsViewModel extends AsyncNotifier<List<PostModel>> {
  late final PostsRepository _repository;
  final List<PostModel> _list = [];

  @override
  FutureOr<List<PostModel>> build() async {
    _repository = ref.read(postRepo);
    final result = await _repository.getPosts();
    final newList = result.docs
        .map(
          (doc) => PostModel.fromJson(
            doc.data() as Map<String, dynamic>,
          ),
        )
        .toList();
    _list.clear();
    _list.addAll(newList);
    return _list;
  }

  refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await _repository.getPosts();
      final newList = result.docs
          .map(
            (doc) => PostModel.fromJson(
              doc.data() as Map<String, dynamic>,
            ),
          )
          .toList();
      _list.clear();
      _list.addAll(newList);
      return _list;
    });
  }
}

final viewPostProvider = AsyncNotifierProvider<PostsViewModel, List<PostModel>>(
  () => PostsViewModel(),
);
