import 'dart:async';

import 'package:flutter/material.dart';
import 'lab/lab1.dart';

void main() => runApp(MyFirstApp());

class MyFirstApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyFirstAppState();
  }
}

class _MyFirstAppState extends State<MyFirstApp> {
  bool _loading;
  double _progressValue;
  @override
  void initState() {
    _loading = false;
    _progressValue = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.cyan[600],
        accentColor: Colors.cyan[600],
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
            // headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            // headline2: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            // bodyText1: TextStyle(fontSize: 14.0, fontFamily: 'Montserrat'),
            ),
      ),
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text('Mobile Development'),
              ),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    text: "Lab 1",
                  ),
                  Tab(
                    text: "Lab 2",
                  ),
                  Tab(
                    text: "Lab 3",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                LabFirst(),
                Center(child: Text('example')),
                Center(child: Text('example')),
              ],
            ),
          )),
    );
  }

  void _updateProgress() {
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _progressValue += 0.2;
        if (_progressValue.toStringAsFixed(1) == '1.0') {
          _loading = false;
          t.cancel();
          _progressValue = 0.0;
          return;
        }
      });
    });
  }
}

// Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: Text("My first App"),
//           centerTitle: true,
//         ),
//         body: Center(
//           child: Container(
//             padding: EdgeInsets.all(16),
//             child: _loading
// ? Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: <Widget>[
//       LinearProgressIndicator(value: _progressValue),
//       Text(
//         '${(_progressValue * 100).round()}%',
//         style: TextStyle(color: Colors.indigo, fontSize: 20),
//       ),
//     ],
//   )
//                 : Text(
//                     'Press button to download',
//                     style: TextStyle(color: Colors.indigo, fontSize: 20),
//                   ),
//           ),
//         ),
// floatingActionButton: FloatingActionButton(
// onPressed: () {
//   setState(() {
//     _loading = !_loading;
//     _updateProgress();
//   });
// },
//   child: Icon(Icons.cloud_download),
// ),
//       ),
