import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class AddExerciseScreen extends StatefulWidget {
  final String treinoId;

  const AddExerciseScreen({
    super.key,
    required this.treinoId,
  });

  @override
  State<AddExerciseScreen> createState() =>
      _AddExerciseScreenState();
}

class _AddExerciseScreenState
    extends State<AddExerciseScreen> {
  final nomeController = TextEditingController();
  final seriesController = TextEditingController();
  final repeticoesController =
      TextEditingController();
  final cargaController = TextEditingController();

  final service = FirestoreService();

  Future<void> salvar() async {
    await service.adicionarExercicio(
      treinoId: widget.treinoId,
      nome: nomeController.text,
      series:
          int.tryParse(seriesController.text) ?? 0,
      repeticoes:
          int.tryParse(repeticoesController.text) ??
              0,
      carga:
          double.tryParse(cargaController.text) ??
              0,
    );

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Exercício'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: seriesController,
              keyboardType:
                  TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Séries',
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: repeticoesController,
              keyboardType:
                  TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Repetições',
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: cargaController,
              keyboardType:
                  TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Carga (kg)',
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: salvar,
              child: const Text(
                'Salvar Exercício',
              ),
            ),
          ],
        ),
      ),
    );
  }
}