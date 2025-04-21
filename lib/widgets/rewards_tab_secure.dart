// rewards_tab.dart
import 'package:flutter/material.dart';

class RewardsTab extends StatefulWidget {
  final bool isAuthorized;

  const RewardsTab({super.key, required this.isAuthorized});

  @override
  State<RewardsTab> createState() => _RewardsTabState();
}

class _RewardsTabState extends State<RewardsTab> {
  List<Map<String, String>> rewards = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _showRewardDialog({int? index}) {
    if (index != null) {
      _titleController.text = rewards[index]['title'] ?? '';
      _descriptionController.text = rewards[index]['description'] ?? '';
    } else {
      _titleController.clear();
      _descriptionController.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(index == null ? 'Agregar Premio' : 'Editar Premio'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final title = _titleController.text.trim();
              final description = _descriptionController.text.trim();
              if (title.isNotEmpty && description.isNotEmpty) {
                setState(() {
                  if (index == null) {
                    rewards.add({'title': title, 'description': description});
                  } else {
                    rewards[index] = {
                      'title': title,
                      'description': description
                    };
                  }
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _deleteReward(int index) {
    setState(() {
      rewards.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premios'),
      ),
      floatingActionButton: widget.isAuthorized
          ? FloatingActionButton(
              onPressed: () => _showRewardDialog(),
              child: const Icon(Icons.add),
            )
          : null,
      body: rewards.isEmpty
          ? const Center(child: Text('No hay premios disponibles'))
          : ListView.builder(
              itemCount: rewards.length,
              itemBuilder: (context, index) {
                final reward = rewards[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(reward['title'] ?? ''),
                    subtitle: Text(reward['description'] ?? ''),
                    trailing: widget.isAuthorized
                        ? PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                _showRewardDialog(index: index);
                              } else if (value == 'delete') {
                                _deleteReward(index);
                              }
                            },
                            itemBuilder: (_) => [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Text('Editar'),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text('Eliminar'),
                              ),
                            ],
                          )
                        : null,
                  ),
                );
              },
            ),
    );
  }
}
