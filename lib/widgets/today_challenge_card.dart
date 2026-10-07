import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

// Card pentru afișarea progresului provocării din ziua curentă
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
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(20),
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
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                activity,
                style: const TextStyle(
                  color: AppColors.textWhite,
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
                  backgroundColor: Colors.grey[800],
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
                  strokeWidth: 5,
                ),
              ),
              Text(
                "$completed/$total",
                style: const TextStyle(
                  color: AppColors.textWhite,
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
