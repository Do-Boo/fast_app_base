import 'package:fast_app_base/screen/main/tab/tab_item.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  const TabNavigator({super.key, required this.tabItem, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: navigatorKey,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => tabItem.firstPage,
          );
        });
  }
}
