import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onTap;

  const LogoutButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF0F0),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout_rounded, color: Color(0xFFFF4D4D), size: 20),
              SizedBox(width: 8),
              Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFF4D4D),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
