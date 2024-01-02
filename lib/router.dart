import 'package:go_router/go_router.dart';
import 'package:resultnomad/features/auth/views/login_screen.dart';
import 'package:resultnomad/features/main_navigation/views/main_navigation_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainNavigationScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);
