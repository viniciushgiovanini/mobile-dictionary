import 'package:flutter/material.dart';
import 'package:mobiledictionary/widget/getPaddingElevatedButton.dart';

// ignore: must_be_immutable
class getMenuBar extends StatefulWidget {
  int tipo_menu;
  final ValueChanged<int> onMenuChanged;

  getMenuBar({required this.tipo_menu, required this.onMenuChanged, super.key});

  @override
  State<getMenuBar> createState() => _getMenuBarState();
}

class _getMenuBarState extends State<getMenuBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                child: MenuBar(children: [
              getPaddingElevatedButtom("Word List", () {
                setState(() {
                  widget.tipo_menu = 0;
                  widget.onMenuChanged(0);
                });
              }, 0, widget.tipo_menu),
              getPaddingElevatedButtom("History", () {
                setState(() {
                  widget.tipo_menu = 1;
                  widget.onMenuChanged(1);
                });
              }, 1, widget.tipo_menu),
              getPaddingElevatedButtom("Favorites", () {
                setState(() {
                  widget.tipo_menu = 2;
                  widget.onMenuChanged(2);
                });
              }, 2, widget.tipo_menu),
            ]))
          ],
        )
      ],
    );
  }
}
