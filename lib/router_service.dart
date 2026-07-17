import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:social_walking_2/views/scaffold_with_nav_bar/cowalks/cowalks_screen.dart';
import 'package:social_walking_2/views/scaffold_with_nav_bar/home/home_screen.dart';
import 'package:social_walking_2/views/login/login_screen.dart';
import 'package:social_walking_2/views/onboarding/onboarding_screen.dart';
import 'package:social_walking_2/views/scaffold_with_nav_bar/scaffold_with_nav_bar.dart';
import 'package:social_walking_2/views/signup/signup_screen.dart';
import 'package:social_walking_2/views/welcome/welcome_screen.dart';

class RouterService {
  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>();
  late GoRouter router;

  RouterService() {
    router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: '/',
      routes: [
        GoRoute(
          name: 'welcome',
          path: '/',
          builder: (context, state) => WelcomeScreen(),
        ),
        GoRoute(
          name: 'login',
          path: '/login',
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          name: 'signup',
          path: '/signup',
          builder: (context, state) => SignupScreen(),
        ),
        GoRoute(
          name: 'onboarding',
          path: '/onboarding',
          builder: (context, state) => OnboadingScreen(),
        ),
        ShellRoute(
          navigatorKey: shellNavigatorKey,
          builder: (context, state, child) {
            return ScaffoldWithNavBar(child: child);
          },
          routes: [
            GoRoute(
              name: 'home',
              path: '/home',
              builder: (context, state) {
                return HomeScreen();
              },
            ),
            GoRoute(
              name: 'cowalks',
              path: '/cowalks',
              builder: (context, state) {
                return CowalksScreen();
              },
            ),
          ],
        ),
      ],
      // TODO: check if user exists too
      redirect: (BuildContext context, GoRouterState state) async {
        final currentUser = FirebaseAuth.instance.currentUser;
        final bool loggedIn = currentUser != null;
        final isAuthRoute =
            state.uri.path == '/' ||
            state.uri.path == '/login' ||
            state.uri.path == '/signup';

        if (!loggedIn && state.uri.path == '/onboarding') {
          return '/onboarding';
        } else if (!loggedIn && !isAuthRoute) {
          return '/';
        }
        if (loggedIn && isAuthRoute) {
          return '/home';
        }
        return null;
      },
    );
  }
}
