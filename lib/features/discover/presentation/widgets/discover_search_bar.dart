import 'package:flutter/material.dart';

class DiscoverSearchBar extends StatelessWidget {
  final String query;
  final ValueChanged<String> onChanged;
  final VoidCallback? onClear;
  final VoidCallback? onFilterTap;

  const DiscoverSearchBar({
    super.key,
    required this.query,
    required this.onChanged,
    this.onClear,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(24.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        children: [
          const Icon(
            Icons.search_rounded,
            color: Color(0xFF64748B),
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              controller: TextEditingController.fromValue(
                TextEditingValue(
                  text: query,
                  selection: TextSelection.collapsed(offset: query.length),
                ),
              ),
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF1E293B),
              ),
              decoration: const InputDecoration(
                hintText: 'Search stories in English or Tamil...',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF94A3B8),
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 12.0),
              ),
            ),
          ),
          if (query.isNotEmpty)
            GestureDetector(
              onTap: onClear,
              child: const Icon(
                Icons.close_rounded,
                color: Color(0xFF64748B),
                size: 20,
              ),
            ),
          if (query.isNotEmpty) const SizedBox(width: 8),
          IconButton(
            onPressed: onFilterTap,
            icon: const Icon(
              Icons.tune_rounded,
              color: Color(0xFF64748B),
              size: 20,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            tooltip: 'Filter Stories',
          ),
        ],
      ),
    );
  }
}
