import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home/home_screen.dart';
import 'core/theme/app_theme.dart';

/// Punto de entrada principal de la aplicación
/// Configura el tema y la navegación inicial
void main() {
  runApp(const ProgrammingTutorApp());
}

class ProgrammingTutorApp extends StatelessWidget {
  const ProgrammingTutorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Programming Tutor',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // Pantalla inicial: Login
      home: const LoginScreen(),
      // Rutas nombradas para navegación
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
