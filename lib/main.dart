import 'package:flutter/material.dart';
import 'lab/lab1/lab1.dart';
import 'lab/lab2/lab2.dart';
import 'lab/lab3/nav.dart';
import 'lab/test/test.dart';

void main() => runApp(MyFirstApp());

class MyFirstApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyFirstAppState();
  }
}

class _MyFirstAppState extends State<MyFirstApp> {
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.orangeAccent,
        accentColor: Colors.orangeAccent,
        fontFamily: 'Montserrat',
      ),
      home: DefaultTabController(
          length: 4,
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
                  Tab(
                    icon: Icon(Icons.radio),
                    text: "test",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                LabFirst(),
                LabSecond(),
                Lab3Nav(),
                Testtest(),
              ],
            ),
          )),
    );
  }
}
