import '../models/exercise.dart';

class DefaultWorkouts {
  static final List<Exercise> definicao = [
    Exercise(
      nome: 'Corrida',
      series: 1,
      repeticoes: 30,
      carga: 0,
    ),
    Exercise(
      nome: 'Agachamento',
      series: 4,
      repeticoes: 15,
      carga: 0,
    ),
    Exercise(
      nome: 'Flexão',
      series: 4,
      repeticoes: 15,
      carga: 0,
    ),
  ];

  static final List<Exercise> hipertrofia = [
    Exercise(
      nome: 'Supino',
      series: 4,
      repeticoes: 10,
      carga: 40,
    ),
    Exercise(
      nome: 'Rosca Direta',
      series: 4,
      repeticoes: 12,
      carga: 20,
    ),
  ];
}