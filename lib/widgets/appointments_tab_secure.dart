// appointments_tab.dart
import 'package:flutter/material.dart';

class AppointmentsTab extends StatefulWidget {
  final bool isAuthorized;

  const AppointmentsTab({super.key, required this.isAuthorized});

  @override
  State<AppointmentsTab> createState() => _AppointmentsTabState();
}

class _AppointmentsTabState extends State<AppointmentsTab> {
  List<Map<String, String>> appointments = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _serviceController = TextEditingController();

  void _showAppointmentDialog({int? index}) {
    if (index != null) {
      _nameController.text = appointments[index]['name'] ?? '';
      _serviceController.text = appointments[index]['service'] ?? '';
    } else {
      _nameController.clear();
      _serviceController.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(index == null ? 'Registrar Cita' : 'Editar Cita'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration:
                  const InputDecoration(labelText: 'Nombre del cliente'),
            ),
            TextField(
              controller: _serviceController,
              decoration: const InputDecoration(labelText: 'Servicio'),
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
              final name = _nameController.text.trim();
              final service = _serviceController.text.trim();
              if (name.isNotEmpty && service.isNotEmpty) {
                setState(() {
                  if (index == null) {
                    appointments.add({'name': name, 'service': service});
                  } else {
                    appointments[index] = {'name': name, 'service': service};
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

  void _deleteAppointment(int index) {
    setState(() {
      appointments.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Citas'),
      ),
      floatingActionButton: widget.isAuthorized
          ? FloatingActionButton(
              onPressed: () => _showAppointmentDialog(),
              child: const Icon(Icons.add),
            )
          : null,
      body: appointments.isEmpty
          ? const Center(child: Text('No hay citas registradas'))
          : ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(appointment['name'] ?? ''),
                    subtitle: Text(appointment['service'] ?? ''),
                    trailing: widget.isAuthorized
                        ? PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                _showAppointmentDialog(index: index);
                              } else if (value == 'delete') {
                                _deleteAppointment(index);
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
