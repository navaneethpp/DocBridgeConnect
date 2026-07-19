import 'package:docbridgeconnect/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Visual overlay drawn on top of the QR camera preview.
///
/// Renders a semi-transparent dark scrim over the entire frame, with a
/// transparent square cut-out in the centre framed by four rounded corner
/// indicators.
///
/// This widget is purely decorative — it does NOT handle permissions, camera
/// access, QR detection, or navigation.
///
/// Usage:
/// ```dart
/// Stack(
///   children: [
///     MobileScanner(...),
///     IgnorePointer(child: QrOverlay(scanAreaSize: 260)),
///   ],
/// )
/// ```
class QrOverlay extends StatelessWidget {
  const QrOverlay({super.key, this.scanAreaSize = 220});

  /// Side length (in logical pixels) of the transparent scanning square.
  final double scanAreaSize;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      // Fill the entire parent space.
      size: Size.infinite,
      painter: _QrOverlayPainter(
        scanAreaSize: scanAreaSize,
        // Scrim colour: near-black at 60 % opacity.
        scrimColor: AppColors.black.withValues(alpha: 0.60),
        // Corner indicator colour follows the app primary brand colour.
        cornerColor: AppColors.primary,
      ),
    );
  }
}

// ─── Painter ──────────────────────────────────────────────────────────────────

class _QrOverlayPainter extends CustomPainter {
  const _QrOverlayPainter({
    required this.scanAreaSize,
    required this.scrimColor,
    required this.cornerColor,
  });

  final double scanAreaSize;
  final Color scrimColor;
  final Color cornerColor;

  // Visual constants for the corner indicators.
  static const double _cornerLength = 28;
  static const double _cornerStrokeWidth = 3.5;
  static const double _cornerRadius = 6;

  @override
  void paint(Canvas canvas, Size size) {
    // Centre of the available area.
    final centre = Offset(size.width / 2, size.height / 2);
    final half = scanAreaSize / 2;

    // Rectangle that represents the transparent scan area.
    final scanRect = Rect.fromCenter(
      center: centre,
      width: scanAreaSize,
      height: scanAreaSize,
    );

    // ── Scrim ─────────────────────────────────────────────────────────────
    // Draw the full-frame overlay using the "evenOdd" fill-type so that
    // the inner scan rect becomes a transparent hole.
    final scrimPath = Path()
      ..fillType = PathFillType.evenOdd
      // Outer rect covers the whole canvas.
      ..addRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
      )
      // Inner rect is the cut-out — rendered transparent due to evenOdd.
      ..addRRect(
        RRect.fromRectAndRadius(
          scanRect,
          const Radius.circular(_cornerRadius),
        ),
      );

    canvas.drawPath(
      scrimPath,
      Paint()
        ..color = scrimColor
        ..style = PaintingStyle.fill,
    );

    // ── Corner indicators ─────────────────────────────────────────────────
    final cornerPaint = Paint()
      ..color = cornerColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = _cornerStrokeWidth
      ..strokeCap = StrokeCap.round;

    // Top-left
    _drawCorner(
      canvas,
      cornerPaint,
      x: centre.dx - half,
      y: centre.dy - half,
      flipX: false,
      flipY: false,
    );

    // Top-right
    _drawCorner(
      canvas,
      cornerPaint,
      x: centre.dx + half,
      y: centre.dy - half,
      flipX: true,
      flipY: false,
    );

    // Bottom-left
    _drawCorner(
      canvas,
      cornerPaint,
      x: centre.dx - half,
      y: centre.dy + half,
      flipX: false,
      flipY: true,
    );

    // Bottom-right
    _drawCorner(
      canvas,
      cornerPaint,
      x: centre.dx + half,
      y: centre.dy + half,
      flipX: true,
      flipY: true,
    );

    // TODO: Add animated scanning line (laser animation) here.
    // TODO: Add success animation (green flash / checkmark) on QR detection.
    // TODO: Add error animation (red pulse) on invalid QR.
  }

  /// Draws a single rounded-L corner indicator at ([x], [y]).
  ///
  /// [flipX] mirrors the L horizontally (for right-side corners).
  /// [flipY] mirrors the L vertically (for bottom corners).
  void _drawCorner(
    Canvas canvas,
    Paint paint, {
    required double x,
    required double y,
    required bool flipX,
    required bool flipY,
  }) {
    final dx = flipX ? -1.0 : 1.0;
    final dy = flipY ? -1.0 : 1.0;

    final r = _cornerRadius * 1.0;
    final lineLen = _cornerLength - r;

    // The corner is an arc + two short straight segments (an L-shape).
    final path = Path();

    // Horizontal arm: from the outer edge inward.
    path.moveTo(x + dx * _cornerLength, y);
    path.lineTo(x + dx * r, y);

    // Rounded corner arc.
    path.arcToPoint(
      Offset(x, y + dy * r),
      radius: Radius.circular(r),
      clockwise: !(flipX ^ flipY),
    );

    // Vertical arm: from the arc down/up.
    path.lineTo(x, y + dy * (r + lineLen));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_QrOverlayPainter oldDelegate) =>
      oldDelegate.scanAreaSize != scanAreaSize ||
      oldDelegate.scrimColor != scrimColor ||
      oldDelegate.cornerColor != cornerColor;
}
