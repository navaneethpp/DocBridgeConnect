import 'dart:math' as math;
//import 'package:docbridgeconnectƶ/core/theme/app_colors.dart';
import 'package:docbridgeconnect/core/theme/app_motion.dart';
import 'package:docbridgeconnect/features/pairing/models/pairing_status.dart';
import 'package:flutter/material.dart';

class PairingStatusIndicator extends StatelessWidget {
  const PairingStatusIndicator({
    super.key,
    required this.config,
    this.size = 20.0,
  });

  final PairingStatusConfig config;
  final double size;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: AppMotion.normal,
      switchInCurve: AppMotion.curve,
      switchOutCurve: AppMotion.curve,
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: KeyedSubtree(
        key: ValueKey(config.animationType),
        child: _buildIndicator(context),
      ),
    );
  }

  Widget _buildIndicator(BuildContext context) {
    switch (config.animationType) {
      case StatusAnimationType.breathingDot:
        return _BreathingDot(
          color: config.iconColor,
          size: size,
        );

      case StatusAnimationType.rotatingSync:
        return _RotatingSyncIcon(
          color: config.iconColor,
          size: size,
        );

      case StatusAnimationType.progress:
        return _ProgressDots(
          color: config.iconColor,
          size: size,
        );

      case StatusAnimationType.successCheck:
        return _SuccessCheck(
          color: config.iconColor,
          size: size,
        );

      case StatusAnimationType.shakeError:
      case StatusAnimationType.timeoutError:
        return _ShakeIcon(
          icon: config.icon,
          color: config.iconColor,
          size: size,
        );

      case StatusAnimationType.warningIcon:
        return _WarningPulse(
          icon: config.icon,
          color: config.iconColor,
          size: size,
        );
    }
  }
}

/// Subtle breathing animation on status indicator green dot.
class _BreathingDot extends StatefulWidget {
  const _BreathingDot({
    required this.color,
    required this.size,
  });

  final Color color;
  final double size;

  @override
  State<_BreathingDot> createState() =>
      _BreathingDotState();
}

class _BreathingDotState extends State<_BreathingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.15)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut,
          ),
        );

    _opacityAnimation = Tween<double>(begin: 0.4, end: 0.95)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width:
                  widget.size * 1.5 * _scaleAnimation.value,
              height:
                  widget.size * 1.5 * _scaleAnimation.value,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color.withValues(
                  alpha: 0.25 * _opacityAnimation.value,
                ),
              ),
            ),
            Container(
              width: widget.size * 0.65,
              height: widget.size * 0.65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color,
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withValues(
                      alpha: 0.6 * _opacityAnimation.value,
                    ),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Rotating sync icon while searching.
class _RotatingSyncIcon extends StatefulWidget {
  const _RotatingSyncIcon({
    required this.color,
    required this.size,
  });

  final Color color;
  final double size;

  @override
  State<_RotatingSyncIcon> createState() =>
      _RotatingSyncIconState();
}

class _RotatingSyncIconState
    extends State<_RotatingSyncIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Icon(
        Icons.sync_rounded,
        color: widget.color,
        size: widget.size,
      ),
    );
  }
}

/// Animated three dots indicator for Searching / Connecting.
class _ProgressDots extends StatefulWidget {
  const _ProgressDots({
    required this.color,
    required this.size,
  });

  final Color color;
  final double size;

  @override
  State<_ProgressDots> createState() =>
      _ProgressDotsState();
}

class _ProgressDotsState extends State<_ProgressDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            final delay = index * 0.2;
            final progress =
                (_controller.value - delay) % 1.0;
            final opacity =
                (math.sin(progress * math.pi * 2) + 1) / 2;

            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 2,
              ),
              width: widget.size * 0.35,
              height: widget.size * 0.35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color.withValues(
                  alpha: 0.3 + (0.7 * opacity),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

/// Green check animation with scale and glow ring.
class _SuccessCheck extends StatefulWidget {
  const _SuccessCheck({
    required this.color,
    required this.size,
  });

  final Color color;
  final double size;

  @override
  State<_SuccessCheck> createState() =>
      _SuccessCheckState();
}

class _SuccessCheckState extends State<_SuccessCheck>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppMotion.slow,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: widget.color.withValues(alpha: 0.4),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(
          Icons.check_circle_rounded,
          color: widget.color,
          size: widget.size,
        ),
      ),
    );
  }
}

/// Shake animation on error states.
class _ShakeIcon extends StatefulWidget {
  const _ShakeIcon({
    required this.icon,
    required this.color,
    required this.size,
  });

  final IconData icon;
  final Color color;
  final double size;

  @override
  State<_ShakeIcon> createState() => _ShakeIconState();
}

class _ShakeIconState extends State<_ShakeIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final offset =
            math.sin(_controller.value * math.pi * 4) * 6;
        return Transform.translate(
          offset: Offset(offset, 0),
          child: Icon(
            widget.icon,
            color: widget.color,
            size: widget.size,
          ),
        );
      },
    );
  }
}

/// Amber warning pulse animation for Connection Lost.
class _WarningPulse extends StatefulWidget {
  const _WarningPulse({
    required this.icon,
    required this.color,
    required this.size,
  });

  final IconData icon;
  final Color color;
  final double size;

  @override
  State<_WarningPulse> createState() =>
      _WarningPulseState();
}

class _WarningPulseState extends State<_WarningPulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.1)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Icon(
        widget.icon,
        color: widget.color,
        size: widget.size,
      ),
    );
  }
}
