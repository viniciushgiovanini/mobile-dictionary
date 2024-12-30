import 'package:flutter/material.dart';

/// Cria um card
///
/// - [cardName]: Texto principal do card
/// - [backgroundColor]: Cor do fundo do card
/// - [onTap]: funcao a ser executada quando clicar no card
/// - Retorna: Widget do card
Widget getCard(String cardname,
    {Color? backgroundColor, required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      color: backgroundColor ?? Colors.white,
      child: _SampleCard(cardName: cardname),
    ),
  );
}

class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.cardName});
  final String cardName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Center(
          child: Text(
        cardName,
        style: TextStyle(color: Colors.black),
      )),
    );
  }
}
