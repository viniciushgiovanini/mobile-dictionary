import 'package:flutter/material.dart';
import 'package:mobiledictionary/utils/getDicionario.dart';

class WordList extends StatefulWidget {
  const WordList({super.key});

  @override
  State<WordList> createState() => _WordListState();
}

class _WordListState extends State<WordList> {
  List<Widget> lista_cards = [];
  List<Widget> lista_cards_copy = [];
  bool isLoading = false;
  bool hasMoreItems = true;

  Future<void> _loadCards() async {
    if (isLoading || !hasMoreItems) return;

    setState(() {
      isLoading = true;
    });

    lista_cards.clear();

    List<Widget> cards = await Dicionario(context).criandoCards();

    if (cards.isEmpty) {
      setState(() {
        hasMoreItems = false;
      });
    }

    setState(() {
      lista_cards.addAll(cards);
      lista_cards_copy.addAll(cards);
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
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
          ),
          itemBuilder: (context, index) {
            if (index == lista_cards.length) {
              return Center(child: CircularProgressIndicator());
            }
            return lista_cards[index];
          },
        ),
      ),
    );
  }
}
