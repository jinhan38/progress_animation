import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:progress_animation/circle_progress.dart';
import 'package:progress_animation/progress_interface.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Progress Animation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProgressInterface _interface1;
  late ProgressInterface _interface2;
  late ProgressInterface _interface3;
  late Widget progress1;
  late Widget progress2;
  late Widget progress3;

  @override
  void initState() {
    progress1 = CircleProgressWrap(
      key: GlobalKey<State>(),
      interface: (interface) => _interface1 = interface,
      duration: const Duration(milliseconds: 1500),
      progressValue: (value) {
        return Text("value : $value");
      },
      radius: 80,
      circleBaseColor: Colors.blue,
      circleProgressColor: Colors.red,
      begin: 0,
      end: 81,
      baseStroke: 5,
      progressStroke: 10,
    );
    progress2 = CircleProgressWrap(
      key: GlobalKey<State>(),
      interface: (interface) => _interface2 = interface,
      duration: const Duration(milliseconds: 1500),
      progressValue: (value) {
        return Text("value : $value");
      },
      radius: 70,
      circleBaseColor: Colors.blue,
      circleProgressColor: Colors.red,
      begin: 0,
      end: 70,
      baseStroke: 7,
      progressStroke: 12,
    );
    progress3 = CircleProgressWrap(
      key: GlobalKey<State>(),
      interface: (interface) => _interface3 = interface,
      duration: const Duration(milliseconds: 1500),
      progressValue: (value) {
        return Text("value : $value");
      },
      radius: 60,
      circleBaseColor: Colors.blue,
      circleProgressColor: Colors.red,
      begin: 0,
      end: 30,
      baseStroke: 9,
      progressStroke: 14,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            ..._list(),
            SizedBox(
              height: 300,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: _progressList(),
              ),
            ),
            ..._list(),
          ],
        ),
      ),
    );
  }

  List<Widget> _list() {
    return List.generate(
      15,
      (index) => SizedBox(
        height: 80,
        child: Center(child: Text(index.toString())),
      ),
    );
  }

  List<Widget> _progressList() {
    return [
      VisibilityDetector(
        key: Key("11"),
        onVisibilityChanged: (VisibilityInfo info) {
          if (info.visibleFraction > 0) {
            _interface1.start();
          } else {
            _interface1.stop();
          }
        },
        child: progress1,
      ),
      VisibilityDetector(
        key: Key("22"),
        onVisibilityChanged: (VisibilityInfo info) {
          if (info.visibleFraction > 0) {
            _interface2.start();
          } else {
            _interface2.stop();
          }
        },
        child: progress2,
      ),
      VisibilityDetector(
        key: Key("33"),
        onVisibilityChanged: (VisibilityInfo info) {
          if (info.visibleFraction > 0) {
            _interface3.start();
          } else {
            _interface3.stop();
          }
        },
        child: progress3,
      ),
    ];
  }
}
