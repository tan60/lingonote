import 'package:flutter/material.dart';
import 'package:lingonote/screen/edit_note_screen.dart';
import 'package:lingonote/themes/my_themes.dart';
//import 'package:lingonote/screen/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyThemes.getThemeFromKey(MyThemeKeys.LIGHT),
      title: 'Welcome to Flutter',

      //home: const HomeScreen(),
      home: const EditNote(),
    );
  }
}
