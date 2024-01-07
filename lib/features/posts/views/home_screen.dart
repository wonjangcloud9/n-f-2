import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resultnomad/features/auth/repos/auth_repo.dart';
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
            final isLoggedIn = ref.read(authRepo).isLoggedIn;
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
                    SliverAppBar(
                      pinned: false,
                      expandedHeight: 50.0,
                      title: const Text(
                        "🔥 기분 일기 🔥",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      leading: isLoggedIn
                          ? IconButton(
                              icon: const Icon(
                                Icons.logout,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                ref.read(authRepo).signOut();
                                ref.read(viewPostProvider.notifier).refresh();
                              },
                            )
                          : null,
                    ),
                    if (!isLoggedIn)
                      const SliverToBoxAdapter(
                        child: Center(
                          child: Text(
                            "로그인이 필요합니다. 😂",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    if (isLoggedIn)
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
                    if (isLoggedIn)
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
