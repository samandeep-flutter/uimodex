import 'package:flutter/material.dart';
import 'package:uimodex/models/utils/dimens.dart';
import 'package:uimodex/models/utils/utils.dart';
import 'package:uimodex/services/extension_services.dart';
import 'package:uimodex/view/settings_screen.dart';
import 'package:uimodex/view/widgets/base_widget.dart';
import 'package:uimodex/view/widgets/top_widgets.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> with TickerProviderStateMixin {
  late TabController _controller;
  int _index = 2;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    _controller.index = _index;
    super.initState();
  }

  void changeIndex(int index) {
    if (index == _index) return;
    _index = index;
    _controller.index = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;

    return BaseWidget(
      padding: EdgeInsets.zero,
      bottom: SafeCardView(
        bgColor: scheme.surface,
        height: kToolbarHeight + Dimens.sizeSmall,
        safeArea: EdgeInsets.all(Dimens.sizeDefault),
        margin: EdgeInsets.only(bottom: Dimens.sizeSmall),
        child: BottomNavigationBar(
          iconSize: Dimens.sizeMidLarge,
          backgroundColor: Colors.transparent,
          elevation: Dimens.zero,
          currentIndex: _index,
          onTap: changeIndex,
          selectedItemColor: scheme.primary,
          unselectedItemColor: scheme.disabled,
          items: List.from(
            navBarItems.map((e) {
              return BottomNavigationBarItem(
                  icon: e.icon, activeIcon: e.activeIcon, label: e.label ?? '');
            }),
          ),
        ),
      ),
      extendBody: true,
      child: TabBarView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(navBarItems.length, (i) {
          if (i == 2) return const SettingsScreen();
          return BaseWidget(
            appBar: AppBar(
              backgroundColor: scheme.background,
              title: Builder(builder: (context) {
                if (i == 0) return Text(context.locale.appName);
                return Text(navBarItems[i].label ?? '');
              }),
              titleTextStyle: Utils.defTitleStyle(context),
              centerTitle: false,
            ),
            child: Center(
                child: Text(
              navBarItems[i].label ?? '',
              style: TextStyle(color: scheme.textColor),
            )),
          );
        }),
      ),
    );
  }

  List<NavBarItem> get navBarItems => [
        NavBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: context.locale.home,
        ),
        NavBarItem(
          icon: Icon(Icons.message_outlined),
          activeIcon: Icon(Icons.message),
          label: context.locale.messages,
        ),
        NavBarItem(
          icon: Icon(Icons.settings_outlined),
          activeIcon: Icon(Icons.settings),
          label: context.locale.settings,
        ),
      ];
}

class NavBarItem {
  final Widget icon;
  final Widget? activeIcon;
  final String? label;

  NavBarItem({required this.icon, this.activeIcon, this.label});
}
