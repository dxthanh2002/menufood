import 'package:flutter/material.dart';

enum _HandleType { topLeft, topRight, bottomLeft, bottomRight, left, right, move, none }

class ScannerSelectionOverlay extends StatefulWidget {
  final ValueNotifier<Rect> selectionNotifier;

  const ScannerSelectionOverlay({super.key, required this.selectionNotifier});

  @override
  State<ScannerSelectionOverlay> createState() => _ScannerSelectionOverlayState();
}

class _ScannerSelectionOverlayState extends State<ScannerSelectionOverlay> {
  _HandleType _activeHandle = _HandleType.none;
  static const double _hitRadius = 36.0;
  static const double _minSize = 50.0;

  Rect get _rect => widget.selectionNotifier.value;
  set _rect(Rect r) => widget.selectionNotifier.value = r;

  _HandleType _hitTest(Offset pos) {
    final r = _rect;
    if ((pos - r.topLeft).distance < _hitRadius) return _HandleType.topLeft;
    if ((pos - r.topRight).distance < _hitRadius) return _HandleType.topRight;
    if ((pos - r.bottomLeft).distance < _hitRadius) return _HandleType.bottomLeft;
    if ((pos - r.bottomRight).distance < _hitRadius) return _HandleType.bottomRight;
    if ((pos - Offset(r.left, r.center.dy)).distance < _hitRadius) return _HandleType.left;
    if ((pos - Offset(r.right, r.center.dy)).distance < _hitRadius) return _HandleType.right;
    if (r.contains(pos)) return _HandleType.move;
    return _HandleType.none;
  }

  void _onPanStart(DragStartDetails d) {
    _activeHandle = _hitTest(d.localPosition);
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
      case _HandleType.left:
        r = Rect.fromLTRB(r.left + dx, r.top, r.right, r.bottom);
      case _HandleType.right:
        r = Rect.fromLTRB(r.left, r.top, r.right + dx, r.bottom);
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
      if (r.bottom > size.height) r = r.shift(Offset(0, size.height - r.bottom));
    } else {
      r = Rect.fromLTRB(
        r.left.clamp(0.0, size.width),
        r.top.clamp(0.0, size.height),
        r.right.clamp(0.0, size.width),
        r.bottom.clamp(0.0, size.height),
      );
    }

    _rect = r;
    setState(() {});
  }

  void _onPanEnd(DragEndDetails d) {
    _activeHandle = _HandleType.none;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: ValueListenableBuilder<Rect>(
        valueListenable: widget.selectionNotifier,
        builder: (context, rect, _) {
          return CustomPaint(
            size: Size.infinite,
            painter: _SelectionPainter(rect),
          );
        },
      ),
    );
  }
}

class _SelectionPainter extends CustomPainter {
  final Rect rect;
  _SelectionPainter(this.rect);

  @override
  void paint(Canvas canvas, Size size) {
    // Dark overlay outside selection
    final bgPath = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final selPath = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(12)));
    canvas.drawPath(
      Path.combine(PathOperation.difference, bgPath, selPath),
      Paint()..color = Colors.black.withValues(alpha: 0.55),
    );

    // Selection border
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(12)),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // Corner brackets
    const len = 30.0;
    final cp = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    // Top-left
    canvas.drawLine(Offset(rect.left + 2, rect.top), Offset(rect.left + len, rect.top), cp);
    canvas.drawLine(Offset(rect.left, rect.top + 2), Offset(rect.left, rect.top + len), cp);
    // Top-right
    canvas.drawLine(Offset(rect.right - 2, rect.top), Offset(rect.right - len, rect.top), cp);
    canvas.drawLine(Offset(rect.right, rect.top + 2), Offset(rect.right, rect.top + len), cp);
    // Bottom-left
    canvas.drawLine(Offset(rect.left + 2, rect.bottom), Offset(rect.left + len, rect.bottom), cp);
    canvas.drawLine(Offset(rect.left, rect.bottom - 2), Offset(rect.left, rect.bottom - len), cp);
    // Bottom-right
    canvas.drawLine(Offset(rect.right - 2, rect.bottom), Offset(rect.right - len, rect.bottom), cp);
    canvas.drawLine(Offset(rect.right, rect.bottom - 2), Offset(rect.right, rect.bottom - len), cp);

    // Side handles (pill-shaped)
    final hp = Paint()..color = Colors.white.withValues(alpha: 0.85);
    const hw = 5.0;
    const hh = 44.0;
    const hr = Radius.circular(2.5);

    // Left handle
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(rect.left, rect.center.dy), width: hw, height: hh),
        hr,
      ),
      hp,
    );
    // Right handle
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(rect.right, rect.center.dy), width: hw, height: hh),
        hr,
      ),
      hp,
    );
  }

  @override
  bool shouldRepaint(covariant _SelectionPainter old) => rect != old.rect;
}
