import '../../domain/entities/fitness_entities.dart';

// STRATUL DATA: Modele DTO (Data Transfer Objects)
// Această clasă conține mecanismele de serializare (toJson) și deserializare (fromJson)
// ale structurilor JSON primite prin protocolul HTTP de la REST API.
// Fiecare Model extinde Entitatea corespunzătoare din stratul Domain (Clean Architecture).

/// Modelul rădăcină ce conține întreaga structură JSON trimisă de API
class FitnessDataModel extends FitnessDataEntity {
  FitnessDataModel({
    required FitnessHomePageModel fitnessHomePage,
    required FitnessGymDetailsPageModel fitnessGymDetailsPage,
  }) : super(
          fitnessHomePage: fitnessHomePage,
          fitnessGymDetailsPage: fitnessGymDetailsPage,
        );

  /// Deserializare JSON: Transformă Map-ul decodat dintr-un răspuns HTTP în obiectul FitnessDataModel
  factory FitnessDataModel.fromJson(Map<String, dynamic> json) {
    return FitnessDataModel(
      fitnessHomePage: FitnessHomePageModel.fromJson(json['fitnessHomePage']),
      fitnessGymDetailsPage: FitnessGymDetailsPageModel.fromJson(json['fitnessGymDetailsPage']),
    );
  }

  /// Serializare JSON: Convertește obiectul Dart înapoi într-o hartă JSON (util pentru trimitere date la API)
  Map<String, dynamic> toJson() {
    return {
      'fitnessHomePage': (fitnessHomePage as FitnessHomePageModel).toJson(),
      'fitnessGymDetailsPage': (fitnessGymDetailsPage as FitnessGymDetailsPageModel).toJson(),
    };
  }
}

/// Model pentru secțiunea Paginii Principale (fitnessHomePage)
class FitnessHomePageModel extends FitnessHomePageEntity {
  FitnessHomePageModel({
    required HeaderModel header,
    required TodaysChallengeModel todaysChallenge,
    required List<FeaturedPlanModel> featuredPlans,
    required WorkoutProgramsModel workoutPrograms,
  }) : super(
          header: header,
          todaysChallenge: todaysChallenge,
          featuredPlans: featuredPlans,
          workoutPrograms: workoutPrograms,
        );

  /// Deserializează sub-arborii din JSON: header, todaysChallenge, featuredPlans (listă) și workoutPrograms
  factory FitnessHomePageModel.fromJson(Map<String, dynamic> json) {
    return FitnessHomePageModel(
      header: HeaderModel.fromJson(json['header']),
      todaysChallenge: TodaysChallengeModel.fromJson(json['todaysChallenge']),
      featuredPlans: (json['featuredPlans'] as List)
          .map((e) => FeaturedPlanModel.fromJson(e))
          .toList(),
      workoutPrograms: WorkoutProgramsModel.fromJson(json['workoutPrograms']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'header': (header as HeaderModel).toJson(),
      'todaysChallenge': (todaysChallenge as TodaysChallengeModel).toJson(),
      'featuredPlans': featuredPlans.map((e) => (e as FeaturedPlanModel).toJson()).toList(),
      'workoutPrograms': (workoutPrograms as WorkoutProgramsModel).toJson(),
    };
  }
}

/// Model pentru Antet (dată + salut)
class HeaderModel extends HeaderEntity {
  HeaderModel({required super.date, required super.greeting});

