import 'package:flutter/material.dart';

enum MyThemeKeys { light, dark }

class MyThemes {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFFF98A9B),
    primaryColorLight: const Color(0xFFF98A9B),
    primaryColorDark: const Color(0xFFF98A9B),
    canvasColor: const Color(0xFFFAFAFA),
    cardColor: const Color(0xFFFFFFFF),
    dialogBackgroundColor: const Color(0xFFFFFFFF),
    disabledColor: const Color(0xFF000000).withOpacity(0.38),
    dividerColor: const Color(0xFF000000).withOpacity(0.12),
    focusColor: const Color(0xFF000000).withOpacity(0.8),
    highlightColor: const Color(0xFFBCBCBC).withOpacity(0.4),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Color(0xFFF98A9B),
      foregroundColor: Colors.black,
      shadowColor: Colors.black,
      elevation: 0,
    ),
    //brightness: Brightness.light,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: const Color(0xFFF98A9B),
        foregroundColor: Colors.black,
        focusColor: const Color(0xFF000000).withOpacity(0.12),
        splashColor: const Color(0xFFE7626C).withOpacity(0.4),
        hoverColor: const Color(0xFF000000).withOpacity(0.4)),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: const Color(0xFFF98A9B))
        .copyWith(background: const Color(0xFFFAFAFA))
        .copyWith(error: const Color(0xFFB00020)),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: Colors.black.withOpacity(0.7),
      ),
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: MaterialStateProperty.all(
        const Color(0xFFB00020).withOpacity(0.5),
      ),
    ),
    fontFamily: 'Pretendard',
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: const Color(0xFFF98A9B),
    primaryColorLight: const Color(0xFF303030),
    primaryColorDark: const Color(0xFFF98A9B),
    canvasColor: const Color(0xFF303030),
    cardColor: const Color(0xFF424242),
    dialogBackgroundColor: const Color(0xFF424242),
    disabledColor: const Color(0xFFFFFFFF).withOpacity(0.38),
    dividerColor: const Color(0xFFFFFFFF).withOpacity(0.12),
    focusColor: const Color(0xFFFFFFFF).withOpacity(0.8),
    highlightColor: const Color(0xFFCCCCCC).withOpacity(0.4),
    scaffoldBackgroundColor: const Color(0xFF303030),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF303030),
      foregroundColor: Color(0xFFFFFFFF),
      shadowColor: Colors.black,
      elevation: 0,
    ),
    //brightness: Brightness.light,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: const Color(0xFFF98A9B),
        foregroundColor: Colors.black,
        focusColor: const Color(0xFFFFFFFF).withOpacity(0.12),
        splashColor: const Color(0xFFCCCCCC).withOpacity(0.4),
        hoverColor: const Color(0xFFFFFFFF).withOpacity(0.4)),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: const Color(0xFFF98A9B))
        .copyWith(background: const Color(0xFF303030))
        .copyWith(error: const Color(0xFFCF6679)),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: Colors.white.withOpacity(0.9),
      ),
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: MaterialStateProperty.all(
        const Color(0xFFCCCCCC).withOpacity(0.5),
      ),
    ),
    fontFamily: 'Pretendard',
  );

  static ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.light:
        return lightTheme;
      case MyThemeKeys.dark:
        return darkTheme;
      default:
        return lightTheme;
    }
  }
}
