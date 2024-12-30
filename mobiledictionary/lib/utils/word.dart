import 'package:http/http.dart' as http;
import 'dart:convert';

// Classe que repreta a palavra atual, para gerenciar os cards
class Word {
  String ant;
  String word;
  String prox;

  Word(this.word, this.prox, this.ant);

  /// Faz o get dos dados do dataset no banco de dados do mysql
  ///
  /// - Retorna: Json contendo todos os dados do dataset de palavras em ingles.
  Future<dynamic> get_word_json_api() async {
    final url = Uri.parse(
        'https://api.dictionaryapi.dev/api/v2/entries/en/${this.word}');

    try {
      final response =
          await http.get(url, headers: {"Content-Type": "application/json"});

      final data = json.decode(response.body);
      return data;
    } catch (e) {
      print("Erro na requisicao da api dicionario: ${e}");
    }
  }
}
