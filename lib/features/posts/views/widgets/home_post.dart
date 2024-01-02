import 'package:flutter/material.dart';

class HomePost extends StatelessWidget {
  final int index;

  const HomePost({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.amber[100 * (index % 9)],
      child: Center(
        child: Text(
          'List Item $index',
        ),
      ),
    );
  }
}
