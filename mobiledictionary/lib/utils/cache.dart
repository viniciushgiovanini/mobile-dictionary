import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  void salvarNoCache(bool logado) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('logado', logado);
  }

  void salvarNomeNoCache(String nome) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('nome', nome);
  }

  Future<bool> carregarDoCache() async {
    final prefs = await SharedPreferences.getInstance();

    bool logado = prefs.getBool('logado') ?? false;

    return logado;
  }

  Future<String> carregarNomeDoCache() async {
    final prefs = await SharedPreferences.getInstance();

    String nome = prefs.getString('nome') ?? "";

    print("DADO QUE VOLTO DO CACHE: ${nome}");

    return nome;
  }
}
