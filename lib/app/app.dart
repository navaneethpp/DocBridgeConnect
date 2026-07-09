import 'package:docbridgeconnect/core/theme/app_theme.dart';
import 'package:docbridgeconnect/app/app_router.dart';

import 'package:flutter/material.dart';

class DocBridgeApp extends StatelessWidget {
  const DocBridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      title: 'DocBridge Connect',

      theme: AppTheme.dark,

      routerConfig: appRouter,
    );
  }
}
