import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobiledictionary/auth/auth_controller.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Faça Seu Cadastro"),
        ),
        body: Register());
  }
}

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _nomecontroller = TextEditingController();
  final TextEditingController _borndatecontroller = TextEditingController();

  void realizarRegistro() {
    final email = _emailcontroller.text;
    final password = _passwordcontroller.text;
    final nome = _nomecontroller.text;
    final borndate = _borndatecontroller.text;

    print(email);
    print(password);
    print(nome);
    print(borndate);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: 300,
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 30)),
                TextField(
                  controller: _nomecontroller,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 15)),
                TextField(
                  controller: _borndatecontroller,
                  decoration: InputDecoration(
                    labelText: 'Data de Nascimento',
                    hintText: "DD/MM/YYYY",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                    DataNascimentoInputFormatter(),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 15)),
                TextField(
                  controller: _emailcontroller,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 15)),
                TextField(
                  controller: _passwordcontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: realizarRegistro,
                  child: Text('Registrar'),
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                      textStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
              ],
            )));
  }
}

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
