import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/fitness_model.dart';
import '../services/fitness_service.dart';

// Clasa de bază pentru stările aplicației de fitness
abstract class FitnessState {}

// Starea inițială, înainte de începerea încărcării datelor
class FitnessInitial extends FitnessState {}

// Starea de încărcare (afișează indicatorul de progres)
class FitnessLoading extends FitnessState {}

// Starea de succes (conține datele încărcate, lista filtrată și favoritele)
class FitnessSuccess extends FitnessState {
  final FitnessData data;
  final String selectedFilter;
  final List<WorkoutItem> filteredWorkouts;
  final Set<String> favoriteIds;

  FitnessSuccess({
    required this.data,
    required this.selectedFilter,
    required this.filteredWorkouts,
    required this.favoriteIds,
  });
}

// Starea de listă goală (când căutarea sau filtrul nu găsesc rezultate)
class FitnessEmpty extends FitnessState {
  final FitnessData data;
  final String selectedFilter;
  final Set<String> favoriteIds;

  FitnessEmpty({
    required this.data,
    required this.selectedFilter,
    required this.favoriteIds,
  });
}

// Starea de eroare (conține mesajul de eroare)
class FitnessError extends FitnessState {
  final String message;
  FitnessError(this.message);
}

// Criterii pentru sortarea antrenamentelor
enum SortCriteria { 
  titleAsc,     // Titlu de la A la Z
  titleDesc,    // Titlu de la Z la A
  caloriesAsc,  // Calorii crescător
  caloriesDesc, // Calorii descrescător
  durationAsc,  // Durată crescătoare
  durationDesc, // Durată descrescătoare
}

// Cubit pentru gestionarea stării aplicației (încărcare, filtrare, căutare, sortare și favorite)
class FitnessCubit extends Cubit<FitnessState> {
  // Serviciul pentru citirea datelor din fișierul JSON
  final FitnessService _service = FitnessService();
  
  // Memorie tampon pentru datele brute din JSON
  FitnessData? _cachedData;

  // Filtrul selectat în prezent (implicit 'all')
  String _currentFilter = 'all';

  // Textul introdus în câmpul de căutare
  String _searchQuery = '';

  // Criteriul curent de sortare (implicit alfabetic A-Z)
  SortCriteria _sortCriteria = SortCriteria.titleAsc;

  // Set cu ID-urile antrenamentelor adăugate la favorite
  final Set<String> _favoriteIds = {};

  FitnessCubit() : super(FitnessInitial());

  // Returnează criteriul curent de sortare pentru a fi afișat în interfață
  SortCriteria get sortCriteria => _sortCriteria;

  // Încarcă asincron datele din fișierul JSON
  Future<void> loadData() async {
    emit(FitnessLoading());
    try {
      _cachedData = await _service.loadFitnessData();
      _applyFilterAndEmit(_currentFilter);
    } catch (e) {
      emit(FitnessError("Eroare la încărcarea datelor: ${e.toString()}"));
    }
  }

  // Schimbă categoria/filtrul selectat
  void setFilter(String filterId) {
    _currentFilter = filterId;
    if (_cachedData != null) {
      _applyFilterAndEmit(filterId);
    }
  }

  // Actualizează textul de căutare introdus de utilizator
  void setSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    if (_cachedData != null) {
      _applyFilterAndEmit(_currentFilter);
    }
  }

  // Schimbă opțiunea de sortare
  void setSortCriteria(SortCriteria criteria) {
    _sortCriteria = criteria;
    if (_cachedData != null) {
      _applyFilterAndEmit(_currentFilter);
    }
  }

  // Adaugă sau scoate un antrenament din lista de favorite
  void toggleFavorite(String id) {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    if (_cachedData != null) {
      _applyFilterAndEmit(_currentFilter);
    }
  }

  // Aplică toate filtrele, căutarea și sortarea, apoi emite starea corespunzătoare
  void _applyFilterAndEmit(String filterId) {
    if (_cachedData == null) return;

    // Marchează filtrul activ în datele colectate
    for (var filter in _cachedData!.fitnessHomePage.workoutPrograms.filters) {
      filter.selected = (filter.id == filterId);
    }

    // Lista completă de antrenamente
    final allItems = _cachedData!.fitnessHomePage.workoutPrograms.items;
    
    // Pasul 1: Filtrare după categorie sau titlu
    List<WorkoutItem> filteredItems;
    if (filterId == 'all') {
      filteredItems = allItems;
    } else {
      filteredItems = allItems.where((item) {
        final query = filterId.toLowerCase();
        final matchesTitle = item.title.toLowerCase().contains(query);
        final matchesCategory = item.category != null && item.category!.toLowerCase().contains(query);
        return matchesTitle || matchesCategory;
      }).toList();
    }
    
    // Pasul 2: Filtrare după textul din căutare
    if (_searchQuery.isNotEmpty) {
      filteredItems = filteredItems.where((item) {
        return item.title.toLowerCase().contains(_searchQuery);
      }).toList();
    }
    
    // Pasul 3: Sortare după criteriul ales
    switch (_sortCriteria) {
      case SortCriteria.titleAsc:
        filteredItems.sort((a, b) => a.title.compareTo(b.title));
        break;
      case SortCriteria.titleDesc:
        filteredItems.sort((a, b) => b.title.compareTo(a.title));
        break;
      case SortCriteria.caloriesAsc:
        filteredItems.sort((a, b) => a.calories.compareTo(b.calories));
        break;
      case SortCriteria.caloriesDesc:
        filteredItems.sort((a, b) => b.calories.compareTo(a.calories));
        break;
      case SortCriteria.durationAsc:
        filteredItems.sort((a, b) => a.durationMinutes.compareTo(b.durationMinutes));
        break;
      case SortCriteria.durationDesc:
        filteredItems.sort((a, b) => b.durationMinutes.compareTo(a.durationMinutes));
        break;
    }

    // Pasul 4: Emite starea finală (Empty sau Success)
    if (filteredItems.isEmpty) {
      emit(FitnessEmpty(
        data: _cachedData!,
        selectedFilter: filterId,
        favoriteIds: Set.from(_favoriteIds),
      ));
    } else {
      emit(FitnessSuccess(
        data: _cachedData!,
        selectedFilter: filterId,
        filteredWorkouts: filteredItems,
        favoriteIds: Set.from(_favoriteIds),
      ));
    }
  }
}
