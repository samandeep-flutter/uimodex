import 'package:flutter/material.dart';
import 'package:uimodex/models/utils/dimens.dart';
import 'package:uimodex/services/extension_services.dart';
import 'package:uimodex/services/localizations/localizations.dart';
import 'package:uimodex/view/widgets/base_widget.dart';
import 'package:uimodex/view/widgets/my_alert_dialog.dart';
import 'package:uimodex/view/widgets/top_widgets.dart';
import 'package:uimodex/view_models/routes/app_routes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;
    final locale = context.locale;

    return BaseWidget(
      appBar: AppBar(
        backgroundColor: scheme.background,
        toolbarHeight: Dimens.sizeLarge,
      ),
      child: ListView(
        children: [
          const SizedBox(height: Dimens.sizeDefault),
          Row(
            children: [
              Builder(builder: (context) {
                final radius = context.width * .1;
                return CircleAvatar(
                    radius: radius,
                    backgroundColor: scheme.backgroundDark,
                    child: Icon(Icons.person,
                        size: radius, color: scheme.textColor));
              }),
              const SizedBox(width: Dimens.sizeLarge),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Doe',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: scheme.textColor,
                        fontSize: Dimens.fontExtraDoubleLarge),
                  ),
                  const SizedBox(height: Dimens.sizeSmall),
                  Text(
                    'john.doe@me.com',
                    style: TextStyle(color: scheme.textColorLight),
                  )
                ],
              ))
            ],
          ),
          const SizedBox(height: Dimens.sizeLarge),
          Card(
            color: scheme.surface,
            child: Column(
              children: [
                const SizedBox(height: Dimens.sizeSmall),
                ListTile(
                  iconColor: scheme.textColor,
                  textColor: scheme.textColor,
                  onTap: () => context.toNamed(AppRoutes.THEME),
                  leading: Icon(Icons.color_lens_outlined),
                  title: Text(locale.themes),
                ),
                MyDivider(margin: Dimens.sizeSmall),
                ListTile(
                  iconColor: scheme.textColor,
                  textColor: scheme.textColor,
                  onTap: _onLanguageSwitch,
                  leading: Icon(Icons.language_outlined),
                  title: Text(locale.changeLang),
                ),
                const SizedBox(height: Dimens.sizeSmall),
              ],
            ),
          ),
          const SizedBox(height: Dimens.sizeLarge),
          ListTile(
            onTap: _aboutUs,
            iconColor: scheme.textColor,
            textColor: scheme.textColor,
            leading: Icon(Icons.info_outlined),
            title: Text(locale.about),
          ),
        ],
      ),
    );
  }

  void _onLanguageSwitch() {
    showModalBottomSheet(
        context: context,
        useSafeArea: true,
        showDragHandle: true,
        backgroundColor: context.scheme.background,
        builder: (context) {
          return MyBottomSheet(
              title: context.locale.selectlanguage,
              vsync: this,
              child: Column(
                children: [
                  ...LocalizationsState.supportedLocales.map((e) {
                    return RadioListTile(
                      value: e,
                      groupValue: context.localDelegates.locale,
                      onChanged: _confirmSwitch,
                      title: Row(
                        children: [
                          Text(
                            e.title,
                            style: TextStyle(color: context.scheme.textColor),
                          ),
                          const Spacer(),
                          Builder(builder: (context) {
                            final lanCode = e.locale.languageCode.toUpperCase();
                            final countCode =
                                e.locale.countryCode?.toUpperCase();
                            return Text(
                              '$lanCode-${countCode ?? ''}',
                              style: TextStyle(
                                color: context.scheme.textColorLight,
                                fontSize: Dimens.fontDefault,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          })
                        ],
                      ),
                    );
                  }),
                  const SafeArea(child: SizedBox(height: Dimens.sizeLarge))
                ],
              ));
        });
  }

  void _confirmSwitch(MyLocale? locale) {
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertDialog(
            title: context.locale.areyousure,
            content: Text(
              context.locale.switchLangDesc,
              style: TextStyle(color: context.scheme.textColor),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  context.close(2);
                  context.localDelegates.setLocale(locale);
                },
                child: Text(context.locale.confirm.toUpperCase()),
              ),
              ElevatedButton(
                onPressed: context.pop,
                style: ElevatedButton.styleFrom(
                    backgroundColor: context.scheme.primary,
                    foregroundColor: context.scheme.onPrimary,
                    visualDensity: VisualDensity.compact),
                child: Text(context.locale.cancel),
              )
            ],
          );
        });
  }

  void _aboutUs() {
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertDialog(
            title: context.locale.appName,
            content: Text(context.locale.appInfo),
            actions: [
              TextButton(
                onPressed: context.pop,
                child: Text(context.locale.close),
              )
            ],
          );
        });
  }
}
