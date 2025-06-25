import 'package:flutter/material.dart';
import 'package:uimodex/models/utils/dimens.dart';
import 'package:uimodex/models/utils/utils.dart';
import 'package:uimodex/services/box_services.dart';
import 'package:uimodex/services/extension_services.dart';
import 'package:uimodex/services/theme_services.dart';
import 'package:uimodex/view/widgets/base_widget.dart';

class ChangeTheme extends StatefulWidget {
  const ChangeTheme({super.key});

  @override
  State<ChangeTheme> createState() => _ChangeThemeState();
}

class _ChangeThemeState extends State<ChangeTheme> {
  final box = BoxServices.instance;

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;

    return BaseWidget(
      appBar: AppBar(
        backgroundColor: scheme.background,
        title: Text(context.locale.changeTheme),
        titleTextStyle: Utils.defTitleStyle(context),
        centerTitle: false,
      ),
      child: ListView(
        children: [
          const SizedBox(height: Dimens.sizeDefault),
          Text(context.locale.themeColors,
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: Dimens.fontLarge)),
          const SizedBox(height: Dimens.sizeSmall),
          Card(
            color: scheme.surface,
            child: Column(
              children: [
                const SizedBox(height: Dimens.sizeSmall),
                ...MyTheme.values.map((e) {
                  return RadioListTile<MyTheme>(
                    value: e,
                    groupValue: box.theme,
                    activeColor: scheme.primary,
                    onChanged: context.scheme.changeTheme,
                    title: Row(
                      children: [
                        Text(
                          e.title,
                          style: TextStyle(
                            fontSize: Dimens.fontLarge,
                            color: scheme.textColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        CircleAvatar(
                          backgroundColor: scheme.backgroundDark,
                          radius: Dimens.sizeDefault,
                          child: Container(
                            margin: EdgeInsets.all(Dimens.sizeExtraSmall),
                            decoration: BoxDecoration(
                                color: e.primary, shape: BoxShape.circle),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: Dimens.sizeSmall),
              ],
            ),
          ),
          const SizedBox(height: Dimens.sizeLarge),
          Text(context.locale.themeModes,
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: Dimens.fontLarge)),
          const SizedBox(height: Dimens.sizeSmall),
          Card(
            color: scheme.surface,
            child: Column(
              children: [
                const SizedBox(height: Dimens.sizeSmall),
                ...ThemeMode.values.map((e) {
                  return RadioListTile<ThemeMode>(
                    value: e,
                    groupValue: box.themeMode,
                    activeColor: scheme.primary,
                    onChanged: context.scheme.switchThemeMode,
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Text(
                      e.name.capitalize,
                      style: TextStyle(
                        fontSize: Dimens.fontLarge,
                        color: scheme.textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }),
                const SizedBox(height: Dimens.sizeSmall),
              ],
            ),
          )
        ],
      ),
    );
  }
}
