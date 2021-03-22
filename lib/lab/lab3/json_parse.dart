// Для выполнения лабораторной работы использовался открытый парсер app.quicktype.io
// Парсился данный файл https://www.cbr-xml-daily.ru/daily_json.js
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'parse_currency.dart';

void main() async {
  Currency _data = await getJson();
  print(_data);
}

void _showDialogBox(BuildContext context, String message, String t) {
  var alert = new AlertDialog(
    title: new Text(t),
    content: new Text(message),
    actions: <Widget>[
      new FlatButton(
        child: new Text("OK"),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ],
  );

  showDialog(context: context, builder: (context) => alert);
}

Future<Currency> getJson() async {
  Uri apiUrl = Uri.parse('https://www.cbr-xml-daily.ru/daily_json.js');

  http.Response response = await http.get(apiUrl);
  print(response.body);
  print(currencyFromJson(response.body).valute['USD'].name);
  return currencyFromJson(response.body);
}

class LabThird extends StatefulWidget {
  Uri url;
  LabThird({Uri url}) : url = url;
  @override
  LabThird1 createState() => LabThird1();
}

class LabThird1 extends State<LabThird> {
  Currency _data;
  bool _loading = true;

  @override
  void initState() {
    getJson().then((value) {
      setState(() {
        _data = value;
        _loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(child: CircularProgressIndicator())
        : new Scaffold(
            appBar: new AppBar(
              title: new Text(
                  'Курсы валют за ${_data.date.toString().substring(0, 10)}'),
              centerTitle: true,
            ),
            // body: Center(),
            body: ListView.builder(
              itemCount: 15,
              itemBuilder: (BuildContext context, int position) {
                String key = _data.valute.keys.elementAt(position);
                if (position.isOdd) return new Divider();

                //TITLE DATA
                return ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 7.0),
                  title: Text(
                    "${_data.valute[key].name}",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),

                  //CIRCLE AVATAR LETTER
                  leading: new CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    maxRadius: 30.0,
                    child: Text(
                      "${_data.valute[key].name.substring(0, 3)}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),

                  onTap: () {
                    _showDialogBox(context, "${_data.valute[key].name}",
                        "${_data.valute[key].value}");
                  },

                  //BODY DATA
                  subtitle: Text(
                    "${_data.valute[key].value}",
                    style: TextStyle(fontSize: 18.0),
                  ),
                );
              },
            ),
          );
  }
}
