import 'package:flutter/material.dart';
import "theme/app_theme.dart";

import 'package:mobiledictionary/auth/auth_controller.dart';
import 'features/views/words_list_views.dart';
import 'features/views/login_view.dart';
import 'features/views/register_view.dart';
import 'package:mobiledictionary/utils/cache.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Dictionary',
      theme: appTheme,
      home: AuthChecker(),
    );
  }
}

class AuthChecker extends StatelessWidget {
  Future<bool> isAuthenticated() async {
    return Cache().carregarDoCache();
  }

  @override
  Widget build(BuildContext context) {
    AuthController ac = AuthController();

    return FutureBuilder<bool>(
      future: isAuthenticated(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == true) {
          return MaterialApp(
            title: 'Mobile Dictionary',
            theme: appTheme,
            initialRoute: "/",
            routes: {
              "/": (context) => WordsListView(),
              "/login": (context) => LoginView(ac),
              "/register": (context) => RegisterView(ac),
            },
          );
        } else {
          return MaterialApp(
            title: 'Mobile Dictionary',
            theme: appTheme,
            initialRoute: "/login",
            routes: {
              "/": (context) => WordsListView(),
              "/login": (context) => LoginView(ac),
              "/register": (context) => RegisterView(ac),
            },
          );
        }
      },
    );
  }
}
