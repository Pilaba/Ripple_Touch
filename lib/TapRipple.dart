
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
  final bool isAnimationReverse;
  final double extraScale;

  const TapRipple({
    this.child, required this.position, required this.curve, required this.fadeInDuration, required this.fadeOutDuration,
    required this.rightPadding, required this.bottomPadding, required this.width, required this.height, required this.backgroundColor, this.border,
    required this.isAnimationReverse, required this.extraScale,
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
            opacity: 1 - _controller.value,
            child: Transform.scale(
              scale: widget.isAnimationReverse ? (1 + widget.extraScale - _controller.value) : _controller.value,
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
