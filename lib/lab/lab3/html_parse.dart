import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:flutter_html/flutter_html.dart';

class MyForm extends StatefulWidget {
  final String url;
  MyForm({String url}) : url = url;
  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State {
  String _body;
  bool isRaw;
  final myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    isRaw = true;
    _body = 'nothing here';
    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(10.0),
                child: new Form(
                    key: _formKey,
                    child: new Column(
                      children: <Widget>[
                        new Text(
                          'Html:',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        new TextFormField(
                          validator: (value) {
                            if (value.isEmpty) return 'Введите адрес';
                          },
                          controller: myController,
                        ),
                        new SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            new RaisedButton(
                              onPressed: () async {
                                catchHTML(myController.text).then((value) {
                                  setState(() {
                                    isRaw = true;
                                    _body = value;
                                  });
                                });
                              },
                              child: Text('HTML raw'),
                            ),
                            new RaisedButton(
                              onPressed: () async {
                                catchHTML(myController.text).then((value) {
                                  setState(() {
                                    _body = value;
                                    isRaw = false;
                                  });
                                });
                              },
                              child: Text('HTML parse'),
                            ),
                          ],
                        ),
                        Center(
                          child: _body.length < 0
                              ? Text('nothing here')
                              : isRaw
                                  ? Text(_body)
                                  : Html(data: _body),
                        )
                      ],
                    )))));
  }

  Future catchHTML(String value) async {
    http.Response response = await http.get(Uri.parse(value));
    //If the http request is successful the statusCode will be 200
    if (response.statusCode == 200) {
      String htmlToParse = response.body;
      return htmlToParse;
    }
  }

  Future catchHTMLParsed(String value) async {
    print(0);
  }
}
