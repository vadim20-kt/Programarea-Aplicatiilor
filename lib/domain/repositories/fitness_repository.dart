import '../entities/fitness_entities.dart';

// STRATUL DOMAIN: Contractul Repozitoriului (Repository Interface)
// Definește operațiunile abstracte de preluare/gestionare a datelor fără a depinde
// de nicio implementare concretă (cum ar fi HTTP REST API sau Baze de Date).

/// Contractul abstract pentru Repozitoriul de Fitness
abstract class FitnessRepository {
  /// Preluarea datelor de fitness în mod asincron
  Future<FitnessDataEntity> getFitnessData();
}
