import 'package:after_layout/after_layout.dart';
import 'package:fast_app_base/common/dart/extension/num_duration_extension.dart';
import 'package:fast_app_base/common/util/provider_util.dart';
import 'package:fast_app_base/screen/main/tab/tab_item.dart';
import 'package:fast_app_base/screen/main/tab/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import '../../common/common.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  TabItem _currentTab = TabItem.roomFirst;
  final tabs = [TabItem.roomFirst, TabItem.roomSecond];
  final List<GlobalKey<NavigatorState>> navigatorKeys = [];

  int get _currentIndex => tabs.indexOf(_currentTab);

  GlobalKey<NavigatorState> get _currentTabNavigationKey => navigatorKeys[_currentIndex];

  bool get extendBody => true;

  static double get bottomNavigationBarBorderRadius => 0.0;

  @override
  void initState() {
    super.initState();
    initNavigatorKeys();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        extendBody: extendBody, //bottomNavigationBar 아래 영역 까지 그림
        body: Container(
          color: Vx.white,
          padding: EdgeInsets.only(bottom: extendBody ? 0 - bottomNavigationBarBorderRadius : 0),
          child: SafeArea(
            bottom: !extendBody,
            child: pages,
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  bool get isRootPage => _currentTab == TabItem.roomFirst && _currentTabNavigationKey.currentState?.canPop() == false;

  IndexedStack get pages => IndexedStack(
      index: _currentIndex,
      children: tabs
          .mapIndexed((tab, index) => Offstage(
                offstage: _currentTab != tab,
                child: TabNavigator(
                  navigatorKey: navigatorKeys[index],
                  tabItem: tab,
                ),
              ))
          .toList());

  // void _handleBackPressed(bool didPop) {
  //   if (!didPop) {
  //     if (_currentTabNavigationKey.currentState?.canPop() == true) {
  //       Nav.pop(_currentTabNavigationKey.currentContext!);
  //       return;
  //     }

  //     if (_currentTab != TabItem.roomFirst) {
  //       _changeTab(tabs.indexOf(TabItem.roomFirst));
  //     }
  //   }
  // }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Provider.of<ReservationAppBarLineProvider>(context).reservationAppbarLine ? Colors.grey.withOpacity(0.2) : Colors.transparent,
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: const Offset(0, -5), // changes position of shadow
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Vx.white,
        items: navigationBarItems(context),
        currentIndex: _currentIndex,
        selectedItemColor: context.appColors.text,
        unselectedItemColor: context.appColors.iconButtonInactivate,
        onTap: _handleOnTapNavigationBarItem,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  List<BottomNavigationBarItem> navigationBarItems(BuildContext context) {
    return tabs
        .mapIndexed(
          (tab, index) => tab.toNavigationBarItem(context, isActivated: _currentIndex == index),
        )
        .toList();
  }

  void _changeTab(int index) {
    setState(() {
      _currentTab = tabs[index];
    });
  }

  BottomNavigationBarItem bottomItem(bool activate, IconData iconData, IconData inActivateIconData, String label) {
    return BottomNavigationBarItem(
        icon: Icon(
          key: ValueKey(label),
          activate ? iconData : inActivateIconData,
          // color: activate ? const Color.fromARGB(255, 237, 107, 98) : Vx.gray200,
          color: activate ? context.appColors.iconButton : context.appColors.iconButtonInactivate,
        ),
        label: label);
  }

  void _handleOnTapNavigationBarItem(int index) {
    final oldTab = _currentTab;
    final targetTab = tabs[index];
    if (oldTab == targetTab) {
      final navigationKey = _currentTabNavigationKey;
      popAllHistory(navigationKey);
    }
    _changeTab(index);
  }

  void popAllHistory(GlobalKey<NavigatorState> navigationKey) {
    final bool canPop = navigationKey.currentState?.canPop() == true;
    if (canPop) {
      while (navigationKey.currentState?.canPop() == true) {
        navigationKey.currentState!.pop();
      }
    }
  }

  void initNavigatorKeys() {
    for (final _ in tabs) {
      navigatorKeys.add(GlobalKey<NavigatorState>());
    }
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    delay(() => FlutterNativeSplash.remove(), 1000.ms);
  }
}
