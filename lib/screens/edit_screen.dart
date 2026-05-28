import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../services/firestore_service.dart';

class EditScreen extends StatelessWidget {
  final Exercise exercise;
  final service = FirestoreService();

  EditScreen({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController(text: exercise.name);
    final sets = TextEditingController(text: exercise.sets.toString());
    final reps = TextEditingController(text: exercise.reps.toString());

    return Scaffold(
      appBar: AppBar(title: const Text("Editar")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: name),
            TextField(controller: sets),
            TextField(controller: reps),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                service.updateExercise(
                  Exercise(
                    id: exercise.id,
                    name: name.text,
                    sets: int.parse(sets.text),
                    reps: int.parse(reps.text), category: '',
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text("Atualizar"),
            )
          ],
        ),
      ),
    );
  }
}