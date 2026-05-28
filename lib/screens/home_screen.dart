import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/exercise.dart';
import '../services/firestore_service.dart';

import 'add_screen.dart';
import 'edit_screen.dart';

class HomeScreen extends StatelessWidget {

  HomeScreen({super.key});

  final service = FirestoreService();

  Future<void> logout(BuildContext context) async {

    await FirebaseAuth.instance.signOut();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Meus Treinos'),

        actions: [

          IconButton(
            icon: const Icon(Icons.logout),

            onPressed: () => logout(context),
          )

        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,

        child: const Icon(Icons.add),

        onPressed: () {

          Navigator.push(
            context,

            MaterialPageRoute(
              builder: (_) => AddScreen(),
            ),
          );

        },
      ),

      body: StreamBuilder<List<Exercise>>(

        stream: service.getExercises(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {

            return const Center(
              child: CircularProgressIndicator(),
            );

          }

          final exercises = snapshot.data!;

          if (exercises.isEmpty) {

            return const Center(
              child: Text('Nenhum treino cadastrado'),
            );

          }

          return ListView.builder(

            itemCount: exercises.length,

            itemBuilder: (context, index) {

              final ex = exercises[index];

              return Card(

                margin: const EdgeInsets.all(12),

                child: ListTile(

                  leading: const Icon(
                    Icons.fitness_center,
                    color: Colors.orange,
                  ),

                  title: Text(ex.name),

                  subtitle: Text(
                    '${ex.category} • ${ex.sets}x${ex.reps}',
                  ),

                  trailing: Row(

                    mainAxisSize: MainAxisSize.min,

                    children: [

                      IconButton(

                        icon: const Icon(Icons.edit),

                        onPressed: () {

                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder: (_) => EditScreen(
                                exercise: ex,
                              ),
                            ),
                          );

                        },
                      ),

                      IconButton(

                        icon: const Icon(Icons.delete),

                        onPressed: () {

                          service.deleteExercise(ex.id!);

                        },
                      ),

                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}