import 'package:flutter/material.dart';
import 'status_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool pinCorrecto = true; // Lógica de PIN temporal

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ver estado del local',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (pinCorrecto) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StatusScreen(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('PIN incorrecto')),
                  );
                }
              },
              child: const Text('Ver estado'),
            ),
          ],
        ),
      ),
    );
  }
}
