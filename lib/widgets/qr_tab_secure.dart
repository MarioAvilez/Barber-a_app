// qr_tab.dart
import 'package:flutter/material.dart';

class QRTab extends StatefulWidget {
  final bool isAuthorized;

  const QRTab({super.key, required this.isAuthorized});

  @override
  State<QRTab> createState() => _QRTabState();
}

class _QRTabState extends State<QRTab> {
  String? scannedCode;

  void _simulateScan() {
    if (!widget.isAuthorized) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Escanear Código'),
        content: TextField(
          autofocus: true,
          decoration:
              const InputDecoration(hintText: 'Ingrese el código manualmente'),
          onSubmitted: (value) {
            Navigator.pop(context);
            setState(() {
              scannedCode = value;
            });
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear QR'),
      ),
      floatingActionButton: widget.isAuthorized
          ? FloatingActionButton(
              onPressed: _simulateScan,
              child: const Icon(Icons.qr_code_scanner),
            )
          : null,
      body: Center(
        child: scannedCode == null
            ? const Text('No se ha escaneado ningún código')
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Código escaneado:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    scannedCode!,
                    style: const TextStyle(fontSize: 24, color: Colors.blue),
                  ),
                ],
              ),
      ),
    );
  }
}
