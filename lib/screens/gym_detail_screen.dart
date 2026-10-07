import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

// Ecranul cu detaliile sălii / antrenamentului
class GymDetailScreen extends StatelessWidget {
  const GymDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Conținutul paginii care poate fi derulat în sus
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 140),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imaginea mare de antet
                SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1593079831268-3381b0db4a77?q=80&w=2069&auto=format&fit=crop',
                    fit: BoxFit.cover,
                  ),
                ),

                // Informațiile și descrierea sălii
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Rating și recenzii
                      const Row(
                        children: [
                          Icon(Icons.star, color: AppColors.starYellow, size: 22),
                          SizedBox(width: 6),
                          Text(
                            "4.5",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(width: 6),
                          Text("(1,232 reviews)", style: TextStyle(color: AppColors.textSecondary)),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Numele și locația sălii
                      const Text(
                        "Mid City Gym Training",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "California, New York",
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                      ),
                      const SizedBox(height: 24),
                      
                      // Descrierea
                      const Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.",
                        style: TextStyle(color: AppColors.textSecondary, height: 1.5),
                      ),
                      const SizedBox(height: 24),
                      const Divider(color: AppColors.borderGrey),
                      const SizedBox(height: 24),

                      // Secțiunea de facilități (Amenities)
                      const Text(
                        "Amenities",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),

                      // Rândul 1: Dușuri și vestiare
                      Row(
                        children: [
                          Expanded(child: _buildAmenityCard(Icons.shower_outlined, "Showers")),
                          const SizedBox(width: 16),
                          Expanded(child: _buildAmenityCard(Icons.door_sliding_outlined, "Lockers")),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Rândul 2: WiFi și parcare
                      Row(
                        children: [
                          Expanded(child: _buildAmenityCard(Icons.wifi, "Free WiFi")),
                          const SizedBox(width: 16),
                          Expanded(child: _buildAmenityCard(Icons.local_parking, "Parking")),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Rândul 3: Piscină și echipament
                      Row(
                        children: [
                          Expanded(child: _buildAmenityCard(Icons.pool, "Swimming Pool")),
                          const SizedBox(width: 16),
                          Expanded(child: _buildAmenityCard(Icons.fitness_center, "Pro Equipment")),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Rândul 4: Health bar și aer condiționat
                      Row(
                        children: [
                          Expanded(child: _buildAmenityCard(Icons.restaurant, "Health Bar")),
                          const SizedBox(width: 16),
                          Expanded(child: _buildAmenityCard(Icons.ac_unit, "Air Condition")),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Butoane de navigare sus (Back și More)
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircularButton(Icons.arrow_back, () => Navigator.pop(context)),
                _buildCircularButton(Icons.more_vert, () {}),
              ],
            ),
          ),

          // Bara fixă de jos cu prețul și butonul de rezervare
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Prețul total
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Total", style: TextStyle(color: AppColors.textSecondary)),
                      SizedBox(height: 4),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "\$69.00",
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: " /week",
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Butonul de rezervare
                  ElevatedButton(
                    onPressed: () {},
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

  // Buton circular pentru acțiuni (Back / More)
  Widget _buildCircularButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  // Card individual pentru facilități
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
