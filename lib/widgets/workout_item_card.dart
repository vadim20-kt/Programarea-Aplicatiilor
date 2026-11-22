import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

// Card individual pentru afișarea unui program de antrenament
class WorkoutItemCard extends StatelessWidget {
  final String title;
  final String kcal;
  final String time;
  final bool isPro;
  final String imageUrl;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const WorkoutItemCard({
    super.key,
    required this.title,
    required this.kcal,
    required this.time,
    required this.isPro,
    required this.imageUrl,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDarkMode
              ? Colors.white.withValues(alpha: 0.15)
              : AppColors.borderGrey.withValues(alpha: 0.8),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withValues(alpha: 0.35)
                : Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        // Imagine de fundal cu filtru întunecat pentru lizibilitate
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.4),
            BlendMode.darken,
          ),
          onError: (exception, stackTrace) {},
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
              // Butonul de adăugare/eliminare din favorite (stânga sus)
              Positioned(
                top: 12,
                left: 12,
                child: GestureDetector(
                  onTap: onFavoriteToggle,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.45),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white24, width: 1),
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.redAccent : Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),

              // Eticheta "Pro" (dreapta sus)
              if (isPro)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
                      ],
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

              // Titlul, caloriile și durata antrenamentului (jos)
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

                    // Afișare calorii și timp
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
