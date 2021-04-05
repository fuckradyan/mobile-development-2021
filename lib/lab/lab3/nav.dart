import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'json_parse.dart';
import 'webview.dart';
import 'html_parse.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Lab3Nav(),
    );
  }
}

class Lab3Nav extends StatefulWidget {
  @override
  Lab3Nav1 createState() => Lab3Nav1();
}

class Lab3Nav1 extends State {
  int _currentIndex = 0;

  List NavyItems = [
    LabThird(),
    WebViewExample(),
    MyForm(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NavyItems[_currentIndex],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.code_rounded),
            title: Text('JSON'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.web_asset),
            title: Text('Webview'),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.album),
            title: Text(
              'html',
            ),
            activeColor: Colors.pink,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
