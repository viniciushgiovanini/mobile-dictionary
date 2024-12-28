import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobiledictionary/utils/cache.dart';

class AuthController extends ChangeNotifier {
  String email = "";
  String password = "";
  String borndate = "";
  String nome = "";
  bool auth = false;

  void setEmail(String email) {
    this.email = email;
  }

  void setPassowrd(String password) {
    this.password = password;
  }

  void setBorndate(String borndate) {
    this.borndate = borndate;
  }

  void setNome(String nome) {
    this.nome = nome;
  }

  Future<bool> isAuthenticated() async {
    return this.auth;
  }

  Future<dynamic> registrar() async {
    final url = Uri.parse('http://localhost:5001/api/auth/register');
    var payload = {
      "name": this.nome,
      "email": this.email,
      "borndate": this.borndate,
      "password": this.password
    };

    if (this.nome == "" ||
        this.email == "" ||
        this.borndate == "" ||
        this.password == "") {
      return json.decode(
          {"message": "Erro na requisicao (Elementos em Branco)"} as String);
    }

    try {
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode(payload));

      final data = json.decode(response.body);
      this.carregarClasseComRequestBanco(payload);
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
          this.auth = true;
          this.carregarClasseComRequestBanco(data["data"]);
          // this.visualizarUser();
          return true;
        } else {
          this.auth = false;
          return false;
        }
      } else {
        this.auth = false;
        return false;
      }
    } catch (e) {
      print('Erro na requisicao de registrar: ${e})');
    }

    return false;
  }

  void realizarLogout() {
    this.auth = false;
    Cache().salvarNoCache(false);
    Cache().salvarNomeNoCache("");
  }

  void carregarClasseComRequestBanco(Map data) {
    setNome(data["name"]);
    Cache().salvarNomeNoCache(data["name"]);
    setEmail(data["email"]);
    setBorndate(data["borndate"]);
    setPassowrd(data["password"]);
  }

  void visualizarUser() {
    print(this.nome);
    print(this.email);
    print(this.password);
    print(this.borndate);
  }
}
