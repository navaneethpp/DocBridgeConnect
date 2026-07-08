import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, this.width = 150});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/icons/app_icon.png',
      width: width,
    );
  }
}
