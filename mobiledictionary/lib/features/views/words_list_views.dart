import 'package:flutter/material.dart';

class WordsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Palavras')),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(title: Text('Palavra $index'));
        },
      ),
    );
  }
}
