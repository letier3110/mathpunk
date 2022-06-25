import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:window_size/window_size.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows) {
      setWindowTitle("Mathpunk spire");
    }
    return MaterialApp(
      title: 'Mathpunk spire demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Mathpunk spire'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Center(
              child: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 160.0),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.headline4,
            ),
          )),
          Positioned(
            bottom: 0,
            child: Container(
                margin: const EdgeInsets.all(8.0),
                height: 500,
                alignment: Alignment.bottomLeft,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0)),
                child: Stack(
                  children: [
                    Positioned(
                      top: 120,
                      child: Column(children: const [
                        MenuItem(text: 'Play'),
                        MenuItem(text: 'Compedium'),
                        MenuItem(text: 'Statistics'),
                        MenuItem(text: 'Settings'),
                        MenuItem(text: 'Patch Notes'),
                        MenuItem(text: 'Quit'),
                      ]),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}

class MenuItem extends StatefulWidget {
  final String text;

  const MenuItem({required this.text});

  @override
  MenuItemState createState() {
    return MenuItemState();
  }
}

class MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              width: 300,
              height: 50.0,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                widget.text,
                style: TextStyle(fontSize: 24.0),
              ),
            )
          ],
        ));
  }
}
