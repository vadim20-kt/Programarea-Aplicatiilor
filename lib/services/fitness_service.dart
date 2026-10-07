import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/fitness_model.dart';

// Serviciu pentru citirea și parsarea asincronă a datelor JSON din resursele aplicației
class FitnessService {
  // Încarcă fișierul JSON din directorul assets și îl convertește în obiecte Dart
  Future<FitnessData> loadFitnessData() async {
    // Citirea textului JSON din assets
    final String jsonString = await rootBundle.loadString('assets/fitness_data.json');
    
    // Decodarea șirului JSON într-o structură de tip Map
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    
    // Conversia hărții în instanță a modelului FitnessData
    return FitnessData.fromJson(jsonMap);
  }
}
