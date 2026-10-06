import 'package:flutter/material.dart';

class CategoryEntity {
  final String id;
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  const CategoryEntity({
    required this.id,
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });
}
