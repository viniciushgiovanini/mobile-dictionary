import 'package:flutter/material.dart';
import 'package:mobiledictionary/features/views/word_detail_screen.dart';
import 'package:mobiledictionary/utils/cache.dart';
import 'package:mobiledictionary/utils/word.dart';
import 'package:mobiledictionary/widget/card.dart';
import 'package:mobiledictionary/widget/word_list.dart';
import 'package:mobiledictionary/utils/user.dart';

/// Lista que gera uma lista de widget da pagina principal em relação
/// a qual botão está selecionado
///
/// - [index]: valor numerico (0,1,2) de qual botão está selecionado
/// para informar qual será o corpo do app
/// - [User]: Objeto tipo user contendo as informacoes do usuario
/// - Retorna: Lista com widgets que será mostrado no corpo da tela principal.
List<Widget> menuControler(int index, User user) {
  List<Widget> lista_de_widget = [];
  Cache().salvarTipomenu(index);

  if (index == 0) {
    lista_de_widget = [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          child: Text("Word List",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
      WordList(
        user: user,
        tipo_uso: "WordList",
      ),
    ];
  } else if (index == 1) {
    List<Widget> lista_de_cards = [];

    lista_de_widget = [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          child: Text("History",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
    ];

    if (user.historico.length != 0) {
      for (var each in user.historico) {
        lista_de_cards.add(getCard(
          each.word,
          backgroundColor: Color.fromARGB(255, 240, 240, 240),
          onTap: () {
            Navigator.push(
              user.context,
              MaterialPageRoute(
                builder: (context) => WordDetailScreen(
                    word: each.word, user.lista_de_words, user),
              ),
            );
          },
        ));
      }

      lista_de_widget.add(
        WordList(
          key: UniqueKey(),
          user: user,
          tipo_uso: "History",
          lista_cards_opicional: lista_de_cards,
        ),
      );
    }
  } else if (index == 2) {
    List<Widget> lista_de_cards = [];

    lista_de_widget = [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          child: Text("Favorites",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
    ];

    if (user.favoritos.length != 0) {
      for (var each in user.favoritos) {
        List<Word> obj = user.lista_de_words
            .where(
              (value) => value.word == each,
            )
            .toList();

        if (obj.isNotEmpty) {
          String word = obj[0].word;
          lista_de_cards.add(getCard(
            word,
            backgroundColor: Color.fromARGB(255, 240, 240, 240),
            onTap: () {
              Navigator.push(
                user.context,
                MaterialPageRoute(
                  builder: (context) =>
                      WordDetailScreen(word: word, user.lista_de_words, user),
                ),
              );
            },
          ));
        }
      }

      lista_de_widget.add(
        WordList(
          key: UniqueKey(),
          user: user,
          tipo_uso: "Favorites",
          lista_cards_opicional: lista_de_cards,
        ),
      );
    }
  }

  return lista_de_widget;
}
