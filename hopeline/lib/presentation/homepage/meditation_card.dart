import 'package:flutter/material.dart';

class MeditationCard extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String subtitle;
  final String actionText;

  const MeditationCard({
    Key? key,
    required this.onTap,
    this.title = 'Daily Meditation',
    this.subtitle = 'Take a moment to breathe\nand find your peace',
    this.actionText = 'Start→',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF7C4DFF), // Purple color for meditation
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    actionText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.self_improvement,
              color: Colors.white,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}