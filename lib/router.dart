import 'package:go_router/go_router.dart';
import 'package:social_walking_2/views/welcome/welcome_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => WelcomeScreen(),
    ),
    // GoRoute(
    //   name: 'page2',
    //   path: '/page2',
    //   builder: (context, state) => Page2Screen(),
    // ),
  ],
);
