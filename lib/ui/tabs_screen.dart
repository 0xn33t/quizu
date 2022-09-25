import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:quiz_u/core/l10n/l10n.dart';
import 'package:quiz_u/core/routing/app_router.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({Key? key}) : super(key: key);

  static List<AppTabItem> _tabs(BuildContext context) => [
        AppTabItem(
          label: context.l10n.home,
          icon: FlutterRemix.home_6_line,
          route: const HomeRoute(),
        ),
        AppTabItem(
          label: context.l10n.leaderboard,
          icon: FlutterRemix.trophy_line,
          route: const LeaderboardRoute(),
        ),
        AppTabItem(
          label: context.l10n.profile,
          icon: FlutterRemix.user_3_line,
          route: const ProfileRoute(),
        ),
      ];

  @override
  Widget build(context) {
    final tabs = _tabs(context);
    return AutoTabsScaffold(
      routes: tabs.map((t) => t.route).toList(),
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: tabs
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
