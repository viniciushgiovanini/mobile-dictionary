import 'package:http/http.dart' as http;
import 'dart:convert';

class Word {
  String ant;
  String word;
  String prox;

  Word(this.word, this.prox, this.ant);

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
