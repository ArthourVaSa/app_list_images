import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_omni_pro_app/src/presentation/screens/screens.dart';

class AppRouter {
  AppRouter();

  static const String splashScreen = '/';
  static const String homeScreen = '/home';

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
