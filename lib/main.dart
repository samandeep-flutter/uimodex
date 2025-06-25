import 'package:flutter/material.dart' hide Localizations;
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uimodex/services/extension_services.dart';
import 'package:uimodex/services/localizations/localizations.dart';
import 'package:uimodex/view_models/routes/app_pages.dart';
import 'package:uimodex/models/utils/app_constants.dart';
import 'package:uimodex/services/theme_services.dart' show ThemeServices;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initServices();
  runApp(const ThemeServices(child: Localizations(child: MyApp())));
}

Future<void> _initServices() async {
  dprint('initServices started...');
  try {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    await GetStorage.init(BoxKeys.boxName);
  } catch (e) {
    logPrint(e, 'init');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = LocalizationsState.supportedLocales;
    final scheme = context.scheme;

    return MaterialApp(
      title: AppConstants.fullAppName,
      debugShowCheckedModeBanner: false,
      routes: AppPages.routes,
      initialRoute: AppPages.initial,
      locale: context.localDelegates.locale.locale,
      supportedLocales: locale.map((e) => e.locale),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (final supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: scheme.primary,
          onPrimary: scheme.onPrimary,
          seedColor: scheme.primary,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      themeMode: scheme.themeMode,
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: scheme.primary,
          onPrimary: scheme.onPrimary,
          seedColor: scheme.primary,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
    );
  }
}
