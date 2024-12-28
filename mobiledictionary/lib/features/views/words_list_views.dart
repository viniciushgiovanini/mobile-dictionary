import 'package:flutter/material.dart';
import 'package:mobiledictionary/auth/auth_controller.dart';
import 'package:mobiledictionary/utils/cache.dart';
import 'package:mobiledictionary/widget/geticon.dart';

class WordsListView extends StatefulWidget {
  final AuthController ac;

  const WordsListView(this.ac, {super.key});

  @override
  State<WordsListView> createState() => _WordsListViewState();
}

class _WordsListViewState extends State<WordsListView> {
  String nome = "";

  @override
  void initState() {
    super.initState();
    carregarNome();
  }

  void carregarNome() async {
    String tmpNome = await Cache().carregarNomeDoCache();

    setState(() {
      nome = tmpNome.split(" ")[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bem vindo ${nome}'),
        automaticallyImplyLeading: false,
        leading: getIcon(Icons.logout, 25, () {
          AuthController().realizarLogout();
          Navigator.pushReplacementNamed(context, "/login");
        }, Colors.white),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(title: Text('Palavra $index'));
        },
      ),
    );
  }
}
