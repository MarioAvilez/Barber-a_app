import 'package:flutter/material.dart';

class ReviewsTab extends StatelessWidget {
  final bool isAuthorized;

  const ReviewsTab({super.key, required this.isAuthorized});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        isAuthorized ? 'Reseñas (modo autorizado)' : 'Reseñas (solo lectura)',
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
