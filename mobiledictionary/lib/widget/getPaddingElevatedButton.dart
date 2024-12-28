import 'package:flutter/material.dart';

Widget getPaddingElevatedButtom(String text, VoidCallback onPressed, int index,
    int activationElevatedButton) {
  return Padding(
    // padding: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ButtonStyle(
        side: MaterialStateProperty.all(BorderSide.none),
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (activationElevatedButton == index) {
            return const Color.fromARGB(255, 117, 179, 230);
          } else {
            return Colors.white;
          }
        }),
        foregroundColor: MaterialStateProperty.all(
          activationElevatedButton == index ? Colors.white : Colors.black,
        ),
      ),
    ),
  );
}
