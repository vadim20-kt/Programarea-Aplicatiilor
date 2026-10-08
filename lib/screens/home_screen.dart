import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/fitness_cubit.dart';
import '../models/fitness_model.dart';
import '../utils/app_colors.dart';
import '../widgets/header_section.dart';
import '../widgets/today_challenge_card.dart';
import '../widgets/section_header.dart';
import '../widgets/featured_plan_card.dart';
import '../widgets/workout_item_card.dart';
import 'gym_detail_screen.dart';

// Ecranul principal al aplicației cu gestiune de stare prin FitnessCubit
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        // Ascultăm modificările de stare din FitnessCubit
        child: BlocBuilder<FitnessCubit, FitnessState>(
          builder: (context, state) {
            // Starea de încărcare: afișează indicatorul circular
            if (state is FitnessLoading || state is FitnessInitial) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryGreen),
              );
            }

            // Starea de eroare: afișează mesajul și butonul de reîncercare
            if (state is FitnessError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red, size: 48),
                      const SizedBox(height: 16),
                      Text(state.message, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.white : AppColors.textPrimary)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => context.read<FitnessCubit>().loadData(),
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryGreen),
                        child: const Text("Reîncearcă", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Extragerea datelor din starea curentă (Success sau Empty)
            FitnessData data;
            List<WorkoutItem> workouts = [];
            List<FilterItem> filters = [];
            Set<String> favoriteIds = {};

            if (state is FitnessSuccess) {
              data = state.data;
              workouts = state.filteredWorkouts;
              filters = data.fitnessHomePage.workoutPrograms.filters;
              favoriteIds = state.favoriteIds;
            } else if (state is FitnessEmpty) {
              data = state.data;
              workouts = [];
              filters = data.fitnessHomePage.workoutPrograms.filters;
              favoriteIds = state.favoriteIds;
            } else {
              return const SizedBox.shrink();
            }

            final homeData = data.fitnessHomePage;

            return SingleChildScrollView(
              padding: const EdgeInsets.only(top: 20, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Antetul cu salutul și data curentă
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: HeaderSection(
                      date: homeData.header.date,
                      greeting: homeData.header.greeting,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Cardul cu provocarea zilei și progresul
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TodayChallengeCard(
                      title: homeData.todaysChallenge.title,
                      activity: homeData.todaysChallenge.activity,
                      completed: homeData.todaysChallenge.completed,
                      total: homeData.todaysChallenge.total,
                      progress: homeData.todaysChallenge.progress,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Câmpul de căutare pentru filtrarea rapidă
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      style: TextStyle(color: isDarkMode ? Colors.white : AppColors.textPrimary),
                      onChanged: (query) => context.read<FitnessCubit>().setSearchQuery(query),
                      decoration: InputDecoration(
                        hintText: 'Caută antrenamente...',
                        hintStyle: TextStyle(color: isDarkMode ? Colors.grey[400] : AppColors.textSecondary),
                        prefixIcon: Icon(Icons.search, color: isDarkMode ? Colors.white70 : AppColors.textSecondary),
                        filled: true,
                        fillColor: isDarkMode ? const Color(0xFF1E2638) : AppColors.lightGreyBg,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Secțiunea de planuri recomandate
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: SectionHeader(title: "Featured Plan"),
                  ),
                  const SizedBox(height: 12),
                  
                  // Listă orizontală de planuri recomandate
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: homeData.featuredPlans.length,
                      itemBuilder: (context, index) {
                        final plan = homeData.featuredPlans[index];
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          margin: const EdgeInsets.only(right: 16),
                          child: FeaturedPlanCard(
                            title: plan.title,
                            imageUrl: plan.imageUrl,
                            duration: plan.duration,
                            frequency: plan.frequency,
                            onStartPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Ai început planul: ${plan.title}! 🚀"),
                                  duration: const Duration(seconds: 2),
                                  backgroundColor: AppColors.primaryGreen,
                                ),
                              );
                              
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GymDetailScreen(
                                    customTitle: plan.title,
                                    customImageUrl: plan.imageUrl,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Antetul secțiunii de programe de antrenament
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: SectionHeader(title: "Workout Programs"),
                  ),
                  const SizedBox(height: 12),

                  // Filtrele orizontale pentru categorii
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: filters.map((filter) {
                        return _buildFilterChip(
                          context,
                          filter.id,
                          filter.name,
                          isSelected: filter.selected,
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Meniul derulant pentru opțiunile de sortare
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<SortCriteria>(
                          dropdownColor: isDarkMode ? const Color(0xFF1E2638) : Colors.white,
                          value: context.read<FitnessCubit>().sortCriteria,
                          icon: Icon(Icons.sort, color: isDarkMode ? Colors.white70 : AppColors.textSecondary),
                          elevation: 16,
                          style: TextStyle(color: isDarkMode ? Colors.white : AppColors.textPrimary),
                          onChanged: (SortCriteria? newValue) {
                            if (newValue != null) {
                              context.read<FitnessCubit>().setSortCriteria(newValue);
                            }
                          },
                          items: SortCriteria.values.map((SortCriteria value) {
                            return DropdownMenuItem<SortCriteria>(
                              value: value,
                              child: Text(_getSortLabel(value)),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Starea de listă goală (fără rezultate găsite)
                  if (state is FitnessEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40),
                      child: Center(
                        child: Text(
                          "Nu s-au găsit antrenamente pentru acest filtru și căutare.",
                          style: TextStyle(color: isDarkMode ? Colors.grey[400] : AppColors.textSecondary, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  else
                    // Lista verticală de programe de antrenament
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: workouts.length,
                      itemBuilder: (context, index) {
                        final workout = workouts[index];
                        final isFavorite = favoriteIds.contains(workout.id);

                        return Container(
                          height: 180,
                          margin: const EdgeInsets.only(bottom: 16),
                          child: WorkoutItemCard(
                            title: workout.title,
                            kcal: "${workout.calories} Kcal",
                            time: "${workout.durationMinutes} min",
                            isPro: workout.isPro,
                            imageUrl: workout.imageUrl,
                            isFavorite: isFavorite,
                            onFavoriteToggle: () {
                              context.read<FitnessCubit>().toggleFavorite(workout.id);
                            },
                          ),
                        );
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Descrierea prietenoasă pentru opțiunile de sortare
  String _getSortLabel(SortCriteria criteria) {
    switch (criteria) {
      case SortCriteria.titleAsc:
        return 'Nume (A → Z)';
      case SortCriteria.titleDesc:
        return 'Nume (Z → A)';
      case SortCriteria.caloriesAsc:
        return 'Calorii (puțin → mult)';
      case SortCriteria.caloriesDesc:
        return 'Calorii (mult → puțin)';
      case SortCriteria.durationAsc:
        return 'Durată (scurt → lung)';
      case SortCriteria.durationDesc:
        return 'Durată (lung → scurt)';
    }
  }

  // Butonul interactiv pentru filtrare pe categorii
  Widget _buildFilterChip(BuildContext context, String id, String label, {bool isSelected = false}) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Material(
        color: isSelected
            ? AppColors.primaryGreen
            : (isDarkMode ? const Color(0xFF1E2638) : AppColors.lightGreyBg),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () => context.read<FitnessCubit>().setFilter(id),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : (isDarkMode ? Colors.grey[300] : AppColors.textSecondary),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
