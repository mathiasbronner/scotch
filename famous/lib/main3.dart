import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static String clientId = "46e80b25e8814b6390bc5ccbf68d9a05";
  static String redirectUrl = "https://beta.dplay.no";
  String url = "https://api.instagram.com/oauth/authorize/?client_id=$clientId&redirect_uri=$redirectUrl&response_type=token";

  String url2 = "http://192.168.1.155:8080/checkout";

  String _ipAddress = 'Unknown';

  launchWebView(String url) async {
    var flutterWebviewPlugin = new FlutterWebviewPlugin();

    flutterWebviewPlugin.launch(url2);

    // Wait in this async function until destroy of WebView.
    await flutterWebviewPlugin.onDestroy.first;
  }

  //Future<Token> getToken(String appId, String appSecret) async {
  //  final FlutterWebviewPlugin webviewPlugin = new FlutterWebviewPlugin();
  //  webviewPlugin.launch(url, fullScreen: true);

  //  webviewPlugin.close();
 // }

  _getIPAddress() async {
    launchWebView(url);

    String ip = "u tell me";
    // If the widget was removed from the tree while the message was in flight,
    // we want to discard the reply rather than calling setState to update our
    // non-existent appearance.
    if (!mounted) return;

    setState(() {
      _ipAddress = ip;
    });
  }


  @override
  Widget build(BuildContext context) {
    var spacer = new SizedBox(height: 32.0);

    return new Scaffold(
      body: new Center(
        child: new Column(
          children: <Widget>[
            spacer,
            new Text('Your current IP address is:'),
            new Text('$_ipAddress.'),
            spacer,
            new RaisedButton(
              onPressed: _getIPAddress,
              child: new Text('Get IP address'),
            ),
          ],
        ),
      ),
    );
  }
}
