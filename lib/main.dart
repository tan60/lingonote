import 'package:flutter/material.dart';
import 'package:lingonote/domains/managers/pref_mgr.dart';
import 'package:lingonote/presenters/screen/home_screen.dart';
import 'package:lingonote/assets/themes/my_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
//import 'package:lingonote/screen/home_screen.dart';

void main() {
  initApp();
}

void initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  static ValueNotifier<Brightness> brightnessNotifier =
      ValueNotifier(Brightness.light);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  late final Future<bool> _isInitialized = _initializePreference();
  late Brightness _brightness;

  Future<bool> _initializePreference() async {
    SharedPreferences? prefs = await PrefMgr.initPref();

    _initBrightness();
    return true;
  }

  void _initBrightness() async {
    setState(() {
      String userBrightness =
          PrefMgr.prefs.getString(PrefMgr.theme) ?? 'system';

      if (userBrightness == 'system') {
        _brightness = WidgetsBinding.instance.window.platformBrightness;
      } else {
        if (userBrightness == 'light') {
          _brightness = Brightness.light;
        } else if (userBrightness == 'dark') {
          _brightness = Brightness.dark;
        }
      }

      App.brightnessNotifier.value = _brightness;
    });
  }

  @override
  void initState() {
    _initializePreference();

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
      _initBrightness();
    }
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return ValueListenableBuilder<Brightness>(
          valueListenable: App.brightnessNotifier,
          builder: (context, brightness, child) {
            return MaterialApp(
              theme: brightness == Brightness.light
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
      },
    );
  }
}
