import 'package:flutter/material.dart';

class GlassEffect {
  GlassEffect._();

  static BoxDecoration decoration() {
    return BoxDecoration(
      color: Colors.white.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.1),
      ),
    );
  }
}
