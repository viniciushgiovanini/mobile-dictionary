import 'package:flutter/material.dart';
import 'package:mobiledictionary/features/views/word_detail_screen.dart';
import 'package:mobiledictionary/utils/word.dart';
import 'package:mobiledictionary/widget/audioplayer.dart';

/// Funcao responsavel em criar o conjunto
/// de widget da exibicao de dados da palavra
/// Responsavel pelo TextBox principal
///
/// - [data]: Json referente a request da api do dicionario
/// - [word]: Palavra principal que está sendo buscada
/// - Retorna: Lista de widgets para monsta a exibicao da palavra principal
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

// Funcao responsavel por verificar e criar o texto contendo
// o significado da palavra, faz parte do TexBox principal
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

// Cria o texto de titulo de significado na tela de visualizacao
// detalhada da palavra
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

// Responsavel pelos butoes ANTERIOR e PROXIMO, da tela de visualizacao
// detalhada da palavra
List<Widget> footButtons(
    ant, word, prox, lista_de_words, context, user, resultado_word) {
  List<Widget> retorno = [];

  // Se tiver como habilita o botão, caso não tem palavra anterior ou prox
  // desabilita o botão
  if (ant != "") {
    retorno.add(ElevatedButton(
        onPressed: () {
          Word wd = new Word(resultado_word, prox, ant);
          user.addHistorico(wd);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      WordDetailScreen(lista_de_words, user, word: ant)));
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
              Word wd = new Word(resultado_word, prox, ant);
              user.addHistorico(wd);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WordDetailScreen(
                            lista_de_words,
                            user,
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

// Responsavel pela criacao do widget de audio, retorna o widget
// com o player caso a palavra selecionada tenha o audio disponivel
Widget audio_widget(data) {
  List<String> audios = [];

  if (data is String) {
    return Text("");
  }

  for (var element in data["phonetics"]) {
    if (element["audio"] != "") {
      audios.add(element["audio"]);
    }
  }

  if (audios.length != 0) {
    return AudioPlayerScreen(audios[0]);
  }

  return Text("Audio Indisponivel");
}
