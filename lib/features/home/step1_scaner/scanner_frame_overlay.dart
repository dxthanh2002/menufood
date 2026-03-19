import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/colors.dart';

enum _HandleType { topLeft, topRight, bottomLeft, bottomRight, move, none }

class ScannerFrameOverlay extends StatefulWidget {
  const ScannerFrameOverlay({super.key});

  @override
  State<ScannerFrameOverlay> createState() => _ScannerFrameOverlayState();
}

class _ScannerFrameOverlayState extends State<ScannerFrameOverlay>
    with SingleTickerProviderStateMixin {
  Rect _rect = Rect.zero;
  bool _initialized = false;
  _HandleType _activeHandle = _HandleType.none;

  static const double _hitRadius = 40.0;
  static const double _minSize = 100.0;

  late final AnimationController _hintAnim;
  bool _hintInitialShown = false;

  @override
  void initState() {
    super.initState();
    _hintAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _hintAnim.dispose();
    super.dispose();
  }

  void _showHint(Duration visibleDuration) {
    _hintAnim.forward();
    Future.delayed(visibleDuration, () {
      if (mounted) _hintAnim.reverse();
    });
  }

  void _initRect(Size size) {
    if (_initialized) return;
    _initialized = true;
    final frameSize = size.width * 0.72;
    _rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height * 0.42),
      width: frameSize,
      height: frameSize,
    );
    if (!_hintInitialShown) {
      _hintInitialShown = true;
      _showHint(const Duration(seconds: 2));
    }
  }

  _HandleType _hitTest(Offset pos) {
    if ((pos - _rect.topLeft).distance < _hitRadius) return _HandleType.topLeft;
    if ((pos - _rect.topRight).distance < _hitRadius)
      return _HandleType.topRight;
    if ((pos - _rect.bottomLeft).distance < _hitRadius)
      return _HandleType.bottomLeft;
    if ((pos - _rect.bottomRight).distance < _hitRadius)
      return _HandleType.bottomRight;
    if (_rect.contains(pos)) return _HandleType.move;
    return _HandleType.none;
  }

  void _onPanStart(DragStartDetails d) {
    _activeHandle = _hitTest(d.localPosition);
    if (_activeHandle != _HandleType.none) {
      _showHint(const Duration(milliseconds: 500));
    }
  }

  void _onPanUpdate(DragUpdateDetails d) {
    if (_activeHandle == _HandleType.none) return;
    final dx = d.delta.dx;
    final dy = d.delta.dy;
    var r = _rect;

    switch (_activeHandle) {
      case _HandleType.topLeft:
        r = Rect.fromLTRB(r.left + dx, r.top + dy, r.right, r.bottom);
      case _HandleType.topRight:
        r = Rect.fromLTRB(r.left, r.top + dy, r.right + dx, r.bottom);
      case _HandleType.bottomLeft:
        r = Rect.fromLTRB(r.left + dx, r.top, r.right, r.bottom + dy);
      case _HandleType.bottomRight:
        r = Rect.fromLTRB(r.left, r.top, r.right + dx, r.bottom + dy);
      case _HandleType.move:
        r = r.shift(d.delta);
      case _HandleType.none:
        return;
    }

    if (r.width < _minSize || r.height < _minSize) return;

    final size = context.size;
    if (size == null) return;

    if (_activeHandle == _HandleType.move) {
      if (r.left < 0) r = r.shift(Offset(-r.left, 0));
      if (r.top < 0) r = r.shift(Offset(0, -r.top));
      if (r.right > size.width) r = r.shift(Offset(size.width - r.right, 0));
      if (r.bottom > size.height)
        r = r.shift(Offset(0, size.height - r.bottom));
    } else {
      r = Rect.fromLTRB(
        r.left.clamp(0.0, size.width),
        r.top.clamp(0.0, size.height),
        r.right.clamp(0.0, size.width),
        r.bottom.clamp(0.0, size.height),
      );
    }

    setState(() => _rect = r);
  }

  void _onPanEnd(DragEndDetails d) {
    _activeHandle = _HandleType.none;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _initRect(constraints.biggest);

        final hintTop = _rect.top + _rect.height * 0.65;

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanStart: _onPanStart,
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          child: Stack(
            children: [
              CustomPaint(
                size: constraints.biggest,
                painter: _FramePainter(_rect),
              ),
              Positioned(
                top: hintTop,
                left: 0,
                right: 0,
                child: Center(
                  child: FadeTransition(
                    opacity: _hintAnim,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Place ingredients inside the frame',
                        style: GoogleFonts.inter(
                          color: AppColors.accentBrown.withValues(alpha: 0.7),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FramePainter extends CustomPainter {
  final Rect rect;
  _FramePainter(this.rect);

  static const double _radius = 24.0;

  @override
  void paint(Canvas canvas, Size size) {
    // Dark overlay outside frame
    final bgPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final framePath = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(_radius)));
    canvas.drawPath(
      Path.combine(PathOperation.difference, bgPath, framePath),
      Paint()..color = Colors.black.withValues(alpha: 0.45),
    );

    // Orange border
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(_radius)),
      Paint()
        ..color = AppColors.primary.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );

    // Corner accent arcs (thicker orange)
    final cp = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round;

    const arcSize = _radius * 2;
    const sweepAngle = 1.5708; // pi/2

    // Top-left
    canvas.drawArc(
      Rect.fromLTWH(rect.left, rect.top, arcSize, arcSize),
      3.14159,
      sweepAngle,
      false,
      cp,
    );
    // Top-right
    canvas.drawArc(
      Rect.fromLTWH(rect.right - arcSize, rect.top, arcSize, arcSize),
      -1.5708,
      sweepAngle,
      false,
      cp,
    );
    // Bottom-left
    canvas.drawArc(
      Rect.fromLTWH(rect.left, rect.bottom - arcSize, arcSize, arcSize),
      1.5708,
      sweepAngle,
      false,
      cp,
    );
    // Bottom-right
    canvas.drawArc(
      Rect.fromLTWH(
        rect.right - arcSize,
        rect.bottom - arcSize,
        arcSize,
        arcSize,
      ),
      0,
      sweepAngle,
      false,
      cp,
    );
  }

  @override
  bool shouldRepaint(covariant _FramePainter old) => rect != old.rect;
}
