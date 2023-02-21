import 'package:flutter/material.dart';
import 'package:lingonote/screen/home_screen.dart';
import 'package:lingonote/themes/my_themes.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyThemes.lightTheme,
      title: 'Welcome to Flutter',
      home: const HomeScreen(),
    );
  }
}
