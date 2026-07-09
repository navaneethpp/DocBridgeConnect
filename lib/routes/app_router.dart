import 'package:docbridgeconnect/features/dashboard/presentation/dashboard.dart';
import 'package:docbridgeconnect/features/splash/presentation/splash_screen.dart';
import 'package:docbridgeconnect/routes/route_names.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.splash,

  routes: [
    GoRoute(
      path: RouteNames.splash,
      builder: (context, state) => const Splashscreen(),
    ),
    GoRoute(
      path: RouteNames.dashboard,
      builder: (context, state) => const Dashboard(),
    ),
  ],
);
