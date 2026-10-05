import 'package:flutter/material.dart';
import '../features/splash/presentation/screens/splash_screen.dart';

class StorylyApp extends StatelessWidget {
  const StorylyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Storyly',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

