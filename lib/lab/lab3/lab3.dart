// Для выполнения лабораторной работы использовался открытый парсер app.quicktype.io
// Парсился данный файл https://www.cbr-xml-daily.ru/daily_json.js
import 'dart:async';
// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'parse_currency.dart';
import 'parser.dart';

class LabThird extends StatefulWidget {
  @override
  LabThird1 createState() => LabThird1();
}

class LabThird1 extends State<LabThird> {
  Currency _currency;
  bool _loading;
  @override
  void initState() {
    super.initState();
    _loading = true;
    Parser.getUsers().then((currency) {
      _currency = currency;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'грузит' : 'загрузило'),
      ),
      body: Container(child: ListView.builder(
        itemBuilder: (context, index) {
          Currency currency = _currency;
          return ListTile(
            title: Text(currency.valute[index].name),
            subtitle: Text(
                // currency.valute[index].value.toString()
                currency.valute[index].name),
          );
        },
      )
          // child: FutureBuilder(
          //   future: futureAlbum,
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.done) {
          //       return Text(snapshot.data.title);
          //     } else if (snapshot.hasError) {
          //       return Text("${snapshot.error}");
          //     }

          //     // By default, show a loading spinner.
          //     return CircularProgressIndicator();
          //   },
          // ),
          ),
    );
  }
}

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
