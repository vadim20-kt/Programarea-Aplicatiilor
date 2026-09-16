# Fitness App - Modern Gym Discovery & Workout Tracker

Welcome to the **Fitness App** project! This is a professional Flutter-based mobile application designed to offer a sleek, high-performance experience for tracking workouts and exploring local fitness centers.

If you are a student, a developer, or just someone interested in seeing a modern UI implementation in Flutter, this guide will help you get the app running on your device in minutes.

---

## 🌟 What's Inside?

Once you install the app, you will be able to explore:
*   **Dynamic Dashboard**: A beautiful greeting screen with progress indicators for daily challenges.
*   **Curated Workout Plans**: High-quality cards showcasing massive upper/lower body programs.
*   **Interactive Workout Grid**: Filterable exercises (Yoga, Pilates, Cardio) with real-time calorie and time metrics.
*   **Premium "Pro" Features**: Visual markers for exclusive content.
*   **Detailed Gym Profiles**: A deep dive into gym amenities (WiFi, Pool, Showers, etc.) with a built-in reservation UI.

---

## 🛠 Installation Guide for New Users

Follow these steps to set up the environment and launch the app.

### 1. Preparation
Ensure you have the following installed on your system:
*   **Flutter SDK** (Version 3.13.0 or higher): [Install Guide](https://docs.flutter.dev/get-started/install)
*   **Android Studio** or **VS Code** with Flutter extensions.
*   **Git**: [Download Git](https://git-scm.com/downloads)

### 2. Getting the Source Code
Open your terminal or command prompt and run the following:

```bash
# Clone the repository to your local machine
git clone https://github.com/vadim20-kt/Programarea-Aplicatiilor.git

# Enter the project directory
cd Programarea-Aplicatiilor

# Switch to the correct development branch (IMPORTANT)
git checkout lab2
```

### 3. Setting Up the Project
Once inside the project folder on the `lab2` branch, execute:

1.  **Download Libraries**:
    ```bash
    flutter pub get
    ```
2.  **Initialize Branding**: (This creates the app icons for your phone)
    ```bash
    dart run flutter_launcher_icons
    ```

### 4. Running the App
1.  Open an **Emulator** (via Android Studio) or connect your **Android/iOS device** via USB.
2.  Make sure your device is recognized by running `flutter devices`.
3.  Launch the app:
    ```bash
    flutter run
    ```

---

## 💡 Troubleshooting
*   **Command not found**: Ensure Flutter is added to your system's PATH variables.
*   **Build failed**: Run `flutter clean` and then `flutter pub get` to reset the build state.
*   **Icons not appearing**: Make sure you ran the `flutter_launcher_icons` command mentioned in Step 3.

---

## 📁 Repository & Development
This project was developed by **Vadim** as part of a University Laboratory for **Programarea Aplicațiilor**.

*   **GitHub**: [vadim20-kt](https://github.com/vadim20-kt)
*   **Branch for this version**: `lab2`

Feel free to explore the code in `lib/` to see how the screens and custom widgets are implemented!
