import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../main.dart';

void main() => runApp(WebViewExample());

class WebViewExample extends StatefulWidget {
  @override
  WebViewExampleState createState() {
    MyFirstApp.analytics.logEvent(name: 'lab3_2_opened', parameters: null);
    return WebViewExampleState();
  }
}

class WebViewExampleState extends State<WebViewExample> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://ru.myfin.by/currency/moskva',
    );
  }
}
