import 'package:flutter/material.dart';
import 'package:mi_primera_app/home_screen.dart';
import 'package:mi_primera_app/main_tab_screen.dart';
import 'home_screen.dart'; // o usa main_tab_screen.dart si esa es la principal

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const MainTabScreen(isAuthorized: true),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage('assets/splash_barberia.png'),
              width: 120,
            ),
            SizedBox(height: 20),
            Text(
              'Bienvenido a Mi barbería',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
