import 'package:flutter/material.dart';
import 'lab/lab1/lab1.dart';
import 'lab/lab2/lab2.dart';
import 'lab/lab3/lab3.dart';

void main() => runApp(MyFirstApp());

class MyFirstApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyFirstAppState();
  }
}

class _MyFirstAppState extends State<MyFirstApp> {
  // bool _loading;
  // double _progressValue;
  @override
  void initState() {
    // _loading = false;
    // _progressValue = 0.0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.orangeAccent,
        accentColor: Colors.orangeAccent,
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
                    icon: Icon(
                      Icons.widgets,
                    ),
                    text: "Lab 1",
                  ),
                  Tab(
                    icon: Icon(Icons.camera_alt_outlined),
                    text: "Lab 2",
                  ),
                  Tab(
                    icon: Icon(Icons.connected_tv),
                    text: "Lab 3",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                LabFirst(),
                LabSecond(),
                LabThird(),
              ],
            ),
          )),
    );
  }
}
