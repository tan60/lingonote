import 'package:flutter/material.dart';
import 'package:lingonote/managers/pref_mgr.dart';
import 'package:lingonote/screen/home_screen.dart';
import 'package:lingonote/themes/my_themes.dart';
import 'package:sizer/sizer.dart';
//import 'package:lingonote/screen/home_screen.dart';

void main() {
  initApp();
}

void initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  App({super.key}) {
    //_initialize();
  }

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  late final Future<bool> _isInitialized = _initialize();

  late Brightness _brightness;

  Future<bool> _initialize() async {
    await PrefMgr.initPref();
    return true;
  }

  @override
  void initState() {
    _initialize();
    WidgetsBinding.instance.addObserver(this);
    _brightness = WidgetsBinding.instance.window.platformBrightness;
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (mounted) {
      setState(() {
        _brightness = WidgetsBinding.instance.window.platformBrightness;
      });
    }
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: _brightness == Brightness.light
              ? MyThemes.getThemeFromKey(MyThemeKeys.light)
              : MyThemes.getThemeFromKey(MyThemeKeys.dark),
          title: 'Welcome to LingoNote',
          home: FutureBuilder(
            future: _isInitialized,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const HomeScreen();
              } else {
                return Container(); //show splash
              }
            },
          ),
          //home: const EditNote(),
        );
      },
    );
  }
}
