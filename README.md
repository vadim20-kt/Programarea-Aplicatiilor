# Laboratorul 4: Aplicație Mobilă Flutter cu Clean Architecture & REST API 🏋️‍♂️

O aplicație mobilă modernă pentru gestionarea antrenamentelor și sălilor de fitness (**Vector Gym**), dezvoltată în cadrul lucrării de laborator **Laboratorul 4**. 

Aplicația integrează servicii Web de tip **REST API** prin protocolul **HTTP/HTTPS**, procesează datele în format **JSON** și este structurată pe straturi distincte conform principiilor **Clean Architecture**.

---

## 🎯 Obiectivele Lucrării de Laborator

* **Integrat REST API (HTTP)**: Preluarea asincronă a datelor de la un serviciu Web extern prin cereri HTTP `GET` utilizând pachetul `http`.
* **Serializare & Deserializare JSON**: Transformarea datelor brute din format JSON în obiecte de date Dart prin metode `fromJson` și `toJson`.
* **Clean Architecture**: Separarea strictă a responsabilităților în 3 straturi independente (**Presentation**, **Domain** și **Data**).
* **Managementul Stării & Asincronism**: Utilizarea `flutter_bloc` / `FitnessCubit` pentru gestionarea stărilor de încărcare (`Loading`), succes (`Success`), căutare goală (`Empty`) și erori de rețea (`Error`) cu buton de Reîncercare (Retry).
* **Interfață Utilizator Adaptivă**: Păstrarea design-ului vizual Vector Gym cu suport complet pentru **Light Mode** și **Dark Mode**, containere clar delimitate și widget-uri reutilizabile.

---

## 🏗️ Arhitectura Proiectului (Clean Architecture)

Proiectul respectă Regula Dependenței (Dependency Rule), astfel încât stratul de domenii (Domain) este complet izolat și independent de UI sau de bibliotecile externe:

```text
lib/
├── domain/                      # Stratul DOMAIN (Logica de Business Pure Dart)
│   ├── entities/
│   │   └── fitness_entities.dart # Entitățile de domeniu (FitnessDataEntity, GymEntity, etc.)
│   ├── repositories/
│   │   └── fitness_repository.dart # Contractul abstract al repozitoriului
│   └── usecases/
│       └── get_fitness_data.dart # Cazul de utilizare (GetFitnessDataUseCase)
│
├── data/                        # Stratul DATA (Sursa de Date & Modele DTO)
│   ├── datasources/
│   │   └── fitness_remote_data_source.dart # Cererile HTTP REST API & Fallback offline
│   ├── models/
│   │   └── fitness_dto.dart     # Modelele DTO cu metode fromJson și toJson
│   └── repositories/
│       └── fitness_repository_impl.dart # Implementarea concretă a repozitoriului
│
├── presentation/ (lib/ & widgets/) # Stratul PRESENTATION (UI & Management de Stare)
│   ├── cubit/
│   │   ├── fitness_cubit.dart    # Cubit pentru stările de încărcare, căutare, filtrare, sortare
│   │   └── theme_cubit.dart      # Comutator pentru tema Light / Dark Mode
│   ├── screens/
│   │   ├── home_screen.dart      # Ecranul principal (Header, Challenge, Search, Filters, Programs)
│   │   └── gym_detail_screen.dart# Ecranul de detalii sală (Hero Image, Rating, Amenities, Reserve)
│   ├── widgets/                  # Componente UI reutilizabile
│   │   ├── today_challenge_card.dart
│   │   ├── featured_plan_card.dart
│   │   ├── workout_item_card.dart
│   │   ├── header_section.dart
│   │   └── section_header.dart
│   └── utils/
│       └── app_colors.dart       # Paleta centralizată de culori pentru ambele teme
└── main.dart                     # Punctul de intrare în aplicație
```

---

## 🌐 Structura Datelor JSON (REST API Payload)

