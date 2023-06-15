import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get themeData {
    // Cores primárias
    const primaryColor = const Color.fromARGB(255, 46, 118, 49);
    final primaryColorDark = Colors.green[700];
    final primaryColorLight = Colors.green[200];

    // Cores de acentuação
    const accentColor = Colors.lightGreen;
    final accentColorDark = Colors.lightGreen[700];

    return ThemeData(
      // Cores primárias
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      primaryColorLight: primaryColorLight,

      // Borda arredondada
      appBarTheme: const AppBarTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),

      // Configurações de cores
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        secondaryVariant: accentColorDark,
      ),

      // Outras configurações de cores e estilos do tema
    );
  }

  static ThemeData get darkThemeData {
    // Cores primárias no modo escuro
    const darkPrimaryColor = const Color.fromARGB(255, 0, 158, 96);
    final darkPrimaryColorDark = Colors.green[900];
    final darkPrimaryColorLight = Colors.green[300];

    // Cores de acentuação no modo escuro
    const darkAccentColor = Colors.lightGreen;
    final darkAccentColorDark = Colors.lightGreen[700];

    return ThemeData(
      // Cores primárias no modo escuro
      primaryColor: darkPrimaryColor,
      primaryColorDark: darkPrimaryColorDark,
      primaryColorLight: darkPrimaryColorLight,

      // Borda arredondada no modo escuro
      appBarTheme: const AppBarTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),

      // Configurações de cores no modo escuro
      colorScheme: ColorScheme.dark(
        primary: darkPrimaryColor,
        secondary: darkAccentColor,
        secondaryVariant: darkAccentColorDark,
      ),

      // Outras configurações de cores e estilos do tema escuro
    );
  }
}
