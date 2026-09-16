import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness App',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primarySwatch: Colors.green,
        fontFamily: 'Arial',
      ),
      home: const HomeScreen(),
    );
  }
}