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

  /// Carrega a lista de favoritos de cada usuario do local storage,
  ///  na variavel da classe user
  ///
  /// - [listaFavoritoShared]: List<String> contendo todas as palavras
  /// favoritaddas do usuario
  void carregarListaFavoritos() async {
    List<String> listaFavoritoShared =
        await widget.user.carregarListaFavoritos();

    widget.user.cloning_lista_de_favoritos(listaFavoritoShared);
  }

  // Faz o load do nome do usuario salvo no local storage
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
          widget.user.clearHistorico();
          Navigator.pushReplacementNamed(context, "/login");
        }, Colors.white),
      ),
      body: BodyView(widget.user),
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
  late Future<int> tipo_menu;

  // Carrega o tipo do botão que está selecionado (Salvo em local storage)
  Future<int> carregarTipoMenu() async {
    return await Cache().carregarTipomenudoCache();
  }

  @override
  void initState() {
    super.initState();
    tipo_menu = carregarTipoMenu();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: tipo_menu,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getMenuBar(
                  tipo_menu: snapshot.data!,
                  onMenuChanged: (value) {
                    setState(() {
                      tipo_menu = Future.value(value);
                    });
                  },
                ),
                ...menuControler(snapshot.data!, widget.user)
              ],
            ),
          );
        } else {
          return Center(child: Text('Nenhum dado disponível'));
        }
      },
    );
  }
}
