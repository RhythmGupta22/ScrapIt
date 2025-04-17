import 'package:flutter/material.dart';
import 'package:scrap_it/constants/colors.dart';
import 'package:scrap_it/constants/fonts.dart';

class QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const QuickActionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: kPrimaryColor,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: kSubtitleStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
} 