Aplicația recepționează și deserializează două structuri principale JSON de la server:

### 1. Pagina Principală (`fitnessHomePage`)
```json
{
  "fitnessHomePage": {
    "header": { "date": "Friday, 20 May", "greeting": "Good Morning" },
    "todaysChallenge": {
      "title": "Today's Challenge",
      "activity": "Running",
      "completed": 15,
      "total": 20,
      "progress": 0.75
    },
    "featuredPlans": [
      {
        "id": "fp001",
        "title": "Massive Upper Body",
        "duration": "5 week",
        "frequency": "4x/week",
        "actionLabel": "Start Now",
        "imageUrl": "https://images.unsplash.com/photo-1583454110551-21f2fa2afe61..."
      }
    ],
    "workoutPrograms": {
      "filters": [
        { "id": "all", "name": "All Type", "selected": true },
        { "id": "yoga", "name": "Yoga", "selected": false }
      ],
      "items": [
        {
          "id": "wp001",
          "title": "Yoga",
          "calories": 210,
          "durationMinutes": 120,
          "isPro": false,
          "imageUrl": "https://images.unsplash.com/photo-1518611012118..."
        }
      ]
    }
  }
}
```

### 2. Detalii Sală (`fitnessGymDetailsPage`)
```json
{
  "fitnessGymDetailsPage": {
    "gym": {
      "id": "gym001",
      "name": "Mid City Gym Training",
      "location": "California, New York",
      "heroImageUrl": "https://images.unsplash.com/photo-1517836357463...",
      "rating": 4.5,
      "reviewCount": 1232,
      "description": "Lorem ipsum dolor sit amet...",
      "amenities": [
        { "id": "showers", "name": "Showers" },
        { "id": "lockers", "name": "Lockers" }
      ],
      "pricing": {
        "amount": 69.0,
        "currency": "USD",
        "period": "week",
        "formatted": "$69.00 /week"
      }
    }
  }
}
```

---

## 🔄 Fluxul Datelor (Data Flow)

1. **Utilizatorul deschide aplicația**: `HomeScreen` lansează `FitnessCubit.loadData()`.
2. **Starea de Loading**: `FitnessCubit` emite `FitnessLoading()`, afișând un indicator circular de progres.
3. **Cerere HTTP GET**: `FitnessRemoteDataSourceImpl` trimite cererea asincronă peste HTTPS către serverul REST API.
4. **Deserializare JSON**: Textul JSON primit este convertit de `FitnessDataModel.fromJson()` în obiecte Dart.
5. **Transmitere prin Domain**: Datele sunt pasate prin `FitnessRepositoryImpl` $\rightarrow$ `GetFitnessDataUseCase` $\rightarrow$ `FitnessService`.
6. **Emitere Stare Succes**: `FitnessCubit` aplică filtrele și sortarea, apoi emite `FitnessSuccess`.
7. **Renderizare UI**: `BlocBuilder` actualizează widget-urile pe ecran. Dacă rețeaua eșuează, se emite `FitnessError` cu opțiunea de **Reîncercare (Retry)**.

---

## 🛠️ Instalare și Rulare

1. **Clonare repozitoriu și comutare pe branch-ul `lab4`**:
   ```bash
   git clone https://github.com/vadim20-kt/Programarea-Aplicatiilor.git
   cd Programarea-Aplicatiilor
   git checkout lab4
   ```

2. **Preluare dependențe**:
   ```bash
   flutter pub get
   ```

3. **Verificare analiză cod**:
   ```bash
   flutter analyze
   ```

4. **Rulare aplicație**:
   ```bash
   flutter run
   ```

---

## 💻 Tehnologii Utilizate

* **Flutter / Dart SDK**: ^3.13.3
* **Management de Stare**: `flutter_bloc` (^8.1.3)
* **Rețea & REST API**: `http` (^1.2.0)
* **Design & Temă**: Material Design 3, Light & Dark Theme Support
