import 'package:flutter/services.dart';

// Classe responsavel por tratar o input de data
// de nascimento na tela de registro
class DataNascimentoInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(RegExp(r'\D'), '');
    String formattedText = '';

    if (text.length >= 1) {
      formattedText = text.substring(0, 2);
    }
    if (text.length >= 3) {
      formattedText += '/' + text.substring(2, 4);
    }
    if (text.length >= 5) {
      formattedText += '/' + text.substring(4, 8);
    }

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
