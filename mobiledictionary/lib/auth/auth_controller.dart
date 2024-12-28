import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthController {
  String email = "";
  String password = "";
  String borndate = "";
  String nome = "";

  AuthController(this.email, this.password, this.borndate, this.nome);

  Future<dynamic> registrar() async {
    final url = Uri.parse('http://localhost:5001/api/auth/register');
    var payload = {
      "name": this.nome,
      "email": this.email,
      "borndate": this.borndate,
      "password": this.password
    };
    try {
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode(payload));

      final data = json.decode(response.body);
      return data;
    } catch (e) {
      print('Erro na requisicao de registrar: ${e})');
    }

    print("cadastro_realizado_no_banco");
  }

  Future<bool> verificar() async {
    final url = Uri.parse('http://localhost:5001/api/auth/login');
    var payload = {
      "name": this.nome,
      "email": this.email,
      "borndate": this.borndate,
      "password": this.password
    };

    try {
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode(payload));

      final data = json.decode(response.body);

      if (data.containsKey("message")) {
        if (data["message"].contains("bem-sucedido")) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print('Erro na requisicao de registrar: ${e})');
    }

    return false;
  }
}
