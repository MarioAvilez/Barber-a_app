import 'package:flutter/material.dart';

// Importaciones de tus pantallas
import 'package:mi_primera_app/widgets/splash_screen.dart';
import 'package:mi_primera_app/widgets/home_screen.dart';
import 'package:mi_primera_app/widgets/services_tab.dart';
import 'package:mi_primera_app/widgets/offers_tab.dart';
import 'package:mi_primera_app/widgets/rewards_tab.dart';
import 'package:mi_primera_app/widgets/appointments_tab.dart';
import 'package:mi_primera_app/widgets/reviews_tab.dart';
import 'package:mi_primera_app/widgets/status_header.dart';
import 'package:mi_primera_app/widgets/main_tab_screen.dart'; // ESTA ES LA IMPORTANTE

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi barbería',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Esta es la pantalla que se abre primero
      home: const SplashScreen(), // Luego esta redirige a MainTabScreen
    );
  }
}
