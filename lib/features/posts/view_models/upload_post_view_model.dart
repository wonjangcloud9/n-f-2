import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resultnomad/features/posts/models/post_model.dart';
import 'package:resultnomad/features/posts/repos/posts_repo.dart';

class UploadPostViewModel extends AsyncNotifier<void> {
  late final PostsRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(postRepo);
  }

  Future<void> uploadPost(
    String descrition,
    int mood,
    BuildContext context,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.savePost(
        PostModel(
          description: descrition,
          mood: mood,
          createdAt: DateTime.now().microsecondsSinceEpoch,
          updatedAt: DateTime.now().microsecondsSinceEpoch,
        ),
      );
    });
    if (state is AsyncError) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("포스트 업로드에 실패했습니다."),
        ),
      );
    } else {
      Navigator.of(context).pop();
    }
  }
}

final uploadPostProvider = AsyncNotifierProvider<UploadPostViewModel, void>(
  () => UploadPostViewModel(),
);
