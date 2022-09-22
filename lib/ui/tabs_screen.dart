import 'package:flutter/material.dart';
import 'package:quiz_u/core/index.dart';
import 'package:flutter_remix/flutter_remix.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        HomeRoute(),
        HomeRoute(),
        HomeRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(
                label: 'Home', icon: Icon(FlutterRemix.home_6_line)),
            BottomNavigationBarItem(
                label: 'Home', icon: Icon(FlutterRemix.home_6_line)),
            BottomNavigationBarItem(
                label: 'Home', icon: Icon(FlutterRemix.home_6_line)),
            BottomNavigationBarItem(
                label: 'Home', icon: Icon(FlutterRemix.home_6_line)),
          ],
        );
      },
    );
  }
}
