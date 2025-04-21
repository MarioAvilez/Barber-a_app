import 'package:flutter/material.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estado del Local'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('¡La barbería está abierta!', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Personas en espera: 2'),
            Text('Capacidad máxima: 5'),
          ],
        ),
      ),
    );
  }
}
