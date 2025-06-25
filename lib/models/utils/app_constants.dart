import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppConstants {
  static const String appName = 'UIModeX';
  static const String fullAppName =
      'UIModeX — Flutter UI Mode & Localization Manager';
}

class BoxKeys {
  static const String boxName = 'UIModeX';
  static const String locale = 'locale';
  static const String theme = 'theme';
  static const String themeMode = 'theme-mode';
}

void logPrint(Object? object, [String? name]) {
  if (kReleaseMode) return;
  final log = object is String? ? object : object.toString();
  dev.log(log ?? 'null', name: (name ?? AppConstants.appName).toUpperCase());
}

void dprint(Object? object, {bool toString = true}) {
  if (kReleaseMode) return;
  final obj = toString ? object.toString() : object;
  final log = object is String? ? object : obj;
  // ignore: avoid_print
  print(log ?? 'null');
}

class MyColoredBox extends StatelessWidget {
  final Color? color;
  final Widget child;
  const MyColoredBox({super.key, this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(color: color ?? Colors.black12, child: child);
  }
}

showToast(String text, {int? timeInSec}) async {
  await Fluttertoast.cancel();
  Future.delayed(const Duration(milliseconds: 300)).then((_) {
    Fluttertoast.showToast(
      msg: text,
      timeInSecForIosWeb: timeInSec ?? 1,
      gravity: ToastGravity.SNACKBAR,
    );
  });
}
