import 'package:flutter/foundation.dart';

class ThemeModel extends ChangeNotifier {
  bool _darkModeEnabled = false;

  bool get darkModeEnabled => _darkModeEnabled;

  void toggleDarkMode(bool value) {
    _darkModeEnabled = value;
    notifyListeners();
  }
}
