import 'package:mobiledictionary/utils/word.dart';

class User {
  String nome = "";
  List<Word> historico = [];
  List<Word> favoritos = [];
  List<Word> lista_de_words = [];
  var context;

  void cloning_lista_de_words(List<Word> lista_de_words) {
    this.lista_de_words = lista_de_words;
  }

  void setNome(String nome) {
    this.nome = nome;
  }

  void addHistorico(Word word) {
    this.historico.add(word);
  }

  void addFavorito(Word word) {
    this.favoritos.add(word);
  }

  String getNome() {
    return this.nome;
  }

  List<Word> getFavorito() {
    return this.favoritos;
  }

  List<Word> getHistorico() {
    return this.historico;
  }
}
