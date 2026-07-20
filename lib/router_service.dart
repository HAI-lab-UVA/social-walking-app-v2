import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:social_walking_2/repositories/auth_repository.dart';
import 'package:social_walking_2/views/auth_check/auth_check_screen.dart';
import 'package:social_walking_2/views/scaffold_with_nav_bar/cowalks/cowalks_screen.dart';
import 'package:social_walking_2/views/scaffold_with_nav_bar/home/home_screen.dart';
import 'package:social_walking_2/views/login/login_screen.dart';
import 'package:social_walking_2/views/onboarding/onboarding_screen.dart';
import 'package:social_walking_2/views/scaffold_with_nav_bar/scaffold_with_nav_bar.dart';
import 'package:social_walking_2/views/signup/signup_screen.dart';
import 'package:social_walking_2/views/welcome/welcome_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefreshStream(
      FirebaseAuth.instance.authStateChanges(),
    ), // referesh router on auth changes
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
      GoRoute(
        name: 'auth-check',
        path: '/auth-check',
        builder: (context, state) => AuthCheckScreen(),
      ),
      ShellRoute(
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
    redirect: (BuildContext context, GoRouterState state) {
      final userAuthorized = ref.read(authRepositoryProvider).isLoggedIn();
      final isAuthRoute =
          state.uri.path == '/' ||
          state.uri.path == '/login' ||
          state.uri.path == '/signup';

      if (!userAuthorized && !isAuthRoute) {
        return '/';
      }
      if (userAuthorized && isAuthRoute) {
        return '/auth-check';
      }
      return null;
    },
  );
});

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }
  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
