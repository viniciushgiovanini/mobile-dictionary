import 'package:mobiledictionary/utils/word.dart';

class User {
  String nome = "";
  List<Word> historico = [];
  List<String> favoritos = [];
  List<Word> lista_de_words = [];

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

  List<String> getFavorito() {
    return this.favoritos;
  }

  List<Word> getHistorico() {
    return this.historico;
  }

  void removeFavorito(String word_atual) {
    this.favoritos.remove(word_atual);
  }
}
