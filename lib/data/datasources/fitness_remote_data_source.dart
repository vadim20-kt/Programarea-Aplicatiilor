import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import '../models/fitness_dto.dart';

// STRATUL DATA: Sursa de Date la Distanță (Remote Data Source)
// Această clasă efectuează cererile HTTP/HTTPS asincrone către serviciul REST API.
// Tratează răspunsurile HTTP (statusCode == 200), erorile de conexiune și fallback-ul offline.

/// Contractul abstract pentru sursa de date remote
abstract class FitnessRemoteDataSource {
  Future<FitnessDataModel> fetchFitnessData();
}

/// Implementarea concretă a sursei de date remote ce folosește clientul HTTP
class FitnessRemoteDataSourceImpl implements FitnessRemoteDataSource {
  final http.Client client;

  /// Adresa URL a serviciului Web REST API (Endpoint-ul de unde preluăm structura JSON)
  static const String apiUrl =
      'https://raw.githubusercontent.com/json-store/fitness-app-data/main/fitness_data.json';

  FitnessRemoteDataSourceImpl({http.Client? client})
      : client = client ?? http.Client();

  /// Preluarea asincronă a datelor JSON de la API-ul REST prin protocolul HTTP GET
  @override
  Future<FitnessDataModel> fetchFitnessData() async {
    try {
      // Trimiterea cererii HTTP GET cu timeout de 5 secunde și headere JSON
      final response = await client.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 5));

      // Verificăm dacă răspunsul HTTP este 200 OK (Reușit)
      if (response.statusCode == 200) {
        // Deserializăm corpul răspunsului (String JSON -> Map Dart)
        final Map<String, dynamic> jsonMap = json.decode(response.body);
        // Construim instanța modelului DTO
        return FitnessDataModel.fromJson(jsonMap);
      } else {
        // Dacă serverul întoarce un cod de eroare (ex: 404 sau 500), apelăm mecanismul de siguranță (fallback)
        return await _loadFromAssets();
      }
    } catch (e) {
      // În caz de excepție de rețea (lipsă internet, timeout etc.), citim datele locale din assets ca fallback
      return await _loadFromAssets();
    }
  }

  /// Metodă privată de rezervă (fallback offline) pentru a preveni blocarea aplicației în caz de lipsă internet
  Future<FitnessDataModel> _loadFromAssets() async {
    final String jsonString = await rootBundle.loadString('assets/fitness_data.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return FitnessDataModel.fromJson(jsonMap);
  }
}
