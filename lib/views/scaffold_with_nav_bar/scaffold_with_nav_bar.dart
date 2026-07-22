import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_walking_2/ui/sw_color.dart';

class ScaffoldWithNavBar extends StatefulWidget {
  const ScaffoldWithNavBar({super.key, required this.child});
  final Widget child;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  final routes = ["/home", "/cowalks", "/journal", "/profile"];
  final routeNames = ["Home", "Co-Walks", "Journal", "Profile"];
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: SWColor.white,
        overlayColor: WidgetStateProperty.all(SWColor.grayLight),
        shadowColor: SWColor.grayLight,
        indicatorColor: SWColor.grayLight,
        surfaceTintColor: SWColor.grayLight,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
          context.go(routes[index]);
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.directions_walk_rounded),
            label: 'Co-Walks',
          ),
          NavigationDestination(
            icon: Icon(Icons.book_outlined),
            selectedIcon: Icon(Icons.book),
            label: 'Journal',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: widget.child,
    );
  }
}