  factory HeaderModel.fromJson(Map<String, dynamic> json) {
    return HeaderModel(
      date: json['date'] ?? '',
      greeting: json['greeting'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'date': date, 'greeting': greeting};
}

/// Model pentru Provocarea Zilei (todaysChallenge)
class TodaysChallengeModel extends TodaysChallengeEntity {
  TodaysChallengeModel({
    required super.title,
    required super.activity,
    required super.completed,
    required super.total,
    required super.progress,
  });

  /// Mapează tipurile numerice din JSON (num) în int și double Dart
  factory TodaysChallengeModel.fromJson(Map<String, dynamic> json) {
    return TodaysChallengeModel(
      title: json['title'] ?? '',
      activity: json['activity'] ?? '',
      completed: (json['completed'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'activity': activity,
      'completed': completed,
      'total': total,
      'progress': progress,
    };
  }
}

/// Model pentru un Plan Recomandat (FeaturedPlan)
class FeaturedPlanModel extends FeaturedPlanEntity {
  FeaturedPlanModel({
    required super.id,
    required super.title,
    required super.duration,
    required super.frequency,
    required super.actionLabel,
    required super.imageUrl,
  });

  factory FeaturedPlanModel.fromJson(Map<String, dynamic> json) {
    return FeaturedPlanModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      duration: json['duration'] ?? '',
      frequency: json['frequency'] ?? '',
      actionLabel: json['actionLabel'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'duration': duration,
      'frequency': frequency,
      'actionLabel': actionLabel,
      'imageUrl': imageUrl,
    };
  }
}

/// Model pentru lista de programe de antrenament și filtrele asociate
class WorkoutProgramsModel extends WorkoutProgramsEntity {
  WorkoutProgramsModel({
    required List<FilterItemModel> filters,
    required List<WorkoutItemModel> items,
  }) : super(filters: filters, items: items);

  factory WorkoutProgramsModel.fromJson(Map<String, dynamic> json) {
    return WorkoutProgramsModel(
      filters: (json['filters'] as List).map((e) => FilterItemModel.fromJson(e)).toList(),
      items: (json['items'] as List).map((e) => WorkoutItemModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'filters': filters.map((e) => (e as FilterItemModel).toJson()).toList(),
      'items': items.map((e) => (e as WorkoutItemModel).toJson()).toList(),
    };
  }
}

/// Model pentru un element de filtru (categorie)
class FilterItemModel extends FilterItemEntity {
  FilterItemModel({required super.id, required super.name, required super.selected});

  factory FilterItemModel.fromJson(Map<String, dynamic> json) {
    return FilterItemModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      selected: json['selected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'selected': selected};
}

/// Model pentru un Antrenament Individual (WorkoutItem)
class WorkoutItemModel extends WorkoutItemEntity {
  WorkoutItemModel({
    required super.id,
    required super.title,
    required super.calories,
    required super.durationMinutes,
    required super.isPro,
    required super.imageUrl,
    super.category,
  });

  factory WorkoutItemModel.fromJson(Map<String, dynamic> json) {
    return WorkoutItemModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      calories: (json['calories'] as num?)?.toInt() ?? 0,
      durationMinutes: (json['durationMinutes'] as num?)?.toInt() ?? 0,
      isPro: json['isPro'] ?? false,
      imageUrl: json['imageUrl'] ?? '',
      category: json['category'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'calories': calories,
      'durationMinutes': durationMinutes,
      'isPro': isPro,
      'imageUrl': imageUrl,
      if (category != null) 'category': category,
    };
  }
}

/// Model pentru secțiunea Detalii Sală (fitnessGymDetailsPage)
class FitnessGymDetailsPageModel extends FitnessGymDetailsPageEntity {
  FitnessGymDetailsPageModel({required GymModel gym}) : super(gym: gym);

  factory FitnessGymDetailsPageModel.fromJson(Map<String, dynamic> json) {
    return FitnessGymDetailsPageModel(gym: GymModel.fromJson(json['gym']));
  }

  Map<String, dynamic> toJson() => {'gym': (gym as GymModel).toJson()};
}

/// Model pentru o Sală de Fitness (Gym)
class GymModel extends GymEntity {
  GymModel({
    required super.id,
    required super.name,
    required super.location,
    required super.heroImageUrl,
    required super.rating,
    required super.reviewCount,
    required super.description,
    required List<AmenityModel> amenities,
    required PricingModel pricing,
  }) : super(amenities: amenities, pricing: pricing);

  factory GymModel.fromJson(Map<String, dynamic> json) {
    return GymModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      heroImageUrl: json['heroImageUrl'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      description: json['description'] ?? '',
      amenities: (json['amenities'] as List? ?? []).map((e) => AmenityModel.fromJson(e)).toList(),
      pricing: PricingModel.fromJson(json['pricing'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'heroImageUrl': heroImageUrl,
      'rating': rating,
      'reviewCount': reviewCount,
      'description': description,
      'amenities': amenities.map((e) => (e as AmenityModel).toJson()).toList(),
      'pricing': (pricing as PricingModel).toJson(),
    };
  }
}

/// Model pentru o Facilitate a sălii (Amenity)
class AmenityModel extends AmenityEntity {
  AmenityModel({required super.id, required super.name});

  factory AmenityModel.fromJson(Map<String, dynamic> json) {
    return AmenityModel(id: json['id'] ?? '', name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

/// Model pentru Prețul abonamentului (Pricing)
class PricingModel extends PricingEntity {
  PricingModel({
    required super.amount,
    required super.currency,
    required super.period,
    required super.formatted,
  });

  factory PricingModel.fromJson(Map<String, dynamic> json) {
    return PricingModel(
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] ?? '',
      period: json['period'] ?? '',
      formatted: json['formatted'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
      'period': period,
      'formatted': formatted,
    };
  }
}
