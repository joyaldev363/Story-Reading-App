import 'package:flutter/material.dart';
import '../../domain/entities/saved_story.dart';

class SavedFilterTabs extends StatelessWidget {
  final SavedReadStatus selectedFilter;
  final int allCount;
  final int unreadCount;
  final int readingCount;
  final ValueChanged<SavedReadStatus> onFilterSelected;

  const SavedFilterTabs({
    super.key,
    required this.selectedFilter,
    required this.allCount,
    required this.unreadCount,
    required this.readingCount,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Row(
        children: [
          Expanded(
            child: _buildTabPill(
              context,
              label: 'All ($allCount)',
              isSelected: selectedFilter == SavedReadStatus.all,
              onTap: () => onFilterSelected(SavedReadStatus.all),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildTabPill(
              context,
              label: 'Unread ($unreadCount)',
              isSelected: selectedFilter == SavedReadStatus.unread,
              onTap: () => onFilterSelected(SavedReadStatus.unread),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildTabPill(
              context,
              label: 'Reading ($readingCount)',
              isSelected: selectedFilter == SavedReadStatus.reading,
              onTap: () => onFilterSelected(SavedReadStatus.reading),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabPill(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    const activeColor = Color(0xFF635BFF);
    const inactiveBg = Color(0xFFF1F3F7);
    const inactiveText = Color(0xFF4A5568);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : inactiveBg,
          borderRadius: BorderRadius.circular(24),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: activeColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? Colors.white : inactiveText,
          ),
        ),
      ),
    );
  }
}
