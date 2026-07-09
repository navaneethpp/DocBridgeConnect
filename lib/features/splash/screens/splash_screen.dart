import 'package:docbridgeconnect/features/splash/widgets/splash_background.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashBackground(
      child: const Center(child: Text('DocBridge Connect')),
    );
  }
}
