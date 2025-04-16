import 'package:flutter/material.dart';
import 'package:uicons/uicons.dart';
import 'package:scrap_it/constants/colors.dart';
import 'package:scrap_it/constants/fonts.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String count;
  final VoidCallback onTap;

  const TaskCard({
    super.key,
    required this.title,
    required this.icon,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: kPrimaryColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: kSubtitleStyle,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$count tasks',
                    style: kTitleStyle.copyWith(fontSize: 20),
                  ),
                ],
              ),
            ),
            Icon(
              UIcons.regularRounded.arrow_right,
              color: kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
} 