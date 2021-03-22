// Для выполнения лабораторной работы использовался открытый парсер app.quicktype.io
// Парсился данный файл https://www.cbr-xml-daily.ru/daily_json.js
import 'dart:async';
// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'parse_currency.dart';
// import 'parser.dart';

class LabThird extends StatefulWidget {
  Uri url;
  LabThird({Uri url}) : url = url;
  @override
  LabThird1 createState() => LabThird1();
}

class LabThird1 extends State<LabThird> {
  Currency _currency;
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    _loading = false;
    getUsers().then((currency) {
      setState(() {
        _currency = currency;
      });

      // print(_currency.valute.length);
      return currency;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: ListView.builder(
        // itemCount: _currency.valute.length,
        itemBuilder: (context, index) {
          Currency currency = _currency;
          if (currency != null) {
            return ListTile(
                title: Text(_currency.valute['USD'].name),
                subtitle: Text(''
                    // currency.valute[index].value.toString()
                    // currency.valute['USD'].value.toString(),
                    ));
          }
          return CircularProgressIndicator();
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

  Future<Currency> getUsers() async {
    print('AAAAAAAAAAAAAAAAAA');

    try {
      print('asd');
      final http.Response response = await http.get(Uri.https(
          'www.openexchangerates.org',
          '/api/latest.json?app_id=7e5c28bc30ff4d81b47a623b7f98295c'));
      print('smth');
      print(response.body);
      if (response.statusCode == 200) {
        print('succ');
        final Currency currency = currencyFromJson(response.body);

        return currency;
      } else {
        print('ЭТО ЭЛСЕ');
        return Currency();
      }
    } catch (e) {
      print(e);
      print('ЭТО ЭКСПЕШН ЕПТА');
      return Currency();
    }
  }
}

Future<http.Response> fetchAlbum() {
  return http.get(Uri.https('cbr-xml-daily.ru', '/daily_json.js'));
}
