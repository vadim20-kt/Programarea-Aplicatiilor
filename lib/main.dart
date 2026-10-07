import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/fitness_cubit.dart';
import 'screens/home_screen.dart';
import 'utils/app_colors.dart';

// Punctul de intrare în aplicația Flutter
void main() {
  runApp(const MyApp());
}

// Widget-ul rădăcină al aplicației
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Configurare BlocProvider la nivel înalt pentru gestionarea stării
    return BlocProvider(
      create: (context) => FitnessCubit()..loadData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fitness App',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          primarySwatch: Colors.green,
          fontFamily: 'Arial',
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
