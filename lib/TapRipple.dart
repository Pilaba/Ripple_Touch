
import 'package:flutter/material.dart';

class TapRipple extends StatefulWidget {
  final Widget? child;
  final Offset position;
  final Curve curve;
  final Duration fadeInDuration;
  final Duration fadeOutDuration;

  final double rightPadding;
  final double bottomPadding;
  final double width;
  final double height;
  final Color backgroundColor;
  final BoxBorder? border;

  const TapRipple({
    this.child, required this.position, required this.curve, required this.fadeInDuration, required this.fadeOutDuration,
    required this.rightPadding, required this.bottomPadding, required this.width, required this.height, required this.backgroundColor, this.border,
    Key? key
  }) : super(key: key);

  @override
  State<TapRipple> createState() => _TapRippleState();
}

class _TapRippleState extends State<TapRipple> with TickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this, duration: widget.fadeInDuration)..animateTo(1, curve: widget.curve);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) => Positioned(
        left: widget.position.dx - widget.rightPadding,
        top: widget.position.dy - widget.bottomPadding,
        child: AnimatedOpacity(
          duration: widget.fadeOutDuration,
          opacity: _controller.value == 1 ? 0 : 1,
          child: Transform.scale(
            scale: _controller.value,
            child: child,
          ),
        )
      ),
      child: widget.child ?? Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(shape: BoxShape.circle, color: widget.backgroundColor, border: widget.border ?? Border.all(color: Colors.teal[200]!, width: 3,),),
      ),
    );
  }

  dispose() {
    _controller.dispose();
    super.dispose();
  }
}


