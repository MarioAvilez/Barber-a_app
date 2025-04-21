// services_tab.dart
import 'package:flutter/material.dart';

class ServicesTab extends StatefulWidget {
  final bool isAuthorized;

  const ServicesTab({super.key, required this.isAuthorized});

  @override
  State<ServicesTab> createState() => _ServicesTabState();
}

class _ServicesTabState extends State<ServicesTab> {
  List<Map<String, String>> services = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _showServiceDialog({int? index}) {
    if (index != null) {
      _nameController.text = services[index]['name'] ?? '';
      _priceController.text = services[index]['price'] ?? '';
    } else {
      _nameController.clear();
      _priceController.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(index == null ? 'Agregar Servicio' : 'Editar Servicio'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration:
                  const InputDecoration(labelText: 'Nombre del servicio'),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.number,
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
              final price = _priceController.text.trim();
              if (name.isNotEmpty && price.isNotEmpty) {
                setState(() {
                  if (index == null) {
                    services.add({'name': name, 'price': price});
                  } else {
                    services[index] = {'name': name, 'price': price};
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

  void _deleteService(int index) {
    setState(() {
      services.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicios'),
      ),
      floatingActionButton: widget.isAuthorized
          ? FloatingActionButton(
              onPressed: () => _showServiceDialog(),
              child: const Icon(Icons.add),
            )
          : null,
      body: services.isEmpty
          ? const Center(child: Text('No hay servicios disponibles'))
          : ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(service['name'] ?? ''),
                    subtitle: Text('Lps ${service['price']}'),
                    trailing: widget.isAuthorized
                        ? PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                _showServiceDialog(index: index);
                              } else if (value == 'delete') {
                                _deleteService(index);
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
