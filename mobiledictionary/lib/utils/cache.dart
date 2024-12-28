import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  void salvarNoCache(bool logado) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('logado', logado);
  }

  Future<bool> carregarDoCache() async {
    final prefs = await SharedPreferences.getInstance();

    bool logado = prefs.getBool('logado') ?? false;

    // print('Logado: $logado');
    return logado;
  }
}
