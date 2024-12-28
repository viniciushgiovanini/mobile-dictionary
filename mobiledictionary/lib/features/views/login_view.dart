import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mobiledictionary/auth/auth_controller.dart';

class LoginView extends StatelessWidget {
  final AuthController ac;

  const LoginView(this.ac, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: _Login(ac: ac),
    );
  }
}

class _Login extends StatefulWidget {
  final AuthController ac;

  const _Login({required this.ac});

  @override
  State<_Login> createState() => __LoginState();
}

class __LoginState extends State<_Login> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  Future<bool> verificarlogin() async {
    final email = _emailcontroller.text;
    final password = _passwordcontroller.text;
    // AuthController ac = new AuthController(email, password, "", "");

    widget.ac.setEmail(email);
    widget.ac.setPassowrd(password);

    var response = await widget.ac.verificar();
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
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
                      if (resp) {
                        txt = "Login bem-sucedido !";
                        // Navigator.pushReplacementNamed(context, "/");
                        salvarNoCache(true);
                      } else {
                        txt = "Login falhou !";
                      }

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(txt),
                        action:
                            SnackBarAction(label: "Fechar", onPressed: () {}),
                      ));

                      Navigator.pushReplacementNamed(context, "/");
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

void salvarNoCache(bool logado) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setBool('logado', logado);
}
