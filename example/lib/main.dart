import 'package:flutter/material.dart';
import 'package:ripple_touch/TapRippleManager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal), useMaterial3: false,),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) => TapRippleManager().init(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Tap anywhere in the app',),
            MaterialButton(
              color: Colors.orange[300],
              child: const Text("Navigate to newPage"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PageTwo()));
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Use custom touch widget"),
        icon: const Icon(Icons.star),
        backgroundColor: Colors.teal[300],
        onPressed: () {
          TapRippleManager().dispose();
          TapRippleManager().init(context, customChild: const Icon(Icons.star, color: Colors.orange, size: 50));
        },
      ),
    );
  }
}

class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("page Two"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            MaterialButton(
              color: Colors.indigo[200],
              child: const Text("Navigate back"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}

