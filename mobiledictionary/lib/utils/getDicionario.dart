import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobiledictionary/features/views/word_detail_screen.dart';
import 'package:mobiledictionary/utils/word.dart';
import 'package:mobiledictionary/widget/card.dart';
import 'package:mobiledictionary/utils/user.dart';

// Classe responsavel por pegar dados do dataset e transformar em cards
class Dicionario {
  List<dynamic> dicionario = [];
  List<Widget> lista_card = [];
  List<Word> lista_de_words = [];
  var context;

  Dicionario(this.context);

  /// Carrega a lista dinamica com os dados do dicionario salvos no mysql
  ///
  /// - Retorna: Lista dinamica de dicionario carregada
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

  /// Cria os cards em batches
  ///
  /// - [User]: Objeto do tipo User, contendo dados do usuario.
  /// - [startIndex]: Valor inicial que irá começar o carregamento em batch.
  /// - [batchSize]: Quantidade de cards carregados por batch.
  /// - Retorna: uma Promise contendo uma lista de cards (Widgets)
  Future<List<Widget>> criandoCards(
      User user, int startIndex, int batchSize) async {
    await carregarDicionario();

    List<Widget> batchCards = [];
    int endIndex = (startIndex + batchSize).clamp(0, this.dicionario.length);

    for (int i = startIndex; i < endIndex; i++) {
      String word = this.dicionario[i]["chave"] as String;
      String prox =
          i + 1 < this.dicionario.length ? this.dicionario[i + 1]["chave"] : "";
      String ant = i - 1 >= 0 ? this.dicionario[i - 1]["chave"] : "";

      Word wd = Word(word, prox, ant);
      this.lista_de_words.add(wd);
      user.cloning_lista_de_words(this.lista_de_words);

      batchCards.add(getCard(
        word,
        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
        onTap: () {
          user.addHistorico(wd);
          user.context = context;

          Navigator.push(
            this.context,
            MaterialPageRoute(
              builder: (context) =>
                  WordDetailScreen(word: word, this.lista_de_words, user),
            ),
          );
        },
      ));
    }

    return batchCards;
  }
}
