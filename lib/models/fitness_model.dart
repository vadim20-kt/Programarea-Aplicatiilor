import '../domain/entities/fitness_entities.dart';

// Modelul principal pentru Presentation / UI
class FitnessData {
  final FitnessHomePage fitnessHomePage;
  final FitnessGymDetailsPage fitnessGymDetailsPage;

  FitnessData({required this.fitnessHomePage, required this.fitnessGymDetailsPage});

  factory FitnessData.fromJson(Map<String, dynamic> json) {
    return FitnessData(
      fitnessHomePage: FitnessHomePage.fromJson(json['fitnessHomePage']),
      fitnessGymDetailsPage: FitnessGymDetailsPage.fromJson(json['fitnessGymDetailsPage']),
    );
  }

  factory FitnessData.fromEntity(FitnessDataEntity entity) {
    return FitnessData(
      fitnessHomePage: FitnessHomePage.fromEntity(entity.fitnessHomePage),
      fitnessGymDetailsPage: FitnessGymDetailsPage.fromEntity(entity.fitnessGymDetailsPage),
    );
  }
}

// Model pentru datele de pe pagina principală
class FitnessHomePage {
  final Header header;
  final TodaysChallenge todaysChallenge;
  final List<FeaturedPlan> featuredPlans;
  final WorkoutPrograms workoutPrograms;

  FitnessHomePage({
    required this.header,
    required this.todaysChallenge,
    required this.featuredPlans,
    required this.workoutPrograms,
  });

  factory FitnessHomePage.fromJson(Map<String, dynamic> json) {
    return FitnessHomePage(
      header: Header.fromJson(json['header']),
      todaysChallenge: TodaysChallenge.fromJson(json['todaysChallenge']),
      featuredPlans: (json['featuredPlans'] as List).map((e) => FeaturedPlan.fromJson(e)).toList(),
      workoutPrograms: WorkoutPrograms.fromJson(json['workoutPrograms']),
    );
  }

  factory FitnessHomePage.fromEntity(FitnessHomePageEntity entity) {
    return FitnessHomePage(
      header: Header.fromEntity(entity.header),
      todaysChallenge: TodaysChallenge.fromEntity(entity.todaysChallenge),
      featuredPlans: entity.featuredPlans.map((e) => FeaturedPlan.fromEntity(e)).toList(),
      workoutPrograms: WorkoutPrograms.fromEntity(entity.workoutPrograms),
    );
  }
}

// Model pentru antet
class Header {
  final String date;
  final String greeting;

  Header({required this.date, required this.greeting});

  factory Header.fromJson(Map<String, dynamic> json) {
    return Header(
      date: json['date'] ?? '',
      greeting: json['greeting'] ?? '',
    );
  }

  factory Header.fromEntity(HeaderEntity entity) {
    return Header(date: entity.date, greeting: entity.greeting);
  }
}

// Model pentru provocarea zilei
class TodaysChallenge {
  final String title;
  final String activity;
  final int completed;
  final int total;
  final double progress;

  TodaysChallenge({
    required this.title,
    required this.activity,
    required this.completed,
    required this.total,
    required this.progress,
  });

