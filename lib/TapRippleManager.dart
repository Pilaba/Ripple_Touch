import 'package:flutter/material.dart';
import 'package:ripple_touch/TapRipple.dart';

class TapRippleManager {
  // SINGLETON
  TapRippleManager._privateConstructor() { _InitSingleton(); }
  static final TapRippleManager _instance = TapRippleManager._privateConstructor();
  factory TapRippleManager() => _instance;
  void _InitSingleton() { }

  late var _isInitialized  = false;      // Flag to check if the TapRipple has been initialized
  late final _tapPositions = <Offset>[]; // List of tap positions
  late OverlayEntry? _overlayEntry;
  late var cancelRipple = false;        // Flag to cancel the ripple effect when the user moves the pointer

  void init(BuildContext context, {
    Widget? customChild,
    Function? onTap,
    bool enableRippleOnSwipe = false,
    Curve curve = Curves.linear,
    Duration fadeInDuration = const Duration(milliseconds: 250),
    Duration fadeOutDuration = const Duration(milliseconds: 200),
    double rightPadding = 25,
    double bottomPadding = 25,
    double width = 50,
    double height = 50,
    Color backgroundColor = const Color(0xFFB2DFDB),
    BoxBorder? border,
  }) {
    if(_isInitialized) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: 0,
        top: 0,
        right: 0,
        bottom: 0,
        child: Listener(
          behavior: HitTestBehavior.translucent,
          onPointerMove: enableRippleOnSwipe ? null : (details) {
            cancelRipple = true;
          },
          onPointerUp: (details) async {
            if(cancelRipple) { cancelRipple = false; return; }

            _tapPositions.add(details.position);
            _overlayEntry?.markNeedsBuild();

            onTap?.call();
            await Future<void>.delayed(fadeInDuration + fadeOutDuration);

            _tapPositions.remove(details.position);
            _overlayEntry?.markNeedsBuild();
          },
          child: IgnorePointer(
            child: Material(
              color: Colors.transparent,
              child: Stack(
                children: _tapPositions.map((position) {
                  return TapRipple(
                    key: Key("$position"),
                    position: position,
                    curve: curve,
                    fadeInDuration: fadeInDuration,
                    fadeOutDuration: fadeOutDuration,
                    rightPadding: rightPadding,
                    bottomPadding: bottomPadding,
                    width: width,
                    height: height,
                    backgroundColor: backgroundColor,
                    border: border,
                    child: customChild,
                  );
                }).toList()
              )
            ),
          ),
        ),
      ),
    );

    if(_overlayEntry != null) {
      Overlay.of(context).insert(_overlayEntry!);
      _isInitialized = true;
    };
  }

  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry  = null;
    _isInitialized = false;
  }
}