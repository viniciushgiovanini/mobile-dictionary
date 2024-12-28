import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthController {
  String email = "";
  int password = -1;
  String banco = "";
  String tabela = "";
  String borndate = "";
  String nome = "";

  AuthController(this.email, this.password, this.borndate, this.nome) {
    this.banco = dotenv.env['BANCO'] ?? 'Banco não encontrado';
    this.tabela = dotenv.env['TABLE'] ?? 'Tabela não encontrada';
  }

  void registrar() {
    print("cadastro_realizado_no_banco");
  }

  bool verificar() {
    print("Verificando registro banco");
    return false;
  }

  void printBancoDetails() {
    print(this.banco);
    print(this.tabela);
  }
}
