
import 'package:flutter/material.dart';

class TapRipple extends StatefulWidget {
  final Widget? child;
  final Offset position;

  const TapRipple({this.child, required this.position, Key? key}) : super(key: key);

  @override
  State<TapRipple> createState() => _TapRippleState();
}

class _TapRippleState extends State<TapRipple> with TickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 250))..forward();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) => Positioned(
        left: widget.position.dx - 25,
        top: widget.position.dy - 25,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: _controller.value == 1 ? 0 : 1,
          child: Transform.scale(
            scale: _controller.value,
            child: child,
          ),
        )
      ),
      child: widget.child ?? Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.teal[50], border: Border.all(color: Colors.teal[100]!, width: 3,),),
      ),
    );
  }
}


