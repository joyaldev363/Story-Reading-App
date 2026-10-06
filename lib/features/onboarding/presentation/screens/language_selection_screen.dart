import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        title: const Text('Select Language'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.navyBlue,
      ),
      body: const Center(
        child: Text(
          'Language Selection Screen',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.navyBlue,
          ),
        ),
      ),
    );
  }
}
