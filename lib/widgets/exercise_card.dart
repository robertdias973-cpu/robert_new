import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/exercise.dart';

class ExerciseCard extends StatefulWidget {
  final Exercise exercise;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<ExerciseCard> createState() =>
      _ExerciseCardState();
}

class _ExerciseCardState
    extends State<ExerciseCard> {
  int seriesFeitas = 0;

  late SharedPreferences prefs;

  String get hoje {
    final now = DateTime.now();

    return "${now.year}_${now.month}_${now.day}";
  }

  String get key =>
      "exercise_${widget.exercise.id}_$hoje";

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    await carregarProgresso();
  }

  Future<void> carregarProgresso() async {
    final valor = prefs.getInt(key) ?? 0;

    if (!mounted) return;

    setState(() {
      seriesFeitas = valor;
    });
  }

  Future<void> salvarProgresso() async {
    await prefs.setInt(
      key,
      seriesFeitas,
    );
  }

  Future<void> adicionarSerie() async {
    if (seriesFeitas <
        widget.exercise.series) {
      setState(() {
        seriesFeitas++;
      });

      await salvarProgresso();
    }
  }

  Future<void> resetarSeries() async {
    setState(() {
      seriesFeitas = 0;
    });

    await salvarProgresso();
  }

  @override
  Widget build(BuildContext context) {
    final concluido =
        seriesFeitas >=
        widget.exercise.series;

    return InkWell(
      onTap: adicionarSerie,
      onLongPress: resetarSeries,
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: ListTile(
          leading: Icon(
            Icons.fitness_center,
            color: concluido
                ? Colors.green
                : Colors.orange,
          ),

          title: Text(
            widget.exercise.nome,
          ),

          subtitle: Text(
            "$seriesFeitas/${widget.exercise.series} séries • "
            "${widget.exercise.repeticoes} reps • "
            "${widget.exercise.carga} kg",
          ),

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (concluido)
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),

              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: widget.onEdit,
              ),

              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: widget.onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}