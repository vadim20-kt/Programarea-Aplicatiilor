// Modelul principal care conține toate datele din JSON
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
}

// Model pentru antet (data și salutul)
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
}

// Model pentru pagina de detalii a sălii de fitness
class FitnessGymDetailsPage {
  final Gym gym;

  FitnessGymDetailsPage({required this.gym});

  factory FitnessGymDetailsPage.fromJson(Map<String, dynamic> json) {
    return FitnessGymDetailsPage(gym: Gym.fromJson(json['gym']));
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
}
