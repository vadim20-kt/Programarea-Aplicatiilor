import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

// Secțiunea de antet cu data curentă, mesajul de salut și butonul de notificări
class HeaderSection extends StatelessWidget {
  final String date;
  final String greeting;

  const HeaderSection({
    super.key,
    this.date = "Friday, 20 May",
    this.greeting = "Good Morning",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Data curentă și textul de salut
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              greeting,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        
        // Iconița rotundă pentru notificări
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: AppColors.notificationCircle,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.notifications_outlined, color: AppColors.textPrimary),
            ),
            
            // Indicator roșu pentru notificări necitite
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.notificationRed,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
