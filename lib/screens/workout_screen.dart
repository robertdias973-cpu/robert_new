import 'package:flutter/material.dart';
import '../models/exercise.dart';

class WorkoutScreen extends StatefulWidget {
  final List<Exercise> exercises;

  const WorkoutScreen({
    super.key,
    required this.exercises,
  });

  @override
  State<WorkoutScreen> createState() =>
      _WorkoutScreenState();
}

class _WorkoutScreenState
    extends State<WorkoutScreen> {
  final Map<String, bool> concluido = {};

  void resetarTreino() {
    setState(() {
      concluido.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.exercises.length;

    final concluidos = widget.exercises.where((e) {
      return concluido[e.id ?? ''] == true;
    }).length;

    final progressoGeral =
        total == 0 ? 0.0 : concluidos / total;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Treino do Dia'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Resetar treino',
            onPressed: resetarTreino,
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Progresso ${(progressoGeral * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                LinearProgressIndicator(
                  value: progressoGeral,
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount:
                  widget.exercises.length,
              itemBuilder:
                  (context, index) {
                final ex =
                    widget.exercises[index];

                final feito =
                    concluido[ex.id ?? ''] ??
                        false;

                return Card(
                  margin:
                      const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: Icon(
                      feito
                          ? Icons.check_circle
                          : Icons.fitness_center,
                      color: feito
                          ? Colors.green
                          : null,
                    ),

                    title: Text(ex.nome),

                    subtitle: Text(
                      '${ex.series} séries • ${ex.repeticoes} reps • ${ex.carga} kg',
                    ),

                    trailing: Checkbox(
                      value: feito,
                      onChanged: (value) {
                        setState(() {
                          concluido[
                                  ex.id ?? ''] =
                              value ?? false;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            const SnackBar(
              content: Text(
                'Treino finalizado! 💪',
              ),
            ),
          );

          Navigator.pop(context);
        },
        icon: const Icon(Icons.check),
        label:
            const Text('Finalizar'),
      ),
    );
  }
}