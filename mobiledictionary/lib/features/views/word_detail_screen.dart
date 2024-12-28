import 'package:flutter/material.dart';

import 'package:mobiledictionary/widget/geticon.dart';

class WordDetailScreen extends StatefulWidget {
  final List<dynamic> lista_dicionario;
  final String word;

  const WordDetailScreen(this.lista_dicionario,
      {required this.word, super.key});

  @override
  State<WordDetailScreen> createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // print(widget.lista_dicionario.length);

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
      ),
      // body: _Login(ac: ac),
    );
  }
}
