import 'package:go_router/go_router.dart';
import 'package:resultnomad/features/auth/views/login_screen.dart';
import 'package:resultnomad/features/auth/views/signup_screen.dart';
import 'package:resultnomad/features/main_navigation/views/main_navigation_screen.dart';

final router = GoRouter(
  initialLocation: '/list',
  routes: [
    GoRoute(
      path: "/:tab(list|write)",
      builder: (context, state) {
        final tab = state.params['tab']!;
        return MainNavigationScreen(
          tab: tab,
        );
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
  ],
);
