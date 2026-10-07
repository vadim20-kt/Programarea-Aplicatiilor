import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

// Card individual pentru programele de antrenament din grilă
class WorkoutItemCard extends StatelessWidget {
  final String title;
  final String kcal;
  final String time;
  final bool isPro;
  final String imageUrl;

  const WorkoutItemCard({
    super.key,
    required this.title,
    required this.kcal,
    required this.time,
    required this.isPro,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        // Imaginea de fundal cu filtru întunecat
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.35),
            BlendMode.darken,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(24),
          splashColor: Colors.white.withValues(alpha: 0.2),
          child: Stack(
            children: [
              // Badge "Pro" afișat opțional în colțul din dreapta sus
              if (isPro)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.workspace_premium, color: AppColors.primaryGreen, size: 14),
                        SizedBox(width: 4),
                        Text(
                          "Pro",
                          style: TextStyle(
                            color: AppColors.primaryGreen,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              
              // Informațiile antrenamentului poziționate în partea de jos
              Positioned(
                bottom: 16,
                left: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Calorii și timp
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Icon(Icons.local_fire_department, color: AppColors.textWhite, size: 14),
                          const SizedBox(width: 4),
                          Text(kcal, style: const TextStyle(color: AppColors.textWhite, fontSize: 11)),
                          const SizedBox(width: 10),
                          const Icon(Icons.access_time, color: AppColors.textWhite, size: 14),
                          const SizedBox(width: 4),
                          Text(time, style: const TextStyle(color: AppColors.textWhite, fontSize: 11)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
