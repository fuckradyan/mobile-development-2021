import 'package:flutter/material.dart';
import 'dart:async';

class LabFirst extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LabFirst1();
  }
}

class LabFirst1 extends State {
  bool isSwitched = false;
  double _currentSliderValue = 0;
  bool _loading;
  double _progressValue;
  bool _showBusyInd;
  @override
  void initState() {
    _loading = false;
    _progressValue = 0.0;
    _showBusyInd = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !_loading
        ? Scaffold(
            body: Container(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Ваше имя',
                      ),
                    ),
                    SwitchListTile(
                      title: Text('Уведомить меня'),
                      value: isSwitched,
                      activeTrackColor: Colors.blue,
                      activeColor: Colors.blueAccent[700],
                      onChanged: (bool swValue) {
                        setState(() {
                          isSwitched = swValue;
                        });
                      },
                      secondary: Icon(Icons.offline_bolt),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.0),
                      padding: EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: Column(children: <Widget>[
                          Text('Выберите значение:'),
                          Slider(
                            value: _currentSliderValue,
                            min: 0,
                            max: 20,
                            divisions: 5,
                            label: _currentSliderValue.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValue = value;
                              });
                            },
                          ),
                        ]),
                      ),
                    ),
                    // Column(
                    //   children: [
                    //     Center(
                    //       child: CircularProgressIndicator(),
                    //     )
                    //   ],
                    // ),
                    // Text(
                    //   'Label',
                    //   // '${(_progressValue * 100).round()}%',
                    //   style: TextStyle(color: Colors.indigo, fontSize: 20),
                    // ),
                    Container(
                      alignment: Alignment(1, 1),
                      margin: EdgeInsets.only(top: 10.0),
                      child: OutlineButton(
                        onPressed: () {
                          setState(() {
                            _loading = !_loading;
                            _updateProgress();
                          });
                        },
                        child: Text(
                          'Отправить',

                          // '${(_progressValue * 100).round()}%',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : _showBusyInd
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LinearProgressIndicator(value: _progressValue),
                    Text(
                      '${(_progressValue * 100).round()}%',
                      style: TextStyle(),
                    ),
                  ],
                ),
              );
  }

  void _updateProgress() {
    _showBusy();
    const oneSec = const Duration(seconds: 2, milliseconds: 500);
    Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _progressValue += 0.2;
        if (_progressValue.toStringAsFixed(1) == '1.0') {
          _loading = false;
          final snackBar = SnackBar(
              content: Text('Совпадений не найдено'),
              action: SnackBarAction(
                label: 'Закрыть',
                onPressed: () {
                  // Some code to undo the change.
                },
              ));
          Scaffold.of(context).showSnackBar(snackBar);
          t.cancel();
          _progressValue = 0.0;

          return;
        }
      });
    });
  }

  void _showBusy() {
    _showBusyInd = !_showBusyInd;
    const oneSec = const Duration(milliseconds: 200);
    int _start = 10;
    Timer.periodic(oneSec, (Timer t) {
      setState(() {
        if (_start == 0) {
          _showBusyInd = false;
          t.cancel();
          return;
        } else {
          _start--;
        }
      });
    });
  }
}
