import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import 'add_exercise_screen.dart';

class WorkoutDetailScreen extends StatefulWidget {
  final String treinoId;
  final String nomeTreino;

  const WorkoutDetailScreen({
    super.key,
    required this.treinoId,
    required this.nomeTreino,
  });

  @override
  State<WorkoutDetailScreen> createState() =>
      _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState
    extends State<WorkoutDetailScreen> {
  final FirestoreService service =
      FirestoreService();

  final Set<String> concluidos = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nomeTreino),
      ),

      body: StreamBuilder(
        stream: service.listarExercicios(
          widget.treinoId,
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          final exercicios =
              snapshot.data!.docs;

          if (exercicios.isEmpty) {
            return const Center(
              child: Text(
                "Nenhum exercício cadastrado",
              ),
            );
          }

          return ListView.builder(
            itemCount: exercicios.length,
            itemBuilder: (context, index) {
              final ex =
                  exercicios[index];

              final concluido =
                  concluidos.contains(
                ex.id,
              );

              return Card(
                color: concluido
                    ? Colors.green
                        .withOpacity(0.2)
                    : null,
                margin:
                    const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: ListTile(
                  leading: Icon(
                    concluido
                        ? Icons.check_circle
                        : Icons.fitness_center,
                    color: concluido
                        ? Colors.green
                        : null,
                  ),

                  title: Text(
                    ex['nome'],
                    style: TextStyle(
                      decoration:
                          concluido
                              ? TextDecoration
                                  .lineThrough
                              : null,
                    ),
                  ),

                  subtitle: Text(
                    "${ex['series']} séries • "
                    "${ex['repeticoes']} reps • "
                    "${ex['carga']} kg",
                  ),

                  trailing: Checkbox(
                    value: concluido,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          concluidos.add(
                            ex.id,
                          );

                          ScaffoldMessenger.of(
                                  context)
                              .showSnackBar(
                            SnackBar(
                              content: Text(
                                "${ex['nome']} concluído! 💪",
                              ),
                            ),
                          );
                        } else {
                          concluidos.remove(
                            ex.id,
                          );
                        }
                      });
                    },
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  AddExerciseScreen(
                treinoId:
                    widget.treinoId,
              ),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text(
          "Exercício",
        ),
      ),
    );
  }
}