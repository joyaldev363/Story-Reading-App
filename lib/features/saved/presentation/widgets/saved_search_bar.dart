import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class SavedSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SavedSearchBar({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F8),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            const Icon(
              Icons.search_rounded,
              color: Color(0xFF9EA3AE),
              size: 22,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                onChanged: onChanged,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.navyBlue,
                  fontWeight: FontWeight.w500,
                ),
                decoration: const InputDecoration(
                  hintText: 'Search saved stories...',
                  hintStyle: TextStyle(
                    color: Color(0xFF9EA3AE),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
