import 'package:flutter/material.dart';
import '../models/fitness_model.dart';
import '../services/fitness_service.dart';

// Provider alternativ pentru gestionarea stării aplicației prin ChangeNotifier
class FitnessProvider extends ChangeNotifier {
  final FitnessService _service = FitnessService();

  // Stările interne ale aplicației
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';
  FitnessData? _fitnessData;

  // Filtrul selectat în prezent
  String _selectedFilter = 'all';

  // Getters publici pentru interfața utilizator
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;
  FitnessData? get fitnessData => _fitnessData;
  String get selectedFilter => _selectedFilter;

  // Încărcare asincronă a datelor din fișierul JSON
  Future<void> loadData() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      _fitnessData = await _service.loadFitnessData();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _hasError = true;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Schimbarea filtrului activ
  void setFilter(String filterId) {
    _selectedFilter = filterId;
    if (_fitnessData != null) {
      for (var filter in _fitnessData!.fitnessHomePage.workoutPrograms.filters) {
        filter.selected = (filter.id == filterId);
      }
    }
    notifyListeners();
  }

  // Obținerea listei de antrenamente filtrate
  List<WorkoutItem> get filteredWorkouts {
    if (_fitnessData == null) return [];
    
    final allItems = _fitnessData!.fitnessHomePage.workoutPrograms.items;
    if (_selectedFilter == 'all') {
      return allItems;
    }

    return allItems.where((item) {
      final query = _selectedFilter.toLowerCase();
      final matchesTitle = item.title.toLowerCase().contains(query);
      final matchesCategory = item.category != null && item.category!.toLowerCase().contains(query);
      return matchesTitle || matchesCategory;
    }).toList();
  }
}
