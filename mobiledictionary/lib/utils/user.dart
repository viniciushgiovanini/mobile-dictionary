import 'package:mobiledictionary/utils/word.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class User {
  String nome = "";
  String email = "";
  List<Word> historico = [];
  List<String> favoritos = [];
  List<Word> lista_de_words = [];
  late SharedPreferences prefs;

  var context;

  void cloning_lista_de_words(List<Word> lista_de_words) {
    this.lista_de_words.addAll(lista_de_words);
  }

  void cloning_lista_de_favoritos(List<String> favoritos) {
    this.favoritos = favoritos;
  }

  void setNome(String nome) {
    this.nome = nome;
  }

  void setEmail(String email) {
    this.email = email;
  }

  void clearHistorico() {
    this.historico.clear();
  }

  void addHistorico(Word new_word) {
    bool existe = this.historico.any((word) => word.word == new_word.word);

    if (!existe) {
      this.historico.add(new_word);
    }
  }

  void addFavorito(String word) {
    this.favoritos.add(word);
  }

  String getNome() {
    return this.nome;
  }

  String getEmail() {
    return this.email;
  }

  List<String> getFavorito() {
    return this.favoritos;
  }

  List<Word> getHistorico() {
    return this.historico;
  }

  void removeFavorito(String word_atual) {
    this.favoritos.remove(word_atual);
  }

  Future<void> salvarListaFavoritos(List<String> stringList) async {
    this.prefs = await SharedPreferences.getInstance();

    String jsonString = jsonEncode(stringList);
    await prefs.setString('stringListFavoritos_${this.email}', jsonString);
  }

  Future<List<String>> carregarListaFavoritos() async {
    this.prefs = await SharedPreferences.getInstance();

    String? jsonString = prefs.getString('stringListFavoritos_${this.email}');
    List<String> loadedList = [];
    if (jsonString != null) {
      List<String> loadedList = List<String>.from(jsonDecode(jsonString));
      return loadedList;
    }

    return loadedList;
  }
}
