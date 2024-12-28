import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mobiledictionary/auth/auth_controller.dart';
import 'package:mobiledictionary/utils/cache.dart';
import 'package:mobiledictionary/utils/data_format.dart';
import 'package:mobiledictionary/widget/geticon.dart';

class RegisterView extends StatelessWidget {
  final AuthController ac;

  const RegisterView(this.ac, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Faça Seu Cadastro"),
          automaticallyImplyLeading: false,
          leading: getIcon(Icons.arrow_left, 20, () {
            Navigator.pushReplacementNamed(context, "/login");
          }, Colors.white),
        ),
        body: Register(ac: ac));
  }
}

class Register extends StatefulWidget {
  final AuthController ac;

  const Register({required this.ac});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _nomecontroller = TextEditingController();
  final TextEditingController _borndatecontroller = TextEditingController();

  dynamic realizarRegistro() async {
    final email = _emailcontroller.text;
    final password = _passwordcontroller.text;
    final nome = _nomecontroller.text;
    final borndate = _borndatecontroller.text;

    widget.ac.setEmail(email);
    widget.ac.setPassowrd(password);
    widget.ac.setBorndate(borndate);
    widget.ac.setNome(nome);

    var resposta_request = await widget.ac.registrar();
    return resposta_request;
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
                  onPressed: () async {
                    try {
                      var resp = await realizarRegistro();
                      var background_color;
                      if (resp.containsKey("message")) {
                        if (resp["message"]
                            .contains("Usuario registrado com sucesso")) {
                          background_color = Color.fromARGB(255, 80, 165, 83);
                          Cache().salvarNoCache(true);
                          Navigator.pushReplacementNamed(context, "/");
                        }
                      } else {
                        background_color = Color.fromARGB(255, 126, 52, 52);
                      }

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(resp["message"]),
                        backgroundColor: background_color,
                        action: SnackBarAction(
                            label: "Fechar",
                            textColor: Colors.black,
                            onPressed: () {}),
                      ));
                    } catch (e) {
                      Cache().salvarNoCache(false);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Erro na Criação do Usuário"),
                        backgroundColor: Color.fromARGB(255, 126, 52, 52),
                        action: SnackBarAction(
                            label: "Fechar",
                            textColor: Colors.black,
                            onPressed: () {}),
                      ));
                    }
                  },
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
