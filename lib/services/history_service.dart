import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {
  static const String _prefix = 'treino_';

  static Future<void> salvarTreino(
    String data,
    String valor,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_prefix$data', valor);
  }

  static Future<String?> buscarTreino(
    String data,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('$_prefix$data');
  }

  static Future<List<String>> listarTreinos() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs
        .getKeys()
        .where((key) => key.startsWith(_prefix))
        .toList()
      ..sort();
  }

  static Future<void> excluirTreino(
    String data,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_prefix$data');
  }
}