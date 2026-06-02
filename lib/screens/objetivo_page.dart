import 'package:flutter/material.dart';

class ObjetivoPage extends StatelessWidget {
  const ObjetivoPage({super.key});

  void mostrarTreino(
    BuildContext context,
    String titulo,
    List<String> exercicios,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(titulo),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: exercicios.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(
                  Icons.fitness_center,
                ),
                title: Text(
                  exercicios[index],
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Fechar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Treinos Prontos'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.local_fire_department,
              ),
              title: const Text('Definição'),
              subtitle: const Text(
                'Treino focado em definição muscular',
              ),
              onTap: () {
                mostrarTreino(
                  context,
                  'Treino de Definição',
                  [
                    'Corrida - 30 min',
                    'Agachamento - 4x15',
                    'Flexão - 4x15',
                    'Abdominal - 4x20',
                  ],
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.fitness_center,
              ),
              title: const Text('Hipertrofia'),
              subtitle: const Text(
                'Treino focado em ganho de massa muscular',
              ),
              onTap: () {
                mostrarTreino(
                  context,
                  'Treino de Hipertrofia',
                  [
                    'Supino - 4x10',
                    'Rosca Direta - 4x12',
                    'Leg Press - 4x12',
                    'Remada - 4x10',
                  ],
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.bolt),
              title: const Text('Força'),
              subtitle: const Text(
                'Treino focado em aumento de força',
              ),
              onTap: () {
                mostrarTreino(
                  context,
                  'Treino de Força',
                  [
                    'Agachamento Livre - 5x5',
                    'Supino Reto - 5x5',
                    'Levantamento Terra - 5x5',
                    'Barra Fixa - 4x6',
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}