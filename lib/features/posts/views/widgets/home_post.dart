import 'package:flutter/material.dart';
import 'package:resultnomad/features/posts/models/post_model.dart';

class HomePost extends StatelessWidget {
  final int index;
  final PostModel postData;

  const HomePost({
    super.key,
    required this.index,
    required this.postData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        postData.description,
      ),
    );
  }
}
