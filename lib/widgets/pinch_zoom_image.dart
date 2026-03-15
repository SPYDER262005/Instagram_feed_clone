import 'package:flutter/material.dart';

class PinchZoomImage extends StatefulWidget {
  final Widget child;

  const PinchZoomImage({
    super.key,
    required this.child,
  });

  @override
  State<PinchZoomImage> createState() => _PinchZoomImageState();
}

class _PinchZoomImageState extends State<PinchZoomImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Animation<double>? _scaleAnimation;
  Animation<Offset>? _offsetAnimation;

  double _scale = 1.0;
  double _previousScale = 1.0;
  Offset _offset = Offset.zero;
  Offset _previousOffset = Offset.zero;
  Offset _focalPoint = Offset.zero;

  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        if (_scaleAnimation != null && _offsetAnimation != null) {
          _scale = _scaleAnimation!.value;
          _offset = _offsetAnimation!.value;
          _overlayEntry?.markNeedsBuild();
        }
      });
  }

  void _createOverlay() {
    if (_overlayEntry != null) return;
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          left: position.dx,
          top: position.dy,
          width: renderBox.size.width,
          height: renderBox.size.height,
          child: Material(
            color: Colors.transparent,
            child: Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..translate(_offset.dx, _offset.dy)
                ..scale(_scale, _scale),
              child: widget.child,
            ),
          ),
        );
      },
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (details) {
        _previousScale = _scale;
        _previousOffset = _offset;
        _focalPoint = details.focalPoint;
        _createOverlay();
        // Hide the original widget while zooming
        setState(() {});
      },
      onScaleUpdate: (details) {
        _scale = (_previousScale * details.scale).clamp(0.8, 4.0);
        _offset = _previousOffset + (details.focalPoint - _focalPoint);
        _overlayEntry?.markNeedsBuild();
      },
      onScaleEnd: (details) {
        _scaleAnimation = Tween<double>(
          begin: _scale,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOut,
        ));

        _offsetAnimation = Tween<Offset>(
          begin: _offset,
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOut,
        ));

        _animationController.forward(from: 0).then((_) {
          _scale = 1.0;
          _offset = Offset.zero;
          _removeOverlay();
          // Show the original widget again
          if (mounted) setState(() {});
        });
      },
      child: Opacity(
        opacity: _overlayEntry != null ? 0.0 : 1.0,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
    }
    super.dispose();
  }
}
