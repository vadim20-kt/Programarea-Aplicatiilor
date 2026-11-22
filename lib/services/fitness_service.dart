import '../data/datasources/fitness_remote_data_source.dart';
import '../data/repositories/fitness_repository_impl.dart';
import '../domain/usecases/get_fitness_data.dart';
import '../models/fitness_model.dart';

// STRATUL PRESENTATION / SERVICE: Serviciu Bridge pentru Clean Architecture
// Face legătura între cazurile de utilizare din Domain și componentele BLoC/Cubit.
// Instanțiază automat dependențele (RemoteDataSource -> Repository -> UseCase).

/// Serviciul principal de acces la datele de fitness
class FitnessService {
  late final GetFitnessDataUseCase _getFitnessDataUseCase;

  /// Constructor ce permite injectarea cazului de utilizare sau crearea automată a arborelui de dependențe
  FitnessService({GetFitnessDataUseCase? getFitnessDataUseCase}) {
    if (getFitnessDataUseCase != null) {
      _getFitnessDataUseCase = getFitnessDataUseCase;
    } else {
      // Configurare automată a Clean Architecture (Data Source -> Repository -> UseCase)
      final remoteDataSource = FitnessRemoteDataSourceImpl();
      final repository = FitnessRepositoryImpl(remoteDataSource: remoteDataSource);
      _getFitnessDataUseCase = GetFitnessDataUseCase(repository);
    }
  }

  /// Încarcă asincron datele de la REST API / Remote Data Source și le convertește în modele UI
  Future<FitnessData> loadFitnessData() async {
    final entity = await _getFitnessDataUseCase.execute();
    // Conversie din entitate Domain în modelul Presentation/UI
    return FitnessData.fromEntity(entity);
  }
}
