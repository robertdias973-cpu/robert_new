import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WorkoutHistoryService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> saveWorkout(Map<String, int> exercises) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception("Usuário não autenticado");
    }

    final uid = user.uid;

    final now = DateTime.now();
    final date = "${now.year}_${now.month}_${now.day}";

    await db
        .collection('users')
        .doc(uid)
        .collection('workouts')
        .doc(date)
        .set({
      'date': date,
      'exercises': exercises,
      'completed': true,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}