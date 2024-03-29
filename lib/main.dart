// adb shell setprop debug.firebase.analytics.app com.example.flutter_application_1
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'lab/lab1/lab1.dart';
import 'lab/lab2/lab2.dart';
import 'lab/lab3/nav.dart';
import 'lab/lab4/lab4.dart';
import 'lab/lab6/lab6.dart';
import 'lab/lab7/lab7.dart';
import 'lab/lab8/lab8.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/observer.dart';

FirebaseAnalytics analytics = FirebaseAnalytics();
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyFirstApp());
}

class MyFirstApp extends StatefulWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
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
          length: 7,
          child: Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text('Mobile Development'),
              ),
              bottom: TabBar(
                isScrollable: true,
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
                    icon: FaIcon(FontAwesomeIcons.vk),
                    text: "Lab 4-5",
                  ),
                  Tab(
                    icon: FaIcon(FontAwesomeIcons.lock),
                    text: "Lab 6",
                  ),
                  Tab(
                    icon: Icon(Icons.message),
                    text: "Lab 7",
                  ),
                  Tab(
                    icon: FaIcon(FontAwesomeIcons.server),
                    text: "Lab 8",
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                LabFirst(),
                LabSecond(),
                Lab3Nav(),
                LabFourth(),
                LabSixth(),
                LabSeventh(),
                LabEigth()
              ],
            ),
            drawer: Drawer(
              child: new ListView(
                children: <Widget>[
                  new DrawerHeader(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    child: UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.green,
                      ),
                      accountName: Text('asd'),
                      accountEmail: Text("home@dartflutter.ru"),
                    ),
                  ),
                  new ListTile(title: new Text("О себе"), onTap: () {}),
                  new ListTile(title: new Text("Настройки"), onTap: () {})
                ],
              ),
            ),
          )),
    );
  }
}
