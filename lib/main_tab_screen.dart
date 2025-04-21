import 'package:flutter/material.dart';
import 'package:mi_primera_app/widgets/services_tab.dart';
import 'package:mi_primera_app/widgets/rewards_tab.dart';
import 'package:mi_primera_app/widgets/appointments_tab.dart';
import 'package:mi_primera_app/widgets/qr_tab.dart';
import 'package:mi_primera_app/widgets/stats_tab.dart';
import 'package:mi_primera_app/widgets/status_header.dart';

import 'offers_tab.dart';
import 'reviews_tab.dart';

class MainTabScreen extends StatefulWidget {
  final bool isAuthorized;

  const MainTabScreen({Key? key, required this.isAuthorized}) : super(key: key);

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
          const StatusHeader(
            estaAbierto: true,
            personasEnEspera: 3,
            capacidadMaxima: 5,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ServicesTab(
                  isAuthorized: widget.isAuthorized,
                  isOpen: true,
                  peopleWaiting: 3,
                ),
                OffersTab(isAuthorized: widget.isAuthorized),
                RewardsTab(isAuthorized: widget.isAuthorized),
                AppointmentsTab(isAuthorized: widget.isAuthorized),
                ReviewsTab(isAuthorized: widget.isAuthorized),
                QRTab(isAuthorized: widget.isAuthorized),
                StatsTab(isAuthorized: widget.isAuthorized),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
