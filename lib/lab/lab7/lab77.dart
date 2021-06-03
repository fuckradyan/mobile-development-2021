// main.dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(MyApplication());
}

class MyApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This list holds the conversation
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://chatbot-flutterproject.herokuapp.com/echo'),
  );
  List<Map<String, String>> _chatMessages = [];

  // More messages added to the _chatMessages over time
  Stream<List<Map<String, String>>> _chat(
      String message, String whoami) async* {
    channel.sink.add('Hello!');
    _chatMessages
        .add({"user_name": whoami == "bot" ? "bot" : "me", "message": message});
    yield _chatMessages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: StreamBuilder(
          stream: _chat("nigga", 'nigga'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(
                      snapshot.data[index]["user_name"],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    title: Text(
                      snapshot.data[index]["message"],
                      style: TextStyle(
                          fontSize: 20,
                          color: snapshot.data[index]['user_name'] == 'bot'
                              ? Colors.pink
                              : Colors.blue),
                    ),
                  );
                },
              );
            }
            return LinearProgressIndicator();
          },
        ),
      ),
    );
  }
}
