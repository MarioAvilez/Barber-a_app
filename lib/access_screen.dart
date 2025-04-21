import 'package:flutter/material.dart';
import 'package:mi_primera_app/widgets/status%20header.dart';
import 'package:mi_primera_app/Status_screen.dart';

class AccessScreen extends StatefulWidget {
  const AccessScreen({super.key});

  @override
  State<AccessScreen> createState() => _AccessScreenState();
}

class _AccessScreenState extends State<AccessScreen> {
  final TextEditingController _pinController = TextEditingController();
  final List<String> dispositivosAutorizados = [
    'ID_DISPOSITIVO_1',
    'ID_DISPOSITIVO_2'
  ];
  final String pinCorrecto = '1234';

  @override
  void initState() {
    super.initState();
    _verificarDispositivo();
  }

  void _verificarDispositivo() async {
    // Aquí puedes agregar la lógica real para obtener el ID del dispositivo.
    // Este es un ejemplo simulado:
    String dispositivoActual = 'ID_DISPOSITIVO_1';

    if (!dispositivosAutorizados.contains(dispositivoActual)) {
      _mostrarDialogo('Este dispositivo no está autorizado.');
    }
  }

  void _mostrarDialogo(String mensaje) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Acceso Denegado'),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _verificarPin() {
    if (_pinController.text == pinCorrecto) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => StatusHeader(
            estaAbierto: true,
            personasEnEspera: 0,
            capacidadMaxima: 5,
          ),
        ),
      );
    } else {
      _mostrarDialogo('PIN incorrecto.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acceso de administrador')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Ingrese el PIN para continuar',
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            TextField(
              controller: _pinController,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'PIN',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _verificarPin,
              child: const Text('Acceder'),
            ),
          ],
        ),
      ),
    );
  }
}
