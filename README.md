# Fitness App - Modern Gym Discovery & Workout Tracker

Proiect Flutter dezvoltat pentru disciplina **Programarea Aplicațiilor** (Laboratorul 3), axat pe **State Management** (BLoC/Cubit), **programare asincronă** și arhitectură modulară cu componente UI reutilizabile.

---

## 🌟 Caracteristici și Funcționalități (Laborator 3)

Aplicația include toate cerințele de State Management, încărcare asincronă și interacțiune cu datele:

* ⚡ **State Management cu BLoC / Cubit**: Gestionare reactivă a stării aplicației (`FitnessLoading`, `FitnessSuccess`, `FitnessEmpty`, `FitnessError`) prin pachetul `flutter_bloc`.
* 📂 **Încărcare asincronă din JSON**: Datele sunt stocate în `assets/fitness_data.json` și citite asincron prin `rootBundle.loadString()`.
* 🔍 **Căutare în timp real**: Filtrare dinamică a antrenamentelor după titlu prin câmpul de căutare.
* 🏷️ **Filtrare pe categorii**: Chips-uri orizontale interactive (*All Type*, *Pilates*, *Cardio*, *Boxing*, *Yoga*).
* 🔀 **Sortare avansată**: Selector Dropdown cu 6 criterii (*Titlu A-Z*, *Titlu Z-A*, *Calorii crescător/descrescător*, *Durată scurtă/lungă*).
* ❤️ **Sistem de Favorite**: Adăugare și eliminare interactivă din lista de favorite (simbol inimioară) cu mesaj de confirmare prin `SnackBar`.
* 🏢 **Pagina de Detalii & Rezervare**: Navigare prin `Navigator.push` la ecranul de detalii al sălii ([GymDetailScreen]), afișând imagini, descriere, facilități și buton funcțional de rezervare.
* 🧱 **Arhitectură Modulară**: Organizare pe directoare speciale (`cubit`, `models`, `services`, `screens`, `widgets`, `utils`).
* 🧪 **Testare Automată**: Teste widget implementate în `test/widget_test.dart` pentru verificarea încărcării ecranului principal.

---

## 🛠 Ghid de Instalare și Rulare

### 1. Cerințe preliminare
* **Flutter SDK** (versiunea 3.13.0 sau mai nouă)
* **Android Studio** sau **VS Code** cu extensiile Flutter și Dart instalate
* **Git**

### 2. Clonarea repozitoriului
```bash
# Clonează repozitoriul
git clone https://github.com/vadim20-kt/Programarea-Aplicatiilor.git

# Intră în directorul proiectului
cd Programarea-Aplicatiilor

# Schimbă pe branch-ul lab3
git checkout lab3
```

### 3. Instalarea dependențelor
```bash
# Descarcă pachetele
flutter pub get

# Opțional: generează iconițele aplicației
dart run flutter_launcher_icons
```

### 4. Rularea aplicației și a testelor
```bash
# Rularea testelor automate
flutter test

# Rularea aplicației pe dispozitiv / emulator
flutter run
```

---

## 📁 Structura Proiectului

```text
lib/
├── cubit/          # FitnessCubit și stările aplicației (FitnessState)
├── models/         # Modelele de date (FitnessData, WorkoutItem, etc.)
├── services/       # Serviciul de citire asincronă din fitness_data.json
├── providers/      # Provider alternativ (ChangeNotifier)
├── screens/        # Ecranele principale (HomeScreen, GymDetailScreen)
├── widgets/        # Componente UI reutilizabile (WorkoutItemCard, FeaturedPlanCard, etc.)
└── utils/          # Paleta de culori AppColors
assets/
└── fitness_data.json # Fișierul de date JSON
```

---

## 👤 Dezvoltator
Proiect dezvoltat de **Vadim** pentru disciplina **Programarea Aplicațiilor**.
* **GitHub**: [vadim20-kt](https://github.com/vadim20-kt)
* **Branch curent**: `lab3`
