import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/theme_cubit.dart';
import '../utils/app_colors.dart';

// Secțiunea de antet cu data curentă, mesajul de salut, comutatorul de temă și notificări
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Data curentă și textul de salut
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: TextStyle(
                color: isDarkMode ? Colors.grey[400] : AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              greeting,
              style: TextStyle(
                color: isDarkMode ? Colors.white : AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        // Butoanele de acțiune: Comutator Temă (Luminos/Întunecat) și Notificări
        Row(
          children: [
            // Buton pentru schimbare temă Light/Dark Mode
            GestureDetector(
              onTap: () => context.read<ThemeCubit>().toggleTheme(),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF1E2638) : AppColors.notificationCircle,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isDarkMode ? Icons.wb_sunny_rounded : Icons.nightlight_round,
                  color: isDarkMode ? AppColors.starYellow : AppColors.textPrimary,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Iconița rotundă pentru notificări
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF1E2638) : AppColors.notificationCircle,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: isDarkMode ? Colors.white : AppColors.textPrimary,
                    size: 22,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
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
        ),
      ],
    );
  }
}
