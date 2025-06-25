import 'package:flutter/material.dart';
import 'package:uimodex/models/utils/dimens.dart';
import 'package:uimodex/models/utils/utils.dart';
import 'package:uimodex/services/extension_services.dart';
import 'top_widgets.dart';

class MyAlertDialog extends StatelessWidget {
  final String title;
  final TextStyle? titleTextStyle;
  final Widget? content;
  final List<Widget>? actions;
  final EdgeInsets? actionPadding;
  final EdgeInsets? insetsPadding;

  const MyAlertDialog({
    super.key,
    required this.title,
    this.content,
    this.actions,
    this.insetsPadding,
    this.actionPadding,
    this.titleTextStyle,
  });
  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;

    return AlertDialog(
      backgroundColor: scheme.surface,
      title: Text(title, style: TextStyle(color: scheme.textColor)),
      titleTextStyle: titleTextStyle,
      content: content,
      shape: Utils.roundedRectangle(Dimens.borderDefault),
      buttonPadding: const EdgeInsets.only(right: Dimens.sizeDefault),
      insetPadding: insetsPadding,
      actionsPadding: actionPadding,
      actions: actions,
    );
  }
}

class MyBottomSheet extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final double? bottomPadding;
  final TickerProvider vsync;
  final VoidCallback? onClose;
  final Widget child;

  const MyBottomSheet({
    super.key,
    required this.title,
    required this.vsync,
    this.onClose,
    this.bottomPadding,
    this.isExpanded = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;

    return BottomSheet(
      onClosing: () {},
      backgroundColor: context.scheme.background,
      animationController: BottomSheet.createAnimationController(vsync),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onClose?.call();
                      },
                      style: TextButton.styleFrom(
                          visualDensity: VisualDensity.compact),
                      child: Text(
                        context.locale.close,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: Dimens.sizeDefault),
                  ],
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: Dimens.fontExtraLarge,
                      fontWeight: FontWeight.w600,
                      color: scheme.textColor),
                ),
              ],
            ),
            const SizedBox(height: Dimens.sizeSmall),
            const MyDivider(),
            const SizedBox(height: Dimens.sizeDefault),
            if (isExpanded) Expanded(child: child) else child,
            SafeArea(child: SizedBox(height: bottomPadding)),
          ],
        );
      },
    );
  }
}
