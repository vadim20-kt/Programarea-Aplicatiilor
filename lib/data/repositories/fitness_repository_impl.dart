import '../../domain/entities/fitness_entities.dart';
import '../../domain/repositories/fitness_repository.dart';
import '../datasources/fitness_remote_data_source.dart';

// STRATUL DATA: Implementarea Repozitoriului (FitnessRepositoryImpl)
// Această clasă conectează interfața din stratul Domain cu Sursa de Date Remote din Data.

/// Implementarea concretă a repozitoriului definit în Domain
class FitnessRepositoryImpl implements FitnessRepository {
  final FitnessRemoteDataSource remoteDataSource;

  FitnessRepositoryImpl({required this.remoteDataSource});

  /// Preluarea datelor de la sursa remote și returnarea lor ca entități de domeniu
  @override
  Future<FitnessDataEntity> getFitnessData() async {
    return await remoteDataSource.fetchFitnessData();
  }
}
