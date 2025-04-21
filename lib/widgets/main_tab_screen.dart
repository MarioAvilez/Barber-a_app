import 'package:flutter/material.dart';
import 'package:mi_primera_app/widgets/services_tab_secure.dart';
import 'package:mi_primera_app/widgets/offers_tab_secure.dart';
import 'package:mi_primera_app/widgets/rewards_tab_secure.dart';
import 'package:mi_primera_app/widgets/appointments_tab_secure.dart';
import 'package:mi_primera_app/widgets/reviews_tab_secure.dart';
import 'package:mi_primera_app/widgets/qr_tab_secure.dart';
import 'package:mi_primera_app/widgets/stats_tab_secure.dart';
import 'package:mi_primera_app/widgets/status_header.dart';

class MainTabScreen extends StatefulWidget {
  final bool isAuthorized;

  const MainTabScreen({super.key, required this.isAuthorized});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool isOpen = true;
  int peopleWaiting = 3;
  int maxCapacity = 5;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Barbería'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Servicios'),
            Tab(text: 'Ofertas'),
            Tab(text: 'Premios'),
            Tab(text: 'Citas'),
            Tab(text: 'Reseñas'),
            Tab(text: 'QR'),
            Tab(text: 'Estadísticas'),
          ],
        ),
      ),
      body: Column(
        children: [
          StatusHeader(
            estaAbierto: isOpen,
            personasEnEspera: peopleWaiting,
            capacidadMaxima: maxCapacity,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ServicesTab(),
                OffersTabSecure(isAuthorized: widget.isAuthorized),
                RewardsTabSecure(isAuthorized: widget.isAuthorized),
                AppointmentsTabSecure(isAuthorized: widget.isAuthorized),
                ReviewsTabSecure(isAuthorized: widget.isAuthorized),
                QRTabSecure(isAuthorized: widget.isAuthorized),
                StatsTabSecure(isAuthorized: widget.isAuthorized),
              ],
            ),
          ),
        ],
      ),
    );
  ({required bool isAuthorized}) {}
}
