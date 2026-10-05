import 'package:flutter/material.dart';

class StorylyApp extends StatelessWidget {
  const StorylyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Storyly',
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: Text('Storyly App'),
        ),
      ),
    );
  }
}
