import 'package:flutter/material.dart';

enum MyThemeKeys { LIGHT, DARK }

class MyThemes {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFFF98A9B),
    primaryColorLight: const Color(0xFFFBB9C3),
    primaryColorDark: const Color(0xFFF98A9B),
    canvasColor: const Color(0xFFFAFAFA),
    cardColor: const Color(0xFFFFFFFF),
    dialogBackgroundColor: const Color(0xFFFFFFFF),
    disabledColor: const Color(0xFF000000).withOpacity(0.38),
    dividerColor: const Color(0xFF000000).withOpacity(0.12),
    focusColor: const Color(0xFF000000).withOpacity(0.12),
    highlightColor: const Color(0xFFBCBCBC).withOpacity(0.4),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Color(0xFFF98A9B),
      foregroundColor: Colors.black,
      shadowColor: Colors.black,
      elevation: 0,
    ),
    brightness: Brightness.light,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: const Color(0xFFF98A9B),
        foregroundColor: Colors.black,
        focusColor: const Color(0xFF000000).withOpacity(0.12),
        splashColor: const Color(0xFFE7626C).withOpacity(0.4),
        hoverColor: const Color(0xFF000000).withOpacity(0.4)),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: Colors.white)
        .copyWith(background: Colors.white)
        .copyWith(error: const Color(0xFFD32F2F)),
    fontFamily: 'Pretendard',
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
    fontFamily: 'Pretendard',
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
