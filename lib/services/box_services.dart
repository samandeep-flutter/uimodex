import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uimodex/models/utils/app_constants.dart';
import 'package:uimodex/services/localizations/localizations.dart';
import 'package:uimodex/services/theme_services.dart';

class BoxServices {
  BoxServices._init();

  static BoxServices? _instance;
  static BoxServices get instance => _instance ??= BoxServices._init();

  final box = GetStorage(BoxKeys.boxName);

  MyTheme get theme {
    String? title = box.read(BoxKeys.theme);
    return MyTheme.values.firstWhere(
      (element) => element.title == title,
      orElse: () => MyTheme.values.first,
    );
  }

  Future<void> saveTheme(MyTheme theme) async {
    await box.write(BoxKeys.theme, theme.title);
  }

  ThemeMode get themeMode {
    String? brightness = box.read(BoxKeys.themeMode);
    return ThemeMode.values.firstWhere(
      (element) => element.name == brightness,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    await box.write(BoxKeys.themeMode, mode.name);
  }

  MyLocale get locale {
    String? locale = box.read(BoxKeys.locale);
    return LocalizationsState.supportedLocales.firstWhere(
      (element) => element.locale.toLanguageTag() == locale,
      orElse: () => LocalizationsState.supportedLocales.first,
    );
  }

  Future<void> savelocale(MyLocale locale) async {
    await box.write(BoxKeys.locale, locale.locale.toLanguageTag());
  }

  Future<void> write(String key, dynamic value) async {
    await box.write(key, value);
  }

  T? read<T>(String key) => box.read<T>(key);

  Future<void> remove(String key) async => await box.remove(key);

  Future<void> clear() async => await box.erase();
}
