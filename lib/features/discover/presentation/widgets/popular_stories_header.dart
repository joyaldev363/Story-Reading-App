import 'package:flutter/material.dart';

class PopularStoriesHeader extends StatelessWidget {
  const PopularStoriesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Popular Stories',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF0F172A),
      ),
    );
  }
}
