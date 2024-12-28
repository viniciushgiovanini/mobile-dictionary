import 'package:flutter/material.dart';

Widget getCard(String cardname, {Color? backgroundColor}) {
  return Card(
    color: backgroundColor ?? Colors.white,
    child: _SampleCard(cardName: cardname),
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
