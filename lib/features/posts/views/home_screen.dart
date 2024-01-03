import 'package:flutter/material.dart';
import 'package:resultnomad/features/posts/views/widgets/home_post.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(
            const Duration(
              seconds: 1,
            ),
          );
        },
        displacement: 50,
        edgeOffset: 20,
        child: CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              pinned: false,
              expandedHeight: 50.0,
              title: Text(
                "🔥Mood🔥",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SliverList.builder(
              itemBuilder: (BuildContext context, int index) {
                return HomePost(index: index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
