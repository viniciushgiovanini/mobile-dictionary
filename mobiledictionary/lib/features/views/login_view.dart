import 'package:flutter/material.dart';

import 'package:mobiledictionary/auth/auth_controller.dart';
import 'package:mobiledictionary/utils/cache.dart';
import 'package:mobiledictionary/utils/user.dart';

class LoginView extends StatelessWidget {
  final AuthController ac;
  final User user;

  const LoginView(this.ac, this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Mobile Dictionary",
        ),
        automaticallyImplyLeading: false,
      ),
      body: _Login(ac: ac, user: user),
    );
  }
}

class _Login extends StatefulWidget {
  final AuthController ac;
  final User user;

  const _Login({required this.ac, required this.user});

  @override
  State<_Login> createState() => __LoginState();
}

class __LoginState extends State<_Login> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  /// Verifica a informacoes passadas com o banco, e adiciona as informacoes
  /// na classe de auth e do user.
  ///
  /// - [email]: Email do usuario
  /// - [password]: Senha do usuario
  /// - Retorna: json contendo a resposta da requisicao ao banco
  Future<bool> verificarlogin() async {
    final email = _emailcontroller.text;
    final password = _passwordcontroller.text;

    widget.ac.setEmail(email);
    widget.ac.setPassowrd(password);

    var response = await widget.ac.verificar();

    widget.user.setNome(widget.ac.nome);
    widget.user.setEmail(email);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(top: 30)),
            TextField(
              controller: _emailcontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            TextField(
              obscureText: true,
              controller: _passwordcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Password"),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    try {
                      var resp = await verificarlogin();

                      String txt;
                      var background_color;
                      if (resp) {
                        txt = "Login bem-sucedido !";
                        Navigator.pushReplacementNamed(context, "/");

                        Cache().salvarNoCache(true);

                        background_color = Color.fromARGB(255, 80, 165, 83);
                      } else {
                        txt = "Login falhou !";
                        background_color = Color.fromARGB(255, 126, 52, 52);
                      }

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(txt),
                        backgroundColor: background_color,
                        action: SnackBarAction(
                            label: "Fechar",
                            textColor: Colors.black,
                            onPressed: () {}),
                      ));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Erro no Login"),
                        action:
                            SnackBarAction(label: "Fechar", onPressed: () {}),
                      ));
                    }
                  },
                  child: Text('Logar'),
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
                Padding(padding: EdgeInsets.only(right: 10)),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/register");
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
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
          ],
        ),
      ),
    );
  }
}
