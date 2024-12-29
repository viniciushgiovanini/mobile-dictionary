import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Cache {
  void salvarNoCache(bool logado) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('logado', logado);
  }

  void salvarNomeNoCache(String nome) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('nome', nome);
  }

  void salvarTipomenu(int tipo_menu) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('tipo_menu', tipo_menu);
  }

  Future<int> carregarTipomenudoCache() async {
    final prefs = await SharedPreferences.getInstance();

    int tipo_menu = prefs.getInt('tipo_menu') ?? 0;

    return tipo_menu;
  }

  Future<bool> carregarDoCache() async {
    final prefs = await SharedPreferences.getInstance();

    bool logado = prefs.getBool('logado') ?? false;

    return logado;
  }

  Future<String> carregarNomeDoCache() async {
    final prefs = await SharedPreferences.getInstance();

    String nome = prefs.getString('nome') ?? "";

    return nome;
  }

  Future<void> salvarListaFavoritos(List<String> stringList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convertendo a lista de strings para JSON
    String jsonString = jsonEncode(stringList);
    await prefs.setString('stringListFavoritos', jsonString);
  }

  Future<List<String>> carregarListaFavoritos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('stringListFavoritos');
    List<String> loadedList = [];
    if (jsonString != null) {
      List<String> loadedList = List<String>.from(jsonDecode(jsonString));
      return loadedList;
    }

    return loadedList;
  }
}
