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

  void init(BuildContext context, {Widget? customChild, Function? onTap}) {
    if(_isInitialized) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: 0,
        top: 0,
        right: 0,
        bottom: 0,
        child: Listener(
          behavior: HitTestBehavior.translucent,
          onPointerMove: (details) {
            cancelRipple = true;
          },
          onPointerUp: (details) async {
            if(cancelRipple) { cancelRipple = false; return; }

            _tapPositions.add(details.position);
            _overlayEntry?.markNeedsBuild();

            onTap?.call();
            await Future<void>.delayed(const Duration(seconds: 1));

            _tapPositions.remove(details.position);
            _overlayEntry?.markNeedsBuild();
          },
          child: IgnorePointer(
            child: Material(
              color: Colors.transparent,
              child: Stack(
                children: _tapPositions.map((position) => TapRipple(position: position, key: Key("$position"), child: customChild)).toList()
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