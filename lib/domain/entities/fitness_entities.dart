// STRATUL DOMAIN: Entitățile de Business (Domain Entities - Clean Architecture)
// Entitățile reprezintă obiectele de business fundamentale ale aplicației.
// Ele sunt complet pure, independente de orice bibliotecă de UI sau sursă de date externe.

/// Entitatea rădăcină ce încapsulează toate datele aplicației
class FitnessDataEntity {
  final FitnessHomePageEntity fitnessHomePage;
  final FitnessGymDetailsPageEntity fitnessGymDetailsPage;

  FitnessDataEntity({
    required this.fitnessHomePage,
    required this.fitnessGymDetailsPage,
  });
}

/// Entitatea pentru datele Paginii Principale (Header, Challenge, Planuri, Programe)
class FitnessHomePageEntity {
  final HeaderEntity header;
  final TodaysChallengeEntity todaysChallenge;
  final List<FeaturedPlanEntity> featuredPlans;
  final WorkoutProgramsEntity workoutPrograms;

  FitnessHomePageEntity({
    required this.header,
    required this.todaysChallenge,
    required this.featuredPlans,
    required this.workoutPrograms,
  });
}

/// Entitatea pentru datele de Antet (dată și salut)
class HeaderEntity {
  final String date;
  final String greeting;

  HeaderEntity({required this.date, required this.greeting});
}

/// Entitatea pentru Provocarea Zilei (activitate, progres, număr completat)
class TodaysChallengeEntity {
  final String title;
  final String activity;
  final int completed;
  final int total;
  final double progress;

  TodaysChallengeEntity({
    required this.title,
    required this.activity,
    required this.completed,
    required this.total,
    required this.progress,
  });
}

/// Entitatea pentru Planurile Recomandate (titlu, durată, frecvență, imagine)
class FeaturedPlanEntity {
  final String id;
  final String title;
  final String duration;
  final String frequency;
  final String actionLabel;
  final String imageUrl;

  FeaturedPlanEntity({
    required this.id,
    required this.title,
    required this.duration,
    required this.frequency,
    required this.actionLabel,
    required this.imageUrl,
  });
}

/// Entitatea pentru programele de antrenament și filtrele acestora
class WorkoutProgramsEntity {
  final List<FilterItemEntity> filters;
  final List<WorkoutItemEntity> items;

  WorkoutProgramsEntity({required this.filters, required this.items});
}

/// Entitatea pentru un filtru de categorie (nume, stare de selectare)
class FilterItemEntity {
  final String id;
  final String name;
  bool selected;

  FilterItemEntity({required this.id, required this.name, required this.selected});
}

/// Entitatea pentru un Antrenament Individual (calorii, durată, nivel pro)
class WorkoutItemEntity {
  final String id;
  final String title;
  final int calories;
  final int durationMinutes;
  final bool isPro;
  final String imageUrl;
  final String? category;

  WorkoutItemEntity({
    required this.id,
    required this.title,
    required this.calories,
    required this.durationMinutes,
    required this.isPro,
    required this.imageUrl,
    this.category,
  });
}

/// Entitatea pentru Pagina de Detalii a Sălii (Gym)
class FitnessGymDetailsPageEntity {
  final GymEntity gym;

  FitnessGymDetailsPageEntity({required this.gym});
}

/// Entitatea pentru o Sală de Fitness (locație, rating, recenzii, facilități, preț)
class GymEntity {
  final String id;
  final String name;
  final String location;
  final String heroImageUrl;
  final double rating;
  final int reviewCount;
  final String description;
  final List<AmenityEntity> amenities;
  final PricingEntity pricing;

  GymEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.heroImageUrl,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.amenities,
    required this.pricing,
  });
}

/// Entitatea pentru o Facilitate a sălii (dușuri, vestiare etc.)
class AmenityEntity {
  final String id;
  final String name;

  AmenityEntity({required this.id, required this.name});
}

/// Entitatea pentru Prețul abonamentului (sumă, monedă, perioadă)
class PricingEntity {
  final double amount;
  final String currency;
  final String period;
  final String formatted;

  PricingEntity({
    required this.amount,
    required this.currency,
    required this.period,
    required this.formatted,
  });
}
