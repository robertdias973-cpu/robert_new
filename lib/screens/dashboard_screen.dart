import 'package:flutter/material.dart';
import '../services/dashboard_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final service = DashboardService();

  Map<String, dynamic>? data;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final result = await service.getStats();

    setState(() {
      data = result;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final total = data!['totalWorkouts'];
    final days = data!['daysCount'] as Map<String, int>;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Fitness"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 TOTAL
            Card(
              child: ListTile(
                leading: const Icon(Icons.fitness_center),
                title: const Text("Total de Treinos"),
                trailing: Text(
                  "$total",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Treinos por dia da semana",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // 📊 BARRAS SIMPLES
            ...days.entries.map((e) {
              final value = e.value.toDouble();
              final max = days.values.fold<int>(
                0,
                (p, c) => c > p ? c : p,
              );

              final progress = max == 0 ? 0.0 : value / max;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.key),

                    const SizedBox(height: 4),

                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}