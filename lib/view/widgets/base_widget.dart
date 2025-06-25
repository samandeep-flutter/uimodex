import 'package:flutter/material.dart';
import 'package:uimodex/models/utils/dimens.dart';
import 'package:uimodex/models/utils/utils.dart';
import 'package:uimodex/services/extension_services.dart';

class BaseWidget extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final BoxDecoration? decoration;
  final Widget? bottom;
  final bool? extendBody;
  final Widget? child;
  final bool? resizeBottom;
  final bool safeAreaBottom;

  const BaseWidget({
    super.key,
    this.appBar,
    this.padding,
    this.margin,
    this.color,
    this.decoration,
    this.bottom,
    this.extendBody,
    this.resizeBottom,
    this.safeAreaBottom = false,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;
    final defPadding = Utils.paddingHoriz(Dimens.sizeLarge);

    return Scaffold(
      appBar: appBar,
      resizeToAvoidBottomInset: resizeBottom,
      backgroundColor: color ?? scheme.background,
      bottomNavigationBar: bottom,
      extendBody: extendBody ?? false,
      body: Container(
        decoration: decoration,
        child: SafeArea(
          bottom: safeAreaBottom,
          child: Container(
            margin: margin,
            padding: padding ?? defPadding,
            child: child,
          ),
        ),
      ),
    );
  }
}
