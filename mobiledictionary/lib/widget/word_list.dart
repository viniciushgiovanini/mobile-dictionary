import 'package:flutter/material.dart';
import 'package:mobiledictionary/utils/getDicionario.dart';
import 'package:mobiledictionary/utils/user.dart';

class WordList extends StatefulWidget {
  final User user;
  final String tipo_uso;
  final List<Widget> lista_cards_opicional;

  const WordList({
    required this.user,
    required this.tipo_uso,
    this.lista_cards_opicional = const [],
    super.key,
  });

  @override
  State<WordList> createState() => _WordListState();
}

class _WordListState extends State<WordList> {
  List<Widget> lista_cards = [];
  bool isLoading = false;
  bool hasMoreItems = true;
  int currentIndex = 0;
  final int batchSize = 100;

  /// Faz o carregando da corpo que contem os cards dependendo de qual botao
  /// esta ativado (WordList, History ou Favorites), gerando os cards atraves
  /// de rolagem infita carregando 100 por batch.
  Future<void> _loadCards() async {
    if (isLoading || !hasMoreItems) return;

    setState(() {
      isLoading = true;
    });

    lista_cards.clear();

    List<Widget> cards = [];

    if (widget.tipo_uso == "WordList") {
      cards = await Dicionario(context)
          .criandoCards(widget.user, currentIndex, batchSize);
    } else if (widget.tipo_uso == "History" || widget.tipo_uso == "Favorites") {
      cards = widget.lista_cards_opicional;
    }

    if (cards.isEmpty) {
      setState(() {
        hasMoreItems = false;
      });
    } else {
      setState(() {
        lista_cards.addAll(cards);
        currentIndex += batchSize;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollEndNotification &&
              scrollNotification.metrics.extentAfter == 0 &&
              hasMoreItems) {
            _loadCards();
            return true;
          }
          return false;
        },
        child: GridView.builder(
          itemCount: lista_cards.length + (isLoading ? 1 : 0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
          ),
          itemBuilder: (context, index) {
            if (index == lista_cards.length) {
              return const Center(child: CircularProgressIndicator());
            }
            return lista_cards[index];
          },
        ),
      ),
    );
  }
}
