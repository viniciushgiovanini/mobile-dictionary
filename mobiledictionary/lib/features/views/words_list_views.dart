import 'package:flutter/material.dart';
import 'package:mobiledictionary/auth/auth_controller.dart';
import 'package:mobiledictionary/widget/geticon.dart';

class WordsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Palavras'),
        automaticallyImplyLeading: false,
        actions: [
          getIcon(Icons.logout, 20, () {
            AuthController().realizarLogout();
            Navigator.pushReplacementNamed(context, "/login");
          }, Colors.grey)
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(title: Text('Palavra $index'));
        },
      ),
    );
  }
}
