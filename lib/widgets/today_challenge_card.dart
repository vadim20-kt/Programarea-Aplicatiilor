import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

// Card pentru afișarea progresului provocării din ziua curentă - adaptat dinamic la tema Light/Dark
class TodayChallengeCard extends StatelessWidget {
  final String title;
  final String activity;
  final int completed;
  final int total;
  final double progress;

  const TodayChallengeCard({
    super.key,
    this.title = "Today's Challenge",
    this.activity = "Running",
    this.completed = 15,
    this.total = 20,
    this.progress = 0.75,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDarkMode ? Colors.white.withValues(alpha: 0.12) : AppColors.borderGrey,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Titlul și tipul activității
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isDarkMode ? Colors.grey[400] : AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                activity,
                style: TextStyle(
                  color: isDarkMode ? AppColors.textWhite : AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Indicator circular de progres
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  value: progress,
                  backgroundColor: isDarkMode ? Colors.grey[800] : AppColors.lightGreyBg,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
                  strokeWidth: 5,
                ),
              ),
              Text(
                "$completed/$total",
                style: TextStyle(
                  color: isDarkMode ? AppColors.textWhite : AppColors.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
