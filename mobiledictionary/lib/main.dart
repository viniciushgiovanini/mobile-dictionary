import 'package:flutter/material.dart';
import 'package:mobiledictionary/features/views/login_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import "theme/app_theme.dart";
import 'features/views/words_list_views.dart';
import 'features/views/login_view.dart';
import 'features/views/register_view.dart';

void main() async {
  // await dotenv.load();
  dotenv.load(fileName: "../.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Dictionary',
      theme: appTheme,
      initialRoute: "/register",
      routes: {
        "/": (context) => WordsListView(),
        "/login": (context) => LoginView(),
        "/register": (context) => RegisterView(),
      },
    );
  }
}
