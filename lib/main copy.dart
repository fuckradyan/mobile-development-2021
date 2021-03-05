import 'dart:async';

import 'package:flutter/material.dart';

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
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: "1",
                  ),
                  Tab(
                    text: "2",
                  ),
                  Tab(
                    text: "3",
                  ),
                ],
              ),
            ),
          )),
    );
  }

// PageView(
//         children: <Widget>[
//           Container(
//             color: Colors.red,
//             child: Center(child: Text('1')),
//           ),
//           Container(
//             color: Colors.red,
//             child: Center(child: Text('2')),
//           ),
//           Container(
//             color: Colors.red,
//             child: Center(child: Text('3')),
//           ),
//         ],
//       ),
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
