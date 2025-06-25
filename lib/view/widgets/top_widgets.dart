import 'package:flutter/material.dart';
import 'package:uimodex/models/utils/dimens.dart';
import 'package:uimodex/models/utils/utils.dart';
import 'package:uimodex/services/extension_services.dart';

class MyDivider extends StatelessWidget {
  final double? width;
  final double? thickness;
  final double? margin;
  const MyDivider({super.key, this.width, this.thickness, this.margin});

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;
    return Container(
      width: width,
      margin: Utils.paddingHoriz(margin ?? 0),
      child: Divider(color: scheme.backgroundDark, thickness: thickness),
    );
  }
}

class SafeCardView extends StatelessWidget {
  final Color? bgColor;
  final EdgeInsets? safeArea;
  final EdgeInsets? margin;
  final double? height;
  final BorderRadius? borderRadius;
  final Widget child;
  const SafeCardView({
    super.key,
    this.safeArea,
    this.bgColor,
    this.margin,
    this.height,
    this.borderRadius,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: safeArea ?? EdgeInsets.zero,
      child: Card(
        margin: margin,
        color: bgColor,
        elevation: Dimens.sizeDefault,
        shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.zero),
        child: SizedBox(
          height: height,
          child: ClipRRect(
              borderRadius: borderRadius ?? BorderRadius.zero, child: child),
        ),
      ),
    );
  }
}
