import 'package:flutter/material.dart' hide Localizations;
import 'package:uimodex/services/localizations/localizations.dart';
import 'package:uimodex/services/theme_services.dart';

extension MyContext on BuildContext {
  ThemeServiceState get scheme => ThemeServices.of(this);
  Languages get locale => Localizations.of(this).lang;
  LocalizationsState get localDelegates => Localizations.of(this);

  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
  Brightness get brightness => MediaQuery.platformBrightnessOf(this);

  void toNamed(String path) => Navigator.pushNamed(this, path);
  void offNamed(String path) => Navigator.pushReplacementNamed(this, path);

  // Future<void> offAllNamed(String path) {
  //   predicate(Route _) => false;
  //   return Navigator.pushNamedAndRemoveUntil(this, path, predicate);
  // }

  void pop() => Navigator.pop(this);

  void popUntil(String path) {
    Navigator.popUntil(this, ModalRoute.withName(path));
  }

  void close(int count) {
    int popped = 0;
    Navigator.of(this).popUntil((route) => popped++ >= count);
  }
}

extension MyString on String {
  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';
}

extension MyBrightness on ThemeMode {
  Brightness get brightness {
    switch (this) {
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.light:
        return Brightness.light;
      default:
        return Brightness.light;
    }
  }
}
