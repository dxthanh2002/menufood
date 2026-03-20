import 'package:flutter/material.dart';

enum _HandleType {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  left,
  right,
  move,
  none,
}

class ScannerSelectionOverlay extends StatefulWidget {
  final ValueNotifier<Rect> selectionNotifier;

  const ScannerSelectionOverlay({super.key, required this.selectionNotifier});

  @override
  State<ScannerSelectionOverlay> createState() =>
      _ScannerSelectionOverlayState();
}

class _ScannerSelectionOverlayState extends State<ScannerSelectionOverlay> {
  // Map pointer ID to the handle it's currently dragging
  final Map<int, _HandleType> _pointerHandles = {};
  // Map pointer ID to the initial offset from the handle at touch down
  final Map<int, Offset> _pointerStartOffsets = {};
  
  static const double _hitRadius = 40.0;
  static const double _minSize = 64.0; 

  void _onPointerDown(PointerDownEvent event) {
    final pos = event.localPosition;
    final r = widget.selectionNotifier.value;

    final candidates = [
      (handle: _HandleType.topLeft, pos: r.topLeft),
      (handle: _HandleType.topRight, pos: r.topRight),
      (handle: _HandleType.bottomLeft, pos: r.bottomLeft),
      (handle: _HandleType.bottomRight, pos: r.bottomRight),
      (handle: _HandleType.left, pos: Offset(r.left, r.center.dy)),
      (handle: _HandleType.right, pos: Offset(r.right, r.center.dy)),
    ];

    // Find the closest handle within hit radius that isn't already taken
    final available = candidates
        .map((c) => (handle: c.handle, dist: (pos - c.pos).distance, pos: c.pos))
        .where((c) => c.dist < _hitRadius && !_pointerHandles.values.contains(c.handle))
        .toList()
      ..sort((a, b) => a.dist.compareTo(b.dist));
    
    _HandleType selectedHandle = available.isNotEmpty ? available.first.handle : _HandleType.none;

    if (selectedHandle == _HandleType.none && r.contains(pos)) {
      if (!_pointerHandles.values.contains(_HandleType.move)) {
        selectedHandle = _HandleType.move;
      }
    }

    if (selectedHandle != _HandleType.none) {
      _pointerHandles[event.pointer] = selectedHandle;
      // Store the offset from the touch point to the relevant anchor
      switch (selectedHandle) {
        case _HandleType.topLeft: _pointerStartOffsets[event.pointer] = pos - r.topLeft;
        case _HandleType.topRight: _pointerStartOffsets[event.pointer] = pos - r.topRight;
        case _HandleType.bottomLeft: _pointerStartOffsets[event.pointer] = pos - r.bottomLeft;
        case _HandleType.bottomRight: _pointerStartOffsets[event.pointer] = pos - r.bottomRight;
        case _HandleType.left: _pointerStartOffsets[event.pointer] = pos - Offset(r.left, r.center.dy);
        case _HandleType.right: _pointerStartOffsets[event.pointer] = pos - Offset(r.right, r.center.dy);
        case _HandleType.move: _pointerStartOffsets[event.pointer] = pos - r.topLeft;
        case _HandleType.none: break;
      }
    }
  }

  void _onPointerMove(PointerMoveEvent event) {
    final handle = _pointerHandles[event.pointer];
    final startOffset = _pointerStartOffsets[event.pointer];
    if (handle == null || startOffset == null) return;

    final pos = event.localPosition;
    var r = widget.selectionNotifier.value;
    final anchor = pos - startOffset;

    switch (handle) {
      case _HandleType.topLeft:
        r = Rect.fromLTRB(anchor.dx, anchor.dy, r.right, r.bottom);
      case _HandleType.topRight:
        r = Rect.fromLTRB(r.left, anchor.dy, anchor.dx, r.bottom);
      case _HandleType.bottomLeft:
        r = Rect.fromLTRB(anchor.dx, r.top, r.right, anchor.dy);
      case _HandleType.bottomRight:
        r = Rect.fromLTRB(r.left, r.top, anchor.dx, anchor.dy);
      case _HandleType.left:
        r = Rect.fromLTRB(anchor.dx, r.top, r.right, r.bottom);
      case _HandleType.right:
        r = Rect.fromLTRB(r.left, r.top, anchor.dx, r.bottom);
      case _HandleType.move:
        r = Rect.fromLTWH(anchor.dx, anchor.dy, r.width, r.height);
      default: break;
    }

    final size = context.size;
    if (size == null) return;

    // Constraints
    if (handle != _HandleType.move) {
      double l = r.left, t = r.top, ri = r.right, b = r.bottom;
      if (ri - l < _minSize) {
        if (handle == _HandleType.topLeft || handle == _HandleType.bottomLeft || handle == _HandleType.left) l = ri - _minSize;
        else ri = l + _minSize;
      }
      if (b - t < _minSize) {
        if (handle == _HandleType.topLeft || handle == _HandleType.topRight) t = b - _minSize;
        else b = t + _minSize;
      }
      r = Rect.fromLTRB(
        l.clamp(0.0, size.width),
        t.clamp(0.0, size.height),
        ri.clamp(0.0, size.width),
        b.clamp(0.0, size.height),
      );
    } else {
      // Clamped move
      double dx = anchor.dx.clamp(0.0, size.width - r.width);
      double dy = anchor.dy.clamp(0.0, size.height - r.height);
      r = Rect.fromLTWH(dx, dy, r.width, r.height);
    }

    widget.selectionNotifier.value = r;
  }

  void _onPointerEnd(PointerEvent event) {
    _pointerHandles.remove(event.pointer);
    _pointerStartOffsets.remove(event.pointer);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerMove: _onPointerMove,
      onPointerUp: _onPointerEnd,
      onPointerCancel: _onPointerEnd,
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
    final bgPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
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
    canvas.drawLine(
      Offset(rect.left + 2, rect.top),
      Offset(rect.left + len, rect.top),
      cp,
    );
    canvas.drawLine(
      Offset(rect.left, rect.top + 2),
      Offset(rect.left, rect.top + len),
      cp,
    );
    // Top-right
    canvas.drawLine(
      Offset(rect.right - 2, rect.top),
      Offset(rect.right - len, rect.top),
      cp,
    );
    canvas.drawLine(
      Offset(rect.right, rect.top + 2),
      Offset(rect.right, rect.top + len),
      cp,
    );
    // Bottom-left
    canvas.drawLine(
      Offset(rect.left + 2, rect.bottom),
      Offset(rect.left + len, rect.bottom),
      cp,
    );
    canvas.drawLine(
      Offset(rect.left, rect.bottom - 2),
      Offset(rect.left, rect.bottom - len),
      cp,
    );
    // Bottom-right
    canvas.drawLine(
      Offset(rect.right - 2, rect.bottom),
      Offset(rect.right - len, rect.bottom),
      cp,
    );
    canvas.drawLine(
      Offset(rect.right, rect.bottom - 2),
      Offset(rect.right, rect.bottom - len),
      cp,
    );

    // Side handles (pill-shaped)
    final hp = Paint()..color = Colors.white.withValues(alpha: 0.85);
    const hw = 5.0;
    const hh = 44.0;
    const hr = Radius.circular(2.5);

    // Left handle
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(rect.left, rect.center.dy),
          width: hw,
          height: hh,
        ),
        hr,
      ),
      hp,
    );
    // Right handle
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(rect.right, rect.center.dy),
          width: hw,
          height: hh,
        ),
        hr,
      ),
      hp,
    );
  }

  @override
  bool shouldRepaint(covariant _SelectionPainter old) => rect != old.rect;
}
