# Ripple_Touch

Add a ripple touch effect when tap the screen

## Installation

Add `ripple_touch: ^1.0.0` in your `pubspec.yaml` dependencies. And import it:

```dart
import 'package:ripple_touch/RippleManager.dart';
```

## How to use

Initialize the overlay as soon as you want (preferably at the application start).
```dart

// Initialize
@override
void initState() {
  super.initState();
  Future.delayed(Duration.zero).then((value) => RippleManager().init(context));
}

// Destroy the thing
RippleManager().dispose();
```

For a more detail example please take a look at the `example` folder.

## Demo

<img src="https://raw.githubusercontent.com/Pilaba/Ripple_Touch/master/example/demo.gif" width="500" height="1000">


## -

If something is missing, feel free to open a ticket or contribute!
