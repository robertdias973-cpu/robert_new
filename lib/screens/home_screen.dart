import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/firestore_service.dart';
import 'create_workout_screen.dart';
import 'workout_detail_screen.dart';
import 'objetivo_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final FirestoreService service = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("fitTreino"),
        actions: [
          IconButton(
            icon: const Icon(Icons.fitness_center),
            tooltip: "Treinos Prontos",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ObjetivoPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Sair",
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text("Nova Ficha"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateWorkoutScreen(),
            ),
          );
        },
      ),

      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.fitness_center,
                      size: 35,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Bem-vindo!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                Text(
                  "Organize seus treinos e acompanhe sua evolução.",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Minhas Fichas",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: StreamBuilder(
              stream: service.listarTreinos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: Text(
                      "Erro ao carregar fichas",
                    ),
                  );
                }

                final docs =
                    snapshot.data!.docs;

                if (docs.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fitness_center,
                          size: 80,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Nenhuma ficha criada",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Clique no botão + para criar uma ficha",
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding:
                      const EdgeInsets.all(12),
                  itemCount: docs.length,
                  itemBuilder:
                      (context, index) {
                    final treino =
                        docs[index];

                    return Card(
                      margin:
                          const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 6,
                      ),
                      child: ListTile(
                        leading:
                            const CircleAvatar(
                          child: Icon(
                            Icons
                                .fitness_center,
                          ),
                        ),

                        title: Text(
                          treino['nome'],
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight
                                    .bold,
                            fontSize: 18,
                          ),
                        ),

                        subtitle:
                            const Text(
                          "Toque para abrir a ficha",
                        ),

                        trailing:
                            IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color:
                                Colors.red,
                          ),
                          onPressed:
                              () async {
                            final confirmar =
                                await showDialog<
                                    bool>(
                              context:
                                  context,
                              builder:
                                  (_) =>
                                      AlertDialog(
                                title:
                                    const Text(
                                  "Excluir ficha",
                                ),
                                content:
                                    const Text(
                                  "Deseja realmente excluir esta ficha?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed:
                                        () {
                                      Navigator.pop(
                                        context,
                                        false,
                                      );
                                    },
                                    child:
                                        const Text(
                                      "Cancelar",
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed:
                                        () {
                                      Navigator.pop(
                                        context,
                                        true,
                                      );
                                    },
                                    child:
                                        const Text(
                                      "Excluir",
                                    ),
                                  ),
                                ],
                              ),
                            );

                            if (confirmar ==
                                true) {
                              await service
                                  .excluirTreino(
                                treino.id,
                              );
                            }
                          },
                        ),

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  WorkoutDetailScreen(
                                treinoId:
                                    treino.id,
                                nomeTreino:
                                    treino['nome'],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}