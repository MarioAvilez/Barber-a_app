import 'package:flutter/material.dart';

class PinProtectedAction extends StatelessWidget {
  final VoidCallback onValidated;
  final IconData icon;
  final String tooltip;

  const PinProtectedAction({
    Key? key,
    required this.onValidated,
    required this.icon,
    required this.tooltip,
  }) : super(key: key);

  void _verificarPin(BuildContext context) async {
    final pinCorrecto = true;
    if (pinCorrecto) {
      onValidated();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PIN incorrecto')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      onPressed: () => _verificarPin(context),
    );
  }
}
