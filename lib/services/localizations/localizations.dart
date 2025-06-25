import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import 'package:uimodex/services/box_services.dart';
import 'package:uimodex/services/localizations/languages/languages.dart';

class _AppLocals extends InheritedWidget {
  final LocalizationsState locals;
  const _AppLocals({required super.child, required this.locals});

  @override
  bool updateShouldNotify(covariant _AppLocals oldWidget) => true;
}

class Localizations extends StatefulWidget {
  final Widget child;
  const Localizations({super.key, required this.child});

  static LocalizationsState? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_AppLocals>()?.locals;
  }

  static LocalizationsState of(BuildContext context) {
    assert(maybeOf(context) != null, 'Localizations not found in context');
    return maybeOf(context)!;
  }

  @override
  State<Localizations> createState() => LocalizationsState();
}

class MyLocale {
  final Locale locale;
  final String title;
  MyLocale(this.locale, {required this.title});
}

class LocalizationsState extends State<Localizations> {
  late Languages _lang;
  Languages get lang => _lang;
  late MyLocale _locale;
  MyLocale get locale => _locale;

  static final Map<MyLocale, Languages> _supportedLocales = {
    MyLocale(Locale('en', 'US'), title: 'English'): LanguageEn(),
    MyLocale(Locale('pa', 'IN'), title: 'ਪੰਜਾਬੀ'): LanguagePa(),
  };

  static List<MyLocale> get supportedLocales {
    return _supportedLocales.keys.toList();
  }

  final box = BoxServices.instance;

  @override
  void initState() {
    super.initState();
    _locale = box.locale;
    _lang = _supportedLocales[locale]!;
  }

  void setLocale(MyLocale? locale) {
    if ((locale ?? _locale) == _locale) return;
    if (!_supportedLocales.keys.contains(locale)) return;
    _lang = _supportedLocales[locale]!;
    _locale = locale!;
    setState(() {});
    box.savelocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return _AppLocals(locals: this, child: widget.child);
  }
}

abstract class Languages {
  static Languages? of(BuildContext context) {
    return material.Localizations.of<Languages>(context, Languages);
  }

  String get appName;
  String get appInfo;

  String get home;
  String get messages;
  String get settings;
  String get themes;
  String get themeColors;
  String get themeModes;
  String get changeTheme;
  String get changeLang;
  String get selectlanguage;
  String get about;
  String get areyousure;
  String get errorUnknown;
  String get confirm;
  String get cancel;
  String get close;

  // long texts
  String get switchLangDesc;
}
