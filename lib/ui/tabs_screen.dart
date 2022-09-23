import 'package:flutter/material.dart';
import 'package:quiz_u/core/index.dart';
import 'package:flutter_remix/flutter_remix.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({Key? key}) : super(key: key);

  static const List<AppTabItem> _tabs = [
    AppTabItem(
      label: 'Home',
      icon: FlutterRemix.home_6_line,
      route: HomeRoute(),
    ),
    AppTabItem(
      label: 'Leaderboard',
      icon: FlutterRemix.trophy_line,
      route: HomeRoute(),
    ),
    AppTabItem(
      label: 'Profile',
      icon: FlutterRemix.user_3_line,
      route: HomeRoute(),
    ),
  ];

  @override
  Widget build(context) {
    return AutoTabsScaffold(
      routes: _tabs.map((t) => t.route).toList(),
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: _tabs
              .map((t) => BottomNavigationBarItem(
                    label: t.label,
                    icon: Icon(t.icon),
                  ))
              .toList(),
        );
      },
    );
  }
}

class AppTabItem {
  const AppTabItem({
    required this.label,
    required this.icon,
    required this.route,
  });

  final String label;
  final IconData icon;
  final PageRouteInfo<dynamic> route;
}
