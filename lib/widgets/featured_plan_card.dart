import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

// Card pentru planurile recomandate de fitness
class FeaturedPlanCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String duration;
  final String frequency;
  final VoidCallback onStartPressed;
  
  const FeaturedPlanCard({
    super.key, 
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.frequency,
    required this.onStartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        // Imaginea de fundal cu filtru întunecat pentru lizibilitate
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.4), BlendMode.darken),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onStartPressed,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Titlul planului
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                
                // Durata și frecvența antrenamentului
                Row(
                  children: [
                    const Icon(Icons.fitness_center, color: AppColors.textWhite, size: 18),
                    const SizedBox(width: 6),
                    Text(duration, style: const TextStyle(color: AppColors.textWhite, fontSize: 14)),
                    const SizedBox(width: 10),
                    const Text("•", style: TextStyle(color: AppColors.textWhite)),
                    const SizedBox(width: 10),
                    Text(frequency, style: const TextStyle(color: AppColors.textWhite, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 20),
                
                // Butonul de start
                ElevatedButton(
                  onPressed: onStartPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: AppColors.textWhite,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Start Now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