  factory TodaysChallenge.fromJson(Map<String, dynamic> json) {
    return TodaysChallenge(
      title: json['title'] ?? '',
      activity: json['activity'] ?? '',
      completed: (json['completed'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
    );
  }

  factory TodaysChallenge.fromEntity(TodaysChallengeEntity entity) {
    return TodaysChallenge(
      title: entity.title,
      activity: entity.activity,
      completed: entity.completed,
      total: entity.total,
      progress: entity.progress,
    );
  }
}

// Model pentru planurile recomandate
class FeaturedPlan {
  final String id;
  final String title;
  final String duration;
  final String frequency;
  final String actionLabel;
  final String imageUrl;

  FeaturedPlan({
    required this.id,
    required this.title,
    required this.duration,
    required this.frequency,
    required this.actionLabel,
    required this.imageUrl,
  });

  factory FeaturedPlan.fromJson(Map<String, dynamic> json) {
    return FeaturedPlan(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      duration: json['duration'] ?? '',
      frequency: json['frequency'] ?? '',
      actionLabel: json['actionLabel'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  factory FeaturedPlan.fromEntity(FeaturedPlanEntity entity) {
    return FeaturedPlan(
      id: entity.id,
      title: entity.title,
      duration: entity.duration,
      frequency: entity.frequency,
      actionLabel: entity.actionLabel,
      imageUrl: entity.imageUrl,
    );
  }
}

// Model pentru secțiunea de programe și filtre
class WorkoutPrograms {
  final List<FilterItem> filters;
  final List<WorkoutItem> items;

  WorkoutPrograms({required this.filters, required this.items});

  factory WorkoutPrograms.fromJson(Map<String, dynamic> json) {
    return WorkoutPrograms(
      filters: (json['filters'] as List).map((e) => FilterItem.fromJson(e)).toList(),
      items: (json['items'] as List).map((e) => WorkoutItem.fromJson(e)).toList(),
    );
  }

  factory WorkoutPrograms.fromEntity(WorkoutProgramsEntity entity) {
    return WorkoutPrograms(
      filters: entity.filters.map((e) => FilterItem.fromEntity(e)).toList(),
      items: entity.items.map((e) => WorkoutItem.fromEntity(e)).toList(),
    );
  }
}

// Model pentru opțiunile de filtrare
class FilterItem {
  final String id;
  final String name;
  bool selected;

  FilterItem({required this.id, required this.name, required this.selected});

  factory FilterItem.fromJson(Map<String, dynamic> json) {
    return FilterItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      selected: json['selected'] ?? false,
    );
  }

  factory FilterItem.fromEntity(FilterItemEntity entity) {
    return FilterItem(id: entity.id, name: entity.name, selected: entity.selected);
  }
}

// Model pentru fiecare antrenament individual
class WorkoutItem {
  final String id;
  final String title;
  final int calories;
  final int durationMinutes;
  final bool isPro;
  final String imageUrl;
  final String? category;

  WorkoutItem({
    required this.id,
    required this.title,
    required this.calories,
    required this.durationMinutes,
    required this.isPro,
    required this.imageUrl,
    this.category,
  });

  factory WorkoutItem.fromJson(Map<String, dynamic> json) {
    return WorkoutItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      calories: (json['calories'] as num?)?.toInt() ?? 0,
      durationMinutes: (json['durationMinutes'] as num?)?.toInt() ?? 0,
      isPro: json['isPro'] ?? false,
      imageUrl: json['imageUrl'] ?? '',
      category: json['category'] as String?,
    );
  }

  factory WorkoutItem.fromEntity(WorkoutItemEntity entity) {
    return WorkoutItem(
      id: entity.id,
      title: entity.title,
      calories: entity.calories,
      durationMinutes: entity.durationMinutes,
      isPro: entity.isPro,
      imageUrl: entity.imageUrl,
      category: entity.category,
    );
  }
}

// Model pentru pagina de detalii a sălii de fitness
class FitnessGymDetailsPage {
  final Gym gym;

  FitnessGymDetailsPage({required this.gym});

  factory FitnessGymDetailsPage.fromJson(Map<String, dynamic> json) {
    return FitnessGymDetailsPage(gym: Gym.fromJson(json['gym']));
  }

  factory FitnessGymDetailsPage.fromEntity(FitnessGymDetailsPageEntity entity) {
    return FitnessGymDetailsPage(gym: Gym.fromEntity(entity.gym));
  }
}

// Model cu informații despre o sală de fitness
class Gym {
  final String id;
  final String name;
  final String location;
  final String heroImageUrl;
  final double rating;
  final int reviewCount;
  final String description;
  final List<Amenity> amenities;
  final Pricing pricing;

  Gym({
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

  factory Gym.fromJson(Map<String, dynamic> json) {
    return Gym(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      heroImageUrl: json['heroImageUrl'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      description: json['description'] ?? '',
      amenities: (json['amenities'] as List? ?? []).map((e) => Amenity.fromJson(e)).toList(),
      pricing: Pricing.fromJson(json['pricing'] ?? {}),
    );
  }

  factory Gym.fromEntity(GymEntity entity) {
    return Gym(
      id: entity.id,
      name: entity.name,
      location: entity.location,
      heroImageUrl: entity.heroImageUrl,
      rating: entity.rating,
      reviewCount: entity.reviewCount,
      description: entity.description,
      amenities: entity.amenities.map((e) => Amenity.fromEntity(e)).toList(),
      pricing: Pricing.fromEntity(entity.pricing),
    );
  }
}

// Model pentru facilitățile sălii (dușuri, vestiare, etc.)
class Amenity {
  final String id;
  final String name;

  Amenity({required this.id, required this.name});

  factory Amenity.fromJson(Map<String, dynamic> json) {
    return Amenity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  factory Amenity.fromEntity(AmenityEntity entity) {
    return Amenity(id: entity.id, name: entity.name);
  }
}

// Model pentru prețul abonamentului
class Pricing {
  final double amount;
  final String currency;
  final String period;
  final String formatted;

  Pricing({
    required this.amount,
    required this.currency,
    required this.period,
    required this.formatted,
  });

  factory Pricing.fromJson(Map<String, dynamic> json) {
    return Pricing(
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] ?? '',
      period: json['period'] ?? '',
      formatted: json['formatted'] ?? '',
    );
  }

  factory Pricing.fromEntity(PricingEntity entity) {
    return Pricing(
      amount: entity.amount,
      currency: entity.currency,
      period: entity.period,
      formatted: entity.formatted,
    );
  }
}
