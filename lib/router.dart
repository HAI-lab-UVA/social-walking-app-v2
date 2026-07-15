import 'package:go_router/go_router.dart';
import 'package:social_walking_2/views/home/home_screen.dart';
import 'package:social_walking_2/views/login/login_screen.dart';
import 'package:social_walking_2/views/onboarding/onboarding_screen.dart';
import 'package:social_walking_2/views/welcome/welcome_screen.dart';

final router = GoRouter(
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
      name: 'onboarding',
      path: '/onboarding',
      builder: (context, state) => OnboadingScreen(),
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => HomeScreen(),
    ),
  ],
);
