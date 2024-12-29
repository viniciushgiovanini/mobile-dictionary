import 'package:flutter/material.dart';
import 'package:mobiledictionary/features/views/word_detail_screen.dart';

List<Widget> boxText(data, word) {
  List<Widget> retorno = [];

  double font_size = 28.0;

  if (data is String) {
    font_size = 15;
  }

  retorno.add(
    Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Text(
        word,
        style: TextStyle(
            fontSize: font_size,
            color: Colors.black,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
  for (var element in veryWordwidget(data)) {
    retorno.add(element);
  }

  return retorno;
}

List<Widget> veryWordwidget(data) {
  List<Widget> retorno = [];

  if (data is Map && data.containsKey('phonetic')) {
    retorno.add(Text(
      data["phonetic"],
      style: TextStyle(fontSize: 24, color: Colors.black),
    ));
  }

  return retorno;
}

List<Widget> meaning(data) {
  List<Widget> retorno = [];

  if (data is Map && data.containsKey("meanings")) {
    var data_final = data["meanings"];

    data_final = data_final[0]["definitions"][0];

    retorno.add(Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Meaning", style: TextStyle(fontSize: 30, color: Colors.black))
      ],
    ));

    retorno.add(Padding(padding: EdgeInsets.only(top: 10)));

    retorno.add(Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
            child: Text(
          data_final["definition"],
          style: TextStyle(fontSize: 14, color: Colors.black),
        ))
      ],
    ));
  }
  return retorno;
}

List<Widget> footButtons(ant, word, prox, lista_de_words, context) {
  List<Widget> retorno = [];

  if (ant != "") {
    retorno.add(ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      WordDetailScreen(lista_de_words, word: ant)));
        },
        child: Text("Anterior"),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            textStyle: MaterialStateProperty.all(
              TextStyle(fontSize: 20),
            ))));
  } else {
    retorno.add(ElevatedButton(
        onPressed: null,
        child: Text("Anterior"),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.grey),
            foregroundColor: MaterialStateProperty.all(Colors.black),
            textStyle: MaterialStateProperty.all(
              TextStyle(fontSize: 20),
            ))));
  }
  if (prox != "") {
    retorno.add(Padding(
        padding: EdgeInsets.only(left: 10),
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WordDetailScreen(
                            lista_de_words,
                            word: prox,
                          )));
            },
            child: Text("Próximo"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                textStyle: MaterialStateProperty.all(
                  TextStyle(fontSize: 20),
                )))));
  } else {
    retorno.add(Padding(
        padding: EdgeInsets.only(left: 10),
        child: ElevatedButton(
            onPressed: null,
            child: Text("Próximo"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey),
                foregroundColor: MaterialStateProperty.all(Colors.black),
                textStyle: MaterialStateProperty.all(
                  TextStyle(fontSize: 20),
                )))));
  }

  return retorno;
}
