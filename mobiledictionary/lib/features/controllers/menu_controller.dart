import 'package:flutter/material.dart';
import 'package:mobiledictionary/widget/word_list.dart';

List<Widget> menuControler(int index) {
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
      WordList(),
    ];
    // lista_de_widget.add(WordList());
  } else if (index == 1) {
    lista_de_widget = [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          child: Text("History",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
    ];
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
