import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resultnomad/features/posts/view_models/posts_view_model.dart';
import 'package:resultnomad/features/posts/views/widgets/home_post.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(viewPostProvider).when(
          data: (posts) {
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
                        "🔥 기분 일기 🔥",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    if (posts.isEmpty)
                      const SliverToBoxAdapter(
                        child: Center(
                          child: Text(
                            "데이터가 없습니다. 😂",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    SliverList.builder(
                      itemCount: posts.length,
                      itemBuilder: (BuildContext context, int index) {
                        final postData = posts[index];
                        return HomePost(
                          index: index,
                          postData: postData,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stack) => Center(
            child: Text(
              error.toString(),
            ),
          ),
        );
  }
}
