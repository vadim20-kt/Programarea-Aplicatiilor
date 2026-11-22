import '../entities/fitness_entities.dart';
import '../repositories/fitness_repository.dart';

// STRATUL DOMAIN: Caz de Utilizare (Use Case / Interactor)
// Reprezintă o acțiune specifică de business.
// Are ca singură responsabilitate apelarea repozitoriului pentru obținerea datelor.

/// Cazul de utilizare pentru obținerea tuturor datelor de fitness de la API
class GetFitnessDataUseCase {
  final FitnessRepository repository;

  GetFitnessDataUseCase(this.repository);

  /// Execută cazul de utilizare în mod asincron
  Future<FitnessDataEntity> execute() async {
    return await repository.getFitnessData();
  }
}
