import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit pentru gestionarea modul de temă (Luminos / Întunecat / Sistem)
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  // Comutare rapidă între Dark și Light Mode
  void toggleTheme() {
    if (state == ThemeMode.dark) {
      emit(ThemeMode.light);
    } else {
      emit(ThemeMode.dark);
    }
  }

  // Setare explicită a modului
  void setThemeMode(ThemeMode mode) {
    emit(mode);
  }
}
