import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobiledictionary/features/views/word_detail_screen.dart';
import 'package:mobiledictionary/utils/word.dart';
import 'package:mobiledictionary/widget/card.dart';
import 'package:mobiledictionary/utils/user.dart';

class Dicionario {
  List<dynamic> dicionario = [];
  List<Widget> lista_card = [];
  List<Word> lista_de_words = [];
  var context;

  Dicionario(this.context);

  Future<void> carregarDicionario() async {
    final url = Uri.parse('http://localhost:5001/api/dados/dicionario');

    try {
      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      final data = json.decode(response.body);

      if (data.length != 0) {
        this.dicionario = data["data"];
      }
    } catch (e) {
      print("Deu erro na requisicao do dicionario ${e}");
    }
  }

  Future<List<Widget>> criandoCards(User user) async {
    await carregarDicionario();

    for (int i = 0; i < this.dicionario.length; i++) {
      String word = this.dicionario[i]["chave"] as String;
      String prox = "";
      String ant = "";

      if (i + 1 < this.dicionario.length) {
        prox = this.dicionario[i + 1]["chave"];
      }

      if (i - 1 >= 0) {
        ant = this.dicionario[i - 1]["chave"];
      }

      Word wd = new Word(word, prox, ant);
      this.lista_de_words.add(wd);

      user.cloning_lista_de_words(this.lista_de_words);

      this.lista_card.add(getCard(
            word,
            backgroundColor: Color.fromARGB(255, 240, 240, 240),
            onTap: () {
              user.addHistorico(wd);
              user.context = context;

              Navigator.push(
                  this.context,
                  MaterialPageRoute(
                      builder: (context) => WordDetailScreen(
                          word: word, this.lista_de_words, user)));
            },
          ));
    }

    return this.lista_card;
  }
}
