// offers_tab.dart
import 'package:flutter/material.dart';

class OffersTab extends StatefulWidget {
  final bool isAuthorized;

  const OffersTab({super.key, required this.isAuthorized});

  @override
  State<OffersTab> createState() => _OffersTabState();
}

class _OffersTabState extends State<OffersTab> {
  List<Map<String, String>> offers = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _showOfferDialog({int? index}) {
    if (index != null) {
      _titleController.text = offers[index]['title'] ?? '';
      _priceController.text = offers[index]['price'] ?? '';
    } else {
      _titleController.clear();
      _priceController.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(index == null ? 'Agregar Oferta' : 'Editar Oferta'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
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
              final title = _titleController.text.trim();
              final price = _priceController.text.trim();
              if (title.isNotEmpty && price.isNotEmpty) {
                setState(() {
                  if (index == null) {
                    offers.add({'title': title, 'price': price});
                  } else {
                    offers[index] = {'title': title, 'price': price};
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

  void _deleteOffer(int index) {
    setState(() {
      offers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ofertas'),
      ),
      floatingActionButton: widget.isAuthorized
          ? FloatingActionButton(
              onPressed: () => _showOfferDialog(),
              child: const Icon(Icons.add),
            )
          : null,
      body: offers.isEmpty
          ? const Center(child: Text('No hay ofertas disponibles'))
          : ListView.builder(
              itemCount: offers.length,
              itemBuilder: (context, index) {
                final offer = offers[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(offer['title'] ?? ''),
                    subtitle: Text('Lps ${offer['price']}'),
                    trailing: widget.isAuthorized
                        ? PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                _showOfferDialog(index: index);
                              } else if (value == 'delete') {
                                _deleteOffer(index);
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
