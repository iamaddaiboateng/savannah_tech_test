import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int pageOpenCounter = 0;
  int openKotlinActivityCount = 0;
  int mainPageOpenCount = 1;

  final platform = const MethodChannel('com.startActivity/testChannel');

  Future<void> _startActivity() async {
    setState(() {
      openKotlinActivityCount++;
    });

    try {
      final String result = await platform.invokeMethod('StartSecondActivity', {
        "kotlin": openKotlinActivityCount.toString(),
        "flutter": pageOpenCounter.toString(),
        "mainPage": mainPageOpenCount.toString()
      });
      debugPrint('Result: $result ');

      if (result == "ActivityStarted") {
        mainPageOpenCount++;
      }
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            pageOpenCounter++;
            mainPageOpenCount++;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PageTwo(
                  counter: pageOpenCounter,
                );
              },
            ),
          );
        },
        onLongPress: () {
          _startActivity();
        },
        child: Center(
          child: Image.asset(
            "images/image2.jpeg",
            height: 200,
            width: 200,
          ),
        ),
      ),
    );
  }
}

class PageTwo extends StatefulWidget {
  final int counter;
  const PageTwo({Key? key, required this.counter}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Page"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("This page has being opened ${widget.counter} time(s)"),
              Image.asset(
                "images/flutter.png",
                height: 200,
                width: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
