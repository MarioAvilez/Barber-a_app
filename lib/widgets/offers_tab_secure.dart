import 'package:flutter/material.dart';

class OffersTab extends StatefulWidget {
  final bool isAuthorized;

  const OffersTab({super.key, required this.isAuthorized});

  @override
  State<OffersTab> createState() => _OffersTabState();
}

class _OffersTabState extends State<OffersTab> {
  List<Map<String, String>> offers = [
    {'title': 'Descuento en Mohicano', 'price': 'Lps 35'},
    {'title': '2x1 en Corte con Barba', 'price': 'Lps 70'},
  ];

  void _addOffer() {
    setState(() {
      offers.add({'title': 'Nueva oferta', 'price': 'Lps 30'});
    });
  }

  void _editOffer() {
    if (offers.isNotEmpty) {
      setState(() {
        offers[0] = {'title': 'Oferta editada', 'price': 'Lps 40'};
      });
    }
  }

  void _deleteOffer() {
    if (offers.isNotEmpty) {
      setState(() {
        offers.removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Autorizado: ${widget.isAuthorized}'),
      ),
    );
  }
}
