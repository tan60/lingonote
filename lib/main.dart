import 'package:flutter/material.dart';
import 'package:lingonote/managers/pref_mgr.dart';
import 'package:lingonote/screen/home_screen.dart';
import 'package:lingonote/themes/my_themes.dart';
//import 'package:lingonote/screen/home_screen.dart';

void main() {
  initApp();
}

void initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key}) {
    _initialize();
  }

  late final Future<bool> _isInitialized = _initialize();

  Future<bool> _initialize() async {
    await PrefMgr.initPref();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyThemes.getThemeFromKey(MyThemeKeys.LIGHT),
      title: 'Welcome to LingoNote',

      home: FutureBuilder(
        future: _isInitialized,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return Container(
              color: Colors.amber,
            ); //show splash
          }
        },
      ),
      //home: const EditNote(),
    );
  }
}
