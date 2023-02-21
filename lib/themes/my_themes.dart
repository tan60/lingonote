import 'package:flutter/material.dart';

enum MyThemeKeys { LIGHT, DARK }

class MyThemes {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xfff78e93),
    appBarTheme: const AppBarTheme(
      color: Color(0xfff8ccd1),
      elevation: 0,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Colors.grey,
      cursorColor: Color(0xff171d49),
      selectionHandleColor: Color(0xfff78e93),
    ),
    brightness: Brightness.light,
    highlightColor: Colors.red,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xfff78e93),
      focusColor: Color(0xfff77777),
      splashColor: Color(0xfff78e93),
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: Colors.white)
        .copyWith(background: Colors.white),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.grey,
    brightness: Brightness.dark,
    highlightColor: Colors.white,
    textSelectionTheme:
        const TextSelectionThemeData(selectionColor: Colors.grey),
    colorScheme: ColorScheme.fromSwatch(
      backgroundColor: Colors.black54,
    ),
  );

  static ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.LIGHT:
        return lightTheme;
      case MyThemeKeys.DARK:
        return darkTheme;
      default:
        return lightTheme;
    }
  }
}
