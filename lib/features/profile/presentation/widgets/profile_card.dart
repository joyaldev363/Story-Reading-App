import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/profile.dart';

class ProfileCard extends StatelessWidget {
  final ProfileEntity profile;
  final VoidCallback? onEditAvatarTap;

  const ProfileCard({
    super.key,
    required this.profile,
    this.onEditAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F0FF),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            // User Avatar with Edit Badge
            Stack(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2D9FF),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      profile.avatarUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.person_rounded,
                            size: 48,
                            color: Color(0xFF635BFF),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: onEditAvatarTap,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.edit_outlined,
                        size: 16,
                        color: AppColors.navyBlue,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 20),

            // Profile Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.navyBlue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Reader since ${profile.readerSince}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF718096),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.menu_book_rounded,
                        color: Color(0xFF718096),
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        profile.languageLabel,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.navyBlue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
