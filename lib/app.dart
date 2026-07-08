import 'package:docbridgeconnect/core/theme/app_theme.dart';
import 'package:docbridgeconnect/features/splash/presentation/splash_screen.dart';

import 'package:flutter/material.dart';

class DocBridgeApp extends StatelessWidget {
  const DocBridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'DocBridge',

      theme: AppTheme.dark,

      home: const Splashscreen(),
    );
  }
}
