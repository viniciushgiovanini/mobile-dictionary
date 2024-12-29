import 'package:flutter/material.dart';

import 'package:mobiledictionary/auth/auth_controller.dart';
import 'package:mobiledictionary/features/controllers/menu_controller.dart';
import 'package:mobiledictionary/utils/cache.dart';
import 'package:mobiledictionary/utils/user.dart';
import 'package:mobiledictionary/widget/geticon.dart';
import 'package:mobiledictionary/widget/menu_bar.dart';

class WordsListView extends StatefulWidget {
  final AuthController ac;
  final User user;

  const WordsListView(this.ac, this.user, {super.key});

  @override
  State<WordsListView> createState() => _WordsListViewState();
}

class _WordsListViewState extends State<WordsListView> {
  String nome = "";

  @override
  void initState() {
    super.initState();
    carregarNome();
    carregarListaFavoritos();
  }

  void carregarListaFavoritos() async {
    List<String> listaFavoritoShared = await Cache().carregarListaFavoritos();

    widget.user.cloning_lista_de_favoritos(listaFavoritoShared);
  }

  void carregarNome() async {
    String tmpNome = await Cache().carregarNomeDoCache();

    setState(() {
      nome = tmpNome.split(" ")[0];
      widget.user.setNome(tmpNome);
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
          widget.ac.realizarLogout();
          Navigator.pushReplacementNamed(context, "/login");
        }, Colors.white),
      ),
      body: BodyView(widget.user),
      // body: ListView.builder(
      //   itemBuilder: (context, index) {
      //     return ListTile(title: Text('Palavra $index'));
      //   },
      // ),
    );
  }
}

class BodyView extends StatefulWidget {
  final User user;

  const BodyView(this.user, {super.key});

  @override
  State<BodyView> createState() => _BodyViewState();
}

class _BodyViewState extends State<BodyView> {
  int tipo_menu = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getMenuBar(
            tipo_menu: tipo_menu,
            onMenuChanged: (value) {
              setState(() {
                tipo_menu = value;
              });
            },
          ),
          ...menuControler(tipo_menu, widget.user)
        ],
      ),
    );
  }
}
