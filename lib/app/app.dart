import 'package:docbridgeconnect/core/theme/app_theme.dart';
import 'package:docbridgeconnect/app/app_router.dart';

import 'package:flutter/material.dart';

class DocBridgeConnect extends StatelessWidget {
  const DocBridgeConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      title: 'DocBridge Connect',

      routerConfig: AppRouter.router,

      theme: AppTheme.dark,
    );
  }
}
