import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final db = FirebaseFirestore.instance;

  String get uid =>
      FirebaseAuth.instance.currentUser!.uid;

  // CRIAR TREINO
  Future<void> criarTreino(String nome) async {
    await db
        .collection('users')
        .doc(uid)
        .collection('treinos')
        .add({
      'nome': nome,
      'criadoEm': Timestamp.now(),
    });
  }

  // LISTAR TREINOS
  Stream<QuerySnapshot> listarTreinos() {
    return db
        .collection('users')
        .doc(uid)
        .collection('treinos')
        .snapshots();
  }

  // EXCLUIR TREINO
  Future<void> excluirTreino(
    String treinoId,
  ) async {
    await db
        .collection('users')
        .doc(uid)
        .collection('treinos')
        .doc(treinoId)
        .delete();
  }

  // ADICIONAR EXERCÍCIO
  Future<void> adicionarExercicio({
    required String treinoId,
    required String nome,
    required int series,
    required int repeticoes,
    required double carga,
  }) async {
    await db
        .collection('users')
        .doc(uid)
        .collection('treinos')
        .doc(treinoId)
        .collection('exercicios')
        .add({
      'nome': nome,
      'series': series,
      'repeticoes': repeticoes,
      'carga': carga,
    });
  }

  // LISTAR EXERCÍCIOS
  Stream<QuerySnapshot> listarExercicios(
    String treinoId,
  ) {
    return db
        .collection('users')
        .doc(uid)
        .collection('treinos')
        .doc(treinoId)
        .collection('exercicios')
        .snapshots();
  }

  // EXCLUIR EXERCÍCIO
  Future<void> excluirExercicio(
    String treinoId,
    String exercicioId,
  ) async {
    await db
        .collection('users')
        .doc(uid)
        .collection('treinos')
        .doc(treinoId)
        .collection('exercicios')
        .doc(exercicioId)
        .delete();
  }

  // ATUALIZAR EXERCÍCIO
  Future<void> atualizarExercicio({
    required String treinoId,
    required String exercicioId,
    required String nome,
    required int series,
    required int repeticoes,
    required double carga,
  }) async {
    await db
        .collection('users')
        .doc(uid)
        .collection('treinos')
        .doc(treinoId)
        .collection('exercicios')
        .doc(exercicioId)
        .update({
      'nome': nome,
      'series': series,
      'repeticoes': repeticoes,
      'carga': carga,
    });
  }
}