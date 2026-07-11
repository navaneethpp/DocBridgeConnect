import 'package:docbridgeconnect/features/pairing/screens/pairing_screen.dart';
import 'package:docbridgeconnect/features/splash/screens/splash_screen.dart';
import 'package:docbridgeconnect/routes/route_names.dart';

import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static final router = GoRouter(
    initialLocation: RouteNames.splash,

    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (_, _) => const SplashScreen(),
      ),

      GoRoute(
        path: RouteNames.pairing,
        builder: (_, _) => const PairingScreen(),
      ),
    ],
  );
}
