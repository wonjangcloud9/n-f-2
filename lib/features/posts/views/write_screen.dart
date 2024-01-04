import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resultnomad/constants/gaps.dart';
import 'package:resultnomad/constants/sizes.dart';
import 'package:resultnomad/features/posts/view_models/upload_post_view_model.dart';
import 'package:resultnomad/features/posts/views/widgets/mood_icon.dart';

class WriteScreen extends ConsumerStatefulWidget {
  const WriteScreen({super.key});

  @override
  WriteScreenState createState() => WriteScreenState();
}

class WriteScreenState extends ConsumerState<WriteScreen> {
  final TextEditingController textController = TextEditingController();

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    textController.addListener(() {
      if (textController.text.length > 200) {
        textController.text = textController.text.substring(0, 200);
        textController.selection = TextSelection.fromPosition(
          TextPosition(
            offset: textController.text.length,
          ),
        );
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void onTap(int index) {
    selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "기분 기록하기",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Gaps.v20,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    TextField(
                      maxLines: 7,
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: "어떤 일이 있었나요?",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: Sizes.size16,
                      bottom: Sizes.size16,
                      child: Text(
                        "${textController.text.length}/200",
                        style: TextStyle(
                          color: textController.text.length > 200
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
                Gaps.v40,
                const Text(
                  "오늘의 기분은 어떤가요?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MoodIcon(
                      onTap: () {
                        onTap(0);
                      },
                      icon: "😊",
                      selected: selectedIndex == 0,
                    ),
                    MoodIcon(
                      onTap: () {
                        onTap(1);
                      },
                      icon: "😀",
                      selected: selectedIndex == 1,
                    ),
                    MoodIcon(
                      onTap: () {
                        onTap(2);
                      },
                      icon: "😐",
                      selected: selectedIndex == 2,
                    ),
                    MoodIcon(
                      onTap: () {
                        onTap(3);
                      },
                      icon: "😔",
                      selected: selectedIndex == 3,
                    ),
                    MoodIcon(
                      onTap: () {
                        onTap(4);
                      },
                      icon: "😭",
                      selected: selectedIndex == 4,
                    ),
                  ],
                ),
              ],
            ),
            Gaps.v20,
            GestureDetector(
              onTap: () {
                if (textController.text.isNotEmpty &&
                    textController.text.length <= 200) {
                  ref.read(uploadPostProvider.notifier).uploadPost(
                        textController.text,
                        selectedIndex,
                        context,
                      );
                  Navigator.pop(context);
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size20,
                  vertical: Sizes.size10,
                ),
                child: Text(
                  "기록하기",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textController.text.isEmpty ||
                            textController.text.length > 200
                        ? Colors.black
                        : Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
