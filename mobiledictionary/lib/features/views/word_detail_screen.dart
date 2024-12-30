import 'package:flutter/material.dart';

import 'package:mobiledictionary/widget/checkWordwidget.dart';

import 'package:mobiledictionary/widget/geticon.dart';
import 'package:mobiledictionary/utils/word.dart';
import 'package:mobiledictionary/utils/user.dart';

class WordDetailScreen extends StatefulWidget {
  final List<Word> lista_de_word;
  final String word;
  final User user;

  const WordDetailScreen(this.lista_de_word, this.user,
      {required this.word, super.key});

  @override
  State<WordDetailScreen> createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen> {
  var dados_final;
  var word;
  var prox_word;
  var ant_word;
  String resultado_word = "";
  late bool isFavorito;

  /// Quando o widget é carregado, atualiza as variaveis da classe
  ///  com informações já adquiridas
  void loadWordJson() async {
    var resultado = widget.lista_de_word
        .firstWhere((element) => element.word == widget.word);

    var data = await resultado.get_word_json_api();

    if (data is List) {
      setState(() {
        dados_final = data[0];
        word = resultado.word;
        resultado_word = resultado.word;
        prox_word = resultado.prox;
        ant_word = resultado.ant;
      });
    } else {
      setState(() {
        dados_final = "";
        word = "Palavra não presente na DICTIONARYAPI";
        resultado_word = resultado.word;
        prox_word = resultado.prox;
        ant_word = resultado.ant;
      });
    }
  }

  @override
  void initState() {
    loadWordJson();
    isFavorito = widget.user.favoritos.contains(widget.word);
    super.initState();
  }

  /// Gerencia no local storage a lista de favorito para casa usuario autenticado
  /// baseado em seu email. Dessa forma a lista se mantem mesmo que se o usuario
  /// fizer logout.
  ///
  /// - [widget.word]: String sendo uma palavra favorita
  /// - [widget.user.favoritos]: Lista<String> contendo a lista de palavras favoritas
  void _toggleFavorite() {
    setState(() {
      if (isFavorito) {
        widget.user.removeFavorito(widget.word);
      } else {
        widget.user.addFavorito(widget.word);
      }
      isFavorito = !isFavorito;
      widget.user.salvarListaFavoritos(widget.user.favoritos);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Detalhes sobre a palavras: ${widget.word}",
        ),
        automaticallyImplyLeading: false,
        leading: getIcon(Icons.arrow_left, 35, () {
          Navigator.pushReplacementNamed(context, "/");
        }, Colors.white),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: _toggleFavorite,
              icon: Icon(
                Icons.star,
                color: isFavorito ? Colors.yellow : Colors.white,
              ),
            ),
          )
        ],
      ),
      body: dados_final == null
          ? Center(child: CircularProgressIndicator())
          : BodyWord(dados_final, word, prox_word, ant_word,
              widget.lista_de_word, widget.user, resultado_word),
    );
  }
}

// ignore: must_be_immutable
class BodyWord extends StatefulWidget {
  final dados_final;
  String resultado_word;
  String word = "";
  String prox_word = "";
  String ant_word = "";
  final lista_de_words;
  User user;

  BodyWord(this.dados_final, this.word, this.prox_word, this.ant_word,
      this.lista_de_words, this.user, this.resultado_word,
      {super.key});

  @override
  State<BodyWord> createState() => _BodyWordState();
}

class _BodyWordState extends State<BodyWord> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Center(
                  child: Container(
                      width: 400,
                      padding: EdgeInsets.all(60.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(202, 196, 196, 196),
                        border: Border.all(
                            color: Color.fromARGB(104, 0, 0, 0), width: 2),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        children: [...boxText(widget.dados_final, widget.word)],
                      )))),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 22, horizontal: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                audio_widget(widget.dados_final),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                ...meaning(widget.dados_final),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...footButtons(
                    widget.ant_word,
                    widget.word,
                    widget.prox_word,
                    widget.lista_de_words,
                    context,
                    widget.user,
                    widget.resultado_word)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
