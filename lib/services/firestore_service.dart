import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/exercise.dart';

class FirestoreService {
  final CollectionReference ref =
      FirebaseFirestore.instance.collection('exercises');

  Future<void> addExercise(Exercise ex) async {
    await ref.add(ex.toMap());
  }

  Stream<List<Exercise>> getExercises() {
    return ref.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Exercise.fromMap(
          doc.id,
          doc.data() as Map<String, dynamic>,
        );
      }).toList();
    });
  }

  Future<void> updateExercise(Exercise ex) async {
    await ref.doc(ex.id).update(ex.toMap());
  }

  Future<void> deleteExercise(String id) async {
    await ref.doc(id).delete();
  }
}