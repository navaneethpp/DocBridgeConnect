import 'package:docbridgeconnect/core/constants/app_assets.dart';
import 'package:docbridgeconnect/core/constants/hero_tags.dart';
import 'package:docbridgeconnect/core/theme/app_colors.dart';
import 'package:docbridgeconnect/core/theme/app_motion.dart';
import 'package:flutter/material.dart';

class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({super.key, this.size = 190});

  final double size;

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _floatingController;

  late final Animation<double> _opacity;
  late final Animation<double> _scale;
  late final Animation<double> _floating;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: AppMotion.splashEntrance,
    );

    _floatingController = AnimationController(
      vsync: this,
      duration: AppMotion.floating,
    );

    _opacity = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    );

    _scale = Tween(begin: .88, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: Curves.easeOutBack,
      ),
    );

    _floating = Tween(begin: -4.0, end: 4.0).animate(
      CurvedAnimation(
        parent: _floatingController,
        curve: Curves.easeInOut,
      ),
    );

    _entranceController.forward();

    _floatingController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _entranceController,
        _floatingController,
      ]),
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.translate(
            offset: Offset(0, _floating.value),
            child: Transform.scale(
              scale: _scale.value,
              child: child,
            ),
          ),
        );
      },
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Blue Glow
            Container(
              width: widget.size * .95,
              height: widget.size * .95,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withValues(
                      alpha: .10,
                    ),
                    blurRadius: 80,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),

            // Mint Glow
            Transform.translate(
              offset: const Offset(18, 18),
              child: Container(
                width: widget.size * .60,
                height: widget.size * .60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(
                        alpha: .18,
                      ),
                      blurRadius: 70,
                      spreadRadius: 6,
                    ),
                  ],
                ),
              ),
            ),

            // Logo Shadow
            Transform.translate(
              offset: const Offset(0, 18),
              child: SizedBox(
                width: widget.size * .60,
                height: 18,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      100,
                    ),
                    color: AppColors.black.withValues(
                      alpha: .08,
                    ),
                  ),
                ),
              ),
            ),

            // Logo
            RepaintBoundary(
              child: Hero(
                tag: HeroTags.appLogo,
                child: Image.asset(
                  AppAssets.appIconDark,
                  width: widget.size,
                  height: widget.size,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
