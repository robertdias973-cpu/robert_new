import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../services/firestore_service.dart';

class AddScreen extends StatelessWidget {
  final name = TextEditingController();
  final category = TextEditingController();
  final sets = TextEditingController();
  final reps = TextEditingController();

  final service = FirestoreService();

  AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Adicionar")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: name, decoration: const InputDecoration(labelText: "Nome")),
            TextField(controller: sets, decoration: const InputDecoration(labelText: "Séries")),
            TextField(controller: reps, decoration: const InputDecoration(labelText: "Reps")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                service.addExercise(
                  Exercise(
                    name: name.text,
                    sets: int.parse(sets.text),
                    reps: int.parse(reps.text), category: '',
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text("Salvar"),
            )
          ],
        ),
      ),
    );
  }
}