import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LabEigth extends StatefulWidget {
  const LabEigth({Key key}) : super(key: key);

  @override
  _LabEigthState createState() => _LabEigthState();
}

class _LabEigthState extends State<LabEigth> {
  String token = '';
  String message = '';
  String errcode = '';
  String time = '';
  String public = '';
  Uint8List image;
  Map jsonMap = {'username': 'fuckradyan', 'password': 'poop123'};
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(15),
        child: Center(
          child: Column(
            children: [
              OutlineButton(
                onPressed: () async {
                  apiRequest('https://jwt-flutterproj.herokuapp.com/login',
                          jsonMap)
                      .then((response) {
                    setState(() {
                      token = json.decode(response)['token'];
                    });
                    print(token);
                  });
                },
                child:
                    Text('Аутентифицироваться', style: TextStyle(fontSize: 17)),
              ),
              Text('JWT-токен: ', style: TextStyle(fontSize: 20)),
              Padding(padding: EdgeInsets.all(5)),
              Text(token == '' ? 'Тут пусто :(' : token),
              Padding(padding: EdgeInsets.all(10)),
              OutlineButton(
                onPressed: () async {
                  getPublic().then((response) {
                    if (response != null) {
                      setState(() {
                        public =
                            'Сообщение: ' + json.decode(response)['message'];
                        errcode = '';
                      });
                    }
                  });
                },
                child: Text('Получить публичную информацию',
                    style: TextStyle(fontSize: 15)),
              ),
              OutlineButton(
                onPressed: () async {
                  getPrivate(token).then((response) {
                    if (response != null) {
                      setState(() {
                        errcode = '';
                        public = '';
                        image = base64.decode(json.decode(response)['img']);
                        time = json.decode(response)['time'];
                        message = 'Сообщение: ' +
                            json.decode(response)['message'] +
                            '\n\n';
                        message += '\n Время: $time';
                      });
                    }
                  });
                },
                child: Text('Получить приватную информацию',
                    style: TextStyle(fontSize: 15)),
              ),
              Text('Ответ сервера: ', style: TextStyle(fontSize: 20)),
              Padding(padding: EdgeInsets.all(5)),
              Column(children: [
                if (errcode != '')
                  Text(errcode)
                else if (public != '')
                  Text(public, style: TextStyle(fontSize: 15))
                else if (image == null)
                  Text('тут тоже :(')
                else
                  Column(
                    children: [
                      Text(message, style: TextStyle(fontSize: 15)),
                      Container(
                        padding: EdgeInsets.only(top: 12),
                        child: Image.memory(image),
                      ),
                    ],
                  )
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> apiRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }

  Future<String> getPrivate(String token) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(
        'https://jwt-flutterproj.herokuapp.com/protected?token=$token'));
    HttpClientResponse response = await request.close();
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      httpClient.close();
      return reply;
    } else {
      print(response);
      String reply = await response.transform(utf8.decoder).join();
      httpClient.close();
      setState(() {
        errcode = json.decode(reply)['message'];
        print(errcode);
      });
    }
  }

  Future<String> getPublic() async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient
        .getUrl(Uri.parse('https://jwt-flutterproj.herokuapp.com/unprotected'));
    HttpClientResponse response = await request.close();
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      httpClient.close();
      return reply;
    } else {
      return 'error';
    }
  }
}
