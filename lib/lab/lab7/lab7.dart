import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'dart:async';

class LabSeventh extends StatefulWidget {
  @override
  _LabSeventhState createState() => _LabSeventhState();
}

Future sleep1() {
  return new Future.delayed(const Duration(seconds: 1), () => "1");
}

class _LabSeventhState extends State<LabSeventh> {
  int _index;
  String _botReply = '';
  final GlobalKey<AnimatedListState> _listkey = GlobalKey();
  List<String> _data = [];
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://chatbot-flutterproject.herokuapp.com/echo'),
  );
  TextEditingController queryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AnimatedList(
            key: _listkey,
            initialItemCount: _data.length,
            itemBuilder:
                (BuildContext context, int index, Animation animation) {
              return buildItem(_data[index], animation, index);
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ColorFiltered(
              colorFilter: ColorFilter.linearToSrgbGamma(),
              child: Container(
                  color: Colors.grey,
                  child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextField(
                        decoration: InputDecoration(
                            icon: Icon(Icons.message),
                            hintText: "Write something"),
                        controller: queryController,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (msg) {
                          this.getResponse();
                        },
                      ))),
            ),
          ),
          StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _botReply = snapshot.data;
                print(_botReply);
                print(snapshot.data);
                // _data.add(snapshot.data);
                // _listkey.currentState.insertItem(_data.length - 1);

              }
              return Text('');
            },
          )
        ],
      ),
    );
  }

  void getResponse() async {
    if (queryController.text.length > 0) {
      this.insertSingleItem(queryController.text.toString());

      try {
        channel.sink.add(queryController.text.toString());
        queryController.text = '';
      } finally {}
      await Future<void>.delayed(Duration(seconds: 1));
      if (_botReply != '') {
        insertSingleItem(_botReply + "<bot>");
      }
    }
  }

  void insertSingleItem(String message) {
    _data.add(message);
    _listkey.currentState.insertItem(_data.length - 1);
  }
}

Widget buildItem(String item, Animation animation, int index) {
  bool mine = item.endsWith("<bot>");
  return SizeTransition(
    sizeFactor: animation,
    child: Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        alignment: mine ? Alignment.topLeft : Alignment.topRight,
        child: Bubble(
          child: Text(
            item.replaceAll("<bot>", ""),
            style: TextStyle(color: mine ? Colors.white : Colors.black),
          ),
          color: mine ? Colors.blue : Colors.grey[200],
          padding: BubbleEdges.all(8),
          nip: mine ? BubbleNip.leftTop : BubbleNip.rightTop,
        ),
        padding: EdgeInsets.all(5),
      ),
    ),
  );
}
