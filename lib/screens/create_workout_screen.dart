import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class CreateWorkoutScreen extends StatefulWidget {
  const CreateWorkoutScreen({super.key});

  @override
  State<CreateWorkoutScreen> createState() =>
      _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState
    extends State<CreateWorkoutScreen> {
  final nomeController = TextEditingController();

  final service = FirestoreService();

  bool carregando = false;

  Future<void> salvar() async {
    if (nomeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Digite um nome para a ficha',
          ),
        ),
      );
      return;
    }

    setState(() {
      carregando = true;
    });

    await service.criarTreino(
      nomeController.text.trim(),
    );

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  void dispose() {
    nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova Ficha"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Icon(
              Icons.fitness_center,
              size: 80,
            ),

            const SizedBox(height: 20),

            const Text(
              "Criar Nova Ficha",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: "Nome da ficha",
                hintText:
                    "Ex: Peito e Tríceps",
                prefixIcon:
                    Icon(Icons.edit_note),
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton.icon(
              onPressed:
                  carregando ? null : salvar,
              icon: carregando
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child:
                          CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.save),
              label: const Text(
                "Salvar Ficha",
              ),
            ),
          ],
        ),
      ),
    );
  }
}