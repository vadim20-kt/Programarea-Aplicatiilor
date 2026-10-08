import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/fitness_cubit.dart';
import '../utils/app_colors.dart';

// Ecranul de detalii pentru săli sau planuri de antrenament
class GymDetailScreen extends StatelessWidget {
  final String? customTitle;
  final String? customImageUrl;

  const GymDetailScreen({
    super.key,
    this.customTitle,
    this.customImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    // Preluarea stării curente din FitnessCubit
    final state = context.watch<FitnessCubit>().state;
    dynamic gymData;

    if (state is FitnessSuccess) {
      gymData = state.data.fitnessGymDetailsPage.gym;
    } else if (state is FitnessEmpty) {
      gymData = state.data.fitnessGymDetailsPage.gym;
    }

    // Informațiile afișate pe ecran
    final gymName = customTitle ?? gymData?.name ?? "Mid City Gym Training";
    final location = gymData?.location ?? "California, New York";
    final imageUrl = customImageUrl ?? gymData?.heroImageUrl ?? 'https://images.unsplash.com/photo-1593079831268-3381b0db4a77?q=80&w=2069&auto=format&fit=crop';
    final rating = gymData?.rating ?? 4.5;
    final reviewCount = gymData?.reviewCount ?? 1232;
    final description = gymData?.description ?? "Lorem ipsum dolor sit amet...";
    final pricingFormatted = gymData?.pricing.formatted ?? "\$69.00 /week";
    final amenities = gymData?.amenities ?? [];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Conținutul derulabil cu detaliile despre sală
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 140),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imaginea principală cu protecție la eroare de rețea
                SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.darkCard,
                        child: const Center(
                          child: Icon(Icons.fitness_center, size: 80, color: AppColors.primaryGreen),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Evaluarea și numărul de recenzii
                      Row(
                        children: [
                          const Icon(Icons.star, color: AppColors.starYellow, size: 22),
                          const SizedBox(width: 6),
                          Text(rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          const SizedBox(width: 6),
                          Text("($reviewCount reviews)", style: const TextStyle(color: AppColors.textSecondary)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Titlul și locația
                      Text(gymName, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(location, style: const TextStyle(color: AppColors.textSecondary, fontSize: 16)),
                      const SizedBox(height: 24),
                      
                      // Descrierea detaliată
                      Text(description, style: const TextStyle(color: AppColors.textSecondary, height: 1.5)),
                      const SizedBox(height: 24),
                      const Divider(color: AppColors.borderGrey),
                      const SizedBox(height: 24),
                      
                      // Lista de facilități
                      const Text("Amenities", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      amenities.isEmpty
                          ? const Text("Nu există facilități listate.", style: TextStyle(color: AppColors.textSecondary))
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: (amenities.length / 2).ceil(),
                              itemBuilder: (context, index) {
                                final firstIndex = index * 2;
                                final secondIndex = firstIndex + 1;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Row(
                                    children: [
                                      Expanded(child: _buildAmenityCard(Icons.check_circle_outline, amenities[firstIndex].name)),
                                      const SizedBox(width: 16),
                                      if (secondIndex < amenities.length)
                                        Expanded(child: _buildAmenityCard(Icons.check_circle_outline, amenities[secondIndex].name))
                                      else
                                        const Spacer(),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Butonul circular pentru revenire la ecranul anterior
          Positioned(
            top: 50,
            left: 20,
            child: _buildCircularButton(Icons.arrow_back, () => Navigator.pop(context)),
          ),
          
          // Bara inferioară cu prețul și butonul de rezervare
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, -5))],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Total", style: TextStyle(color: AppColors.textSecondary)),
                      const SizedBox(height: 4),
                      Text(pricingFormatted, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  
                  // Butonul de rezervare
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Rezervare înregistrată cu succes! 🎉"),
                          backgroundColor: AppColors.primaryGreen,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      foregroundColor: AppColors.textWhite,
                      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: const Text("Reserve", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Buton circular pentru navigare înapoi
  Widget _buildCircularButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.2), shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  // Card pentru afișarea unei facilități
  Widget _buildAmenityCard(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.lightGreyBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderGrey.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.textPrimary, size: 24),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
