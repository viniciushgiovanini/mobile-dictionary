import 'package:flutter/material.dart';
import 'package:mobiledictionary/features/views/word_detail_screen.dart';
import 'package:mobiledictionary/widget/card.dart';
import 'package:mobiledictionary/widget/word_list.dart';
import 'package:mobiledictionary/utils/user.dart';

List<Widget> menuControler(int index, User user) {
  List<Widget> lista_de_widget = [];

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
    // lista_de_widget.add(WordList());
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
                        word: each.word, user.lista_de_words, user)));
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

    // lista_de_widget.add(WordList());
  } else if (index == 2) {
    lista_de_widget = [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          child: Text("Favorites",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
    ];
  }

  return lista_de_widget;
}
