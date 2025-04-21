import 'package:flutter/material.dart';

class StatusHeader extends StatelessWidget {
  final bool estaAbierto;
  final int personasEnEspera;
  final int capacidadMaxima;

  const StatusHeader({
    Key? key,
    required this.estaAbierto,
    required this.personasEnEspera,
    required this.capacidadMaxima,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool estaLleno = personasEnEspera >= capacidadMaxima;

    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              estaAbierto ? 'Barbería Abierta' : 'Barbería Cerrada',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              estaLleno
                  ? 'Estado: Lleno'
                  : 'En espera: $personasEnEspera / $capacidadMaxima',
              style: TextStyle(
                fontSize: 16,
                color: estaLleno ? Colors.red : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
