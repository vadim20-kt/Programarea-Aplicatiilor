import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/fitness_cubit.dart';
import 'cubit/theme_cubit.dart';
import 'screens/home_screen.dart';
import 'utils/app_colors.dart';

// Punctul de intrare în aplicația Flutter
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Configurare Edge-to-Edge pentru o bară de stare transparentă
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
    ),
  );

  runApp(const MyApp());
}

// Widget-ul rădăcină al aplicației
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FitnessCubit()..loadData()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Vector Gym',
            themeMode: themeMode,

            // Tema deschisă (Light Mode) - Culori curate și aprinse
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryGreen,
                brightness: Brightness.light,
                primary: AppColors.primaryGreenDark,
                surface: Colors.white,
              ),
              scaffoldBackgroundColor: const Color(0xFFF8FAFC),
              cardColor: Colors.white,
              fontFamily: 'Arial',
            ),

            // Tema întunecată (Dark Mode) - Culori aprinse pe fundal Dark Premium
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryGreen,
                brightness: Brightness.dark,
                primary: AppColors.primaryGreen,
                surface: const Color(0xFF1E2638),
              ),
              scaffoldBackgroundColor: const Color(0xFF12141C), // Fundal negru-azuriu profund
              cardColor: const Color(0xFF1E2638),
              fontFamily: 'Arial',
            ),

            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
