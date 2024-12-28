import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobiledictionary/features/views/word_detail_screen.dart';
import 'dart:convert';

import 'package:mobiledictionary/widget/card.dart';

class Dicionario {
  List<dynamic> dicionario = [];
  List<Widget> lista_card = [];
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

  Future<List<Widget>> criandoCards() async {
    await carregarDicionario();

    for (var element in this.dicionario) {
      String word = element["chave"] as String;

      this.lista_card.add(getCard(
            word,
            backgroundColor: Color.fromARGB(255, 240, 240, 240),
            onTap: () {
              Navigator.push(
                  this.context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WordDetailScreen(word: word, this.dicionario)));
            },
          ));
    }

    return this.lista_card;
  }
}
