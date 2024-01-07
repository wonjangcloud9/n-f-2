import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resultnomad/constants/gaps.dart';
import 'package:resultnomad/constants/sizes.dart';
import 'package:resultnomad/features/posts/models/post_model.dart';
import 'package:resultnomad/features/posts/view_models/posts_view_model.dart';

class HomePost extends ConsumerStatefulWidget {
  final int index;
  final PostModel postData;

  const HomePost({
    super.key,
    required this.index,
    required this.postData,
  });

  @override
  HomePostState createState() => HomePostState();
}

class HomePostState extends ConsumerState<HomePost> {
  String formatUploadDate(int date) {
    final uploadDate = DateTime.fromMicrosecondsSinceEpoch(date);
    return "${uploadDate.year}-${uploadDate.month.toString().padLeft(2, '0')}-${uploadDate.day.toString().padLeft(2, '0')} ${uploadDate.hour.toString().padLeft(2, '0')}:${uploadDate.minute.toString().padLeft(2, '0')}:${uploadDate.second.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size20,
            vertical: Sizes.size8,
          ),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: widget.postData.mood == 0
                  ? Colors.blue[100]
                  : widget.postData.mood == 1
                      ? Colors.green[100]
                      : widget.postData.mood == 2
                          ? Colors.yellow[200]
                          : widget.postData.mood == 3
                              ? Colors.orange[200]
                              : Colors.red[200],
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.postData.mood == 0
                      ? "😊"
                      : widget.postData.mood == 1
                          ? "😀"
                          : widget.postData.mood == 2
                              ? "😐"
                              : widget.postData.mood == 3
                                  ? "😔"
                                  : "😭",
                  style: const TextStyle(
                    fontSize: 50,
                  ),
                ),
                Text(
                  widget.postData.description,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v4,
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: Text(
                    formatUploadDate(widget.postData.createdAt),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: Sizes.size20,
          right: Sizes.size36,
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("삭제"),
                    content: const Text("정말 삭제하시겠습니까?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("취소"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ref.read(viewPostProvider.notifier).deletePost(
                                widget.postData.id,
                              );
                        },
                        child: const Text("삭제"),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text(
              "❌",
              style: TextStyle(
                fontSize: 30,
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
