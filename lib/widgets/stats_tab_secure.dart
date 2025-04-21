// stats_tab.dart
import 'package:flutter/material.dart';

class StatsTab extends StatefulWidget {
  final bool isAuthorized;

  const StatsTab({super.key, required this.isAuthorized});

  @override
  State<StatsTab> createState() => _StatsTabState();
}

class _StatsTabState extends State<StatsTab> {
  int escolar = 0;
  int normal = 0;
  int terceraEdad = 0;

  void _addCut(String type) {
    setState(() {
      if (type == 'Escolar') escolar++;
      if (type == 'Normal') normal++;
      if (type == 'Tercera Edad') terceraEdad++;
    });
  }

  void _resetStats() {
    setState(() {
      escolar = 0;
      normal = 0;
      terceraEdad = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadísticas'),
        actions: [
          if (widget.isAuthorized)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _resetStats,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildStatCard('Escolar', escolar, Colors.green),
            _buildStatCard('Normal', normal, Colors.blue),
            _buildStatCard('Tercera Edad', terceraEdad, Colors.orange),
            const SizedBox(height: 24),
            if (widget.isAuthorized)
              Wrap(
                spacing: 10,
                children: [
                  ElevatedButton(
                    onPressed: () => _addCut('Escolar'),
                    child: const Text('Agregar Escolar'),
                  ),
                  ElevatedButton(
                    onPressed: () => _addCut('Normal'),
                    child: const Text('Agregar Normal'),
                  ),
                  ElevatedButton(
                    onPressed: () => _addCut('Tercera Edad'),
                    child: const Text('Agregar Tercera Edad'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, int count, Color color) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Text(
            count.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(label),
      ),
    );
  }
}
