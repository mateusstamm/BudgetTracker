import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get themeData {
    const primaryColor = const Color.fromARGB(255, 46, 118, 49);
    final primaryColorDark = Colors.green[700];
    final primaryColorLight = Colors.green[200];

    const accentColor = Colors.lightGreen;
    final accentColorDark = Colors.lightGreen[700];

    return ThemeData(
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      primaryColorLight: primaryColorLight,
      appBarTheme: const AppBarTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        secondaryVariant: accentColorDark,
      ),
    );
  }

  static ThemeData get darkThemeData {
    const darkPrimaryColor = const Color.fromARGB(255, 0, 158, 96);
    final darkPrimaryColorDark = Colors.green[900];
    final darkPrimaryColorLight = Colors.green[300];

    const darkAccentColor = Colors.lightGreen;
    final darkAccentColorDark = Colors.lightGreen[700];

    return ThemeData(
      primaryColor: darkPrimaryColor,
      primaryColorDark: darkPrimaryColorDark,
      primaryColorLight: darkPrimaryColorLight,
      appBarTheme: const AppBarTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      colorScheme: ColorScheme.dark(
        primary: darkPrimaryColor,
        secondary: darkAccentColor,
        secondaryVariant: darkAccentColorDark,
      ),
    );
  }
}
