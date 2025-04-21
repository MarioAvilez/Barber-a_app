import 'package:flutter/material.dart';

class ReviewsTab extends StatefulWidget {
  final bool isAuthorized;

  const ReviewsTab({super.key, required this.isAuthorized});

  @override
  State<ReviewsTab> createState() => _ReviewsTabState();
}

class _ReviewsTabState extends State<ReviewsTab> {
  List<Map<String, String>> reviews = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  void _showReviewDialog({int? index}) {
    if (index != null) {
      _nameController.text = reviews[index]['name'] ?? '';
      _commentController.text = reviews[index]['comment'] ?? '';
    } else {
      _nameController.clear();
      _commentController.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(index == null ? 'Agregar Reseña' : 'Editar Reseña'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration:
                  const InputDecoration(labelText: 'Nombre del cliente'),
            ),
            TextField(
              controller: _commentController,
              decoration: const InputDecoration(labelText: 'Comentario'),
              maxLines: 3,
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
              final comment = _commentController.text.trim();
              if (name.isNotEmpty && comment.isNotEmpty) {
                setState(() {
                  if (index == null) {
                    reviews.add({'name': name, 'comment': comment});
                  } else {
                    reviews[index] = {'name': name, 'comment': comment};
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

  void _deleteReview(int index) {
    setState(() {
      reviews.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reseñas'),
      ),
      floatingActionButton: widget.isAuthorized
          ? FloatingActionButton(
              onPressed: () => _showReviewDialog(),
              child: const Icon(Icons.add_comment),
            )
          : null,
      body: reviews.isEmpty
          ? const Center(child: Text('No hay reseñas disponibles'))
          : ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(review['name'] ?? ''),
                    subtitle: Text(review['comment'] ?? ''),
                    trailing: widget.isAuthorized
                        ? PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                _showReviewDialog(index: index);
                              } else if (value == 'delete') {
                                _deleteReview(index);
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
