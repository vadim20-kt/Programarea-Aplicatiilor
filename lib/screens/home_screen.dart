import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/header_section.dart';
import '../widgets/today_challenge_card.dart';
import '../widgets/section_header.dart';
import '../widgets/featured_plan_card.dart';
import '../widgets/workout_item_card.dart';
import 'gym_detail_screen.dart';

// Ecranul principal al aplicatiei
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          // Adaugam padding la baza pentru a asigura vizibilitatea tuturor elementelor
          padding: const EdgeInsets.only(top: 20, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Zona de sus: Salut si Notificari
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: HeaderSection(),
              ),
              const SizedBox(height: 24),

              // Progresul zilei curente
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TodayChallengeCard(),
              ),
              const SizedBox(height: 24),

              // Sectiunea de planuri recomandate (Scroll Orizontal)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: SectionHeader(title: "Featured Plan"),
              ),
              const SizedBox(height: 12),
              
              // Lista orizontala de planuri
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    // Primul card: Acum fara navigare (doar vizual)
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      margin: const EdgeInsets.only(right: 16),
                      child: FeaturedPlanCard(
                        title: "Massive Upper Body",
                        imageUrl: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=2070&auto=format&fit=crop',
                        duration: "5 week",
                        frequency: "4x/week",
                        onStartPressed: () {},
                      ),
                    ),
                    // Al doilea card: Deschide pagina "Mid City Gym Training" la apasare
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      margin: const EdgeInsets.only(right: 16),
                      child: FeaturedPlanCard(
                        title: "Mid City Gym Training",
                        imageUrl: 'https://images.unsplash.com/photo-1593079831268-3381b0db4a77?q=80&w=2069&auto=format&fit=crop',
                        duration: "8 week",
                        frequency: "3x/week",
                        onStartPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GymDetailScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Sectiunea cu programele de antrenament
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: SectionHeader(title: "Workout Programs"),
              ),
              const SizedBox(height: 12),

              // Filtre rapide (Yoga, Cardio etc.)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _buildFilterChip("All Type", isSelected: true),
                    _buildFilterChip("Pilates"),
                    _buildFilterChip("Cardio"),
                    _buildFilterChip("Yoga"),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Grila cu antrenamentele - Cardul Yoga este acum vizibil cu o imagine noua
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                  children: const [
                    // Cardul Yoga: Am schimbat imaginea pentru a fi vizibila
                    WorkoutItemCard(
                      title: "Yoga",
                      kcal: "210 kcal",
                      time: "120 min",
                      isPro: false,
                      imageUrl: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?q=80&w=2070&auto=format&fit=crop',
                    ),
                    WorkoutItemCard(
                      title: "Arm Strengthening",
                      kcal: "210 kcal",
                      time: "120 min",
                      isPro: true,
                      imageUrl: 'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?q=80&w=2070&auto=format&fit=crop',
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

  // Widget pentru butoanele de filtrare cu stil modern
  Widget _buildFilterChip(String label, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Material(
        color: isSelected ? AppColors.primaryGreen : AppColors.lightGreyBg,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.textWhite : AppColors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
