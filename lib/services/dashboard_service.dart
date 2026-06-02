import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardService {
  final db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getStats() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception("Usuário não autenticado");
    }

    final snapshot = await db
        .collection('users')
        .doc(user.uid)
        .collection('workouts')
        .get();

    final workouts = snapshot.docs;

    int totalWorkouts = workouts.length;

    // 📅 contagem por dia da semana
    Map<String, int> daysCount = {
      'Mon': 0,
      'Tue': 0,
      'Wed': 0,
      'Thu': 0,
      'Fri': 0,
      'Sat': 0,
      'Sun': 0,
    };

    for (var doc in workouts) {
      final data = doc.data();

      final Timestamp? ts = data['createdAt'];
      if (ts == null) continue;

      final date = ts.toDate();
      final weekday = date.weekday;

      switch (weekday) {
        case 1:
          daysCount['Mon'] = daysCount['Mon']! + 1;
          break;
        case 2:
          daysCount['Tue'] = daysCount['Tue']! + 1;
          break;
        case 3:
          daysCount['Wed'] = daysCount['Wed']! + 1;
          break;
        case 4:
          daysCount['Thu'] = daysCount['Thu']! + 1;
          break;
        case 5:
          daysCount['Fri'] = daysCount['Fri']! + 1;
          break;
        case 6:
          daysCount['Sat'] = daysCount['Sat']! + 1;
          break;
        case 7:
          daysCount['Sun'] = daysCount['Sun']! + 1;
          break;
      }
    }

    return {
      "totalWorkouts": totalWorkouts,
      "daysCount": daysCount,
    };
  }
}