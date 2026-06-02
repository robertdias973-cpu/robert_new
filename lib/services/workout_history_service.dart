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

  Stream<List<Map<String, dynamic>>> getWorkouts() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Stream.empty();
    }

    return db
        .collection('users')
        .doc(user.uid)
        .collection('workouts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();

        return {
          'id': doc.id,
          'date': data['date'] ?? '',
          'exercises': data['exercises'] ?? {},
          'completed': data['completed'] ?? false,
        };
      }).toList();
    });
  }
}