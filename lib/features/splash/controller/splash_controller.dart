import 'package:docbridgeconnect/core/theme/app_motion.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:docbridgeconnect/routes/route_names.dart';

class SplashController {
  SplashController(this.context);

  final BuildContext context;

  Future<void> initialize() async {
    // Keep the splash visible long enough for the full animation.
    await Future.delayed(AppMotion.splashDuration);

    if (!context.mounted) return;

    context.go(RouteNames.pairing);
  }
}
