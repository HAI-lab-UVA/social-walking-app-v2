import 'package:go_router/go_router.dart';
import 'package:social_walking_2/views/login/login_screen.dart';
import 'package:social_walking_2/views/welcome/welcome_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => WelcomeScreen(),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
  ],
);
