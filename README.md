# Ripple_Touch

Add a ripple touch effect when tap the screen

## Installation

Add `ripple_touch: ^1.0.0` in your `pubspec.yaml` dependencies. And import it:

```dart
import 'package:ripple_touch/RippleManager.dart';
```

## How to use

```dart
Future.delayed(Duration.zero).then((value) => RippleManager().init(context));
```

For a more detail example please take a look at the `example` folder.


