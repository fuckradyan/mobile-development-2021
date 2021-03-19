import 'dart:async';
// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

Future makeResponse() async {
  final response =
      await http.Client().get(Uri.parse('https://github.com/JonathanMonga'));
  if (response.statusCode == 200) {
    var document = parse(response.body);
    var elements = document.getElementsByTagName('p')[0];
    return elements;
  } else {
    throw Exception();
  }
}

class LabThird extends StatefulWidget {
  @override
  LabThird1 createState() => LabThird1();
}

class LabThird1 extends State<LabThird> {
  Future futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = makeResponse();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Text(snapshot.data.title);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
// Future<Album> fetchAlbum() async {
//   final response =
//       await http.get(Uri.https('finance.rambler.ru', '/currencies/'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Album.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

// class Album {
//   final int userId;
//   final int id;
//   final String title;

//   Album({@required this.userId, @required this.id, @required this.title});

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title'],
//     );
//   }
// }

// void main() => runApp(LabThird());

// class LabThird extends StatefulWidget {
//   LabThird({Key key}) : super(key: key);

//   @override
//   LabThird1 createState() => LabThird1();
// }

// class LabThird1 extends State<LabThird> {
//   Future<Album> futureAlbum;

//   @override
//   void initState() {
//     super.initState();
//     futureAlbum = fetchAlbum();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Fetch Data Example'),
//       ),
//       body: Center(
//         child: FutureBuilder<Album>(
//           future: futureAlbum,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return Text(snapshot.data.title);
//             } else if (snapshot.hasError) {
//               return Text("${snapshot.error}");
//             }

//             // By default, show a loading spinner.
//             return CircularProgressIndicator();
//           },
//         ),
//       ),
//     );
//   }
// }
