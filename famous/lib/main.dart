
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter WebView Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter WebView Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Instance of WebView plugin
  final FlutterWebviewPlugin flutterWebviewPlugin = new FlutterWebviewPlugin();

  // On destroy stream
  StreamSubscription _onDestroy;

  // On urlChanged stream
  StreamSubscription<String> _onUrlChanged;

  TextEditingController _ctrl =
  new TextEditingController(text: "https://flutter.io");
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  final _history = [];

  @override
  initState() {
    super.initState();

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      if (mounted) {
        // Actions like show a info toast.
        _scaffoldKey.currentState
            .showSnackBar(new SnackBar(content: new Text("Webview Destroyed")));
      }
    });

    // Add a listener to on url changed
    //flutterWebviewPlugin.
    print("KORV");
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print("KORV2");
      print(url);
      if (mounted) {
        setState(() {
          _history.add(url);
        });
      }
    });
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy?.cancel();
    _onUrlChanged?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('Plugin example app'),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Container(
            padding: const EdgeInsets.all(24.0),
            child: new TextField(controller: _ctrl),
          ),
          new RaisedButton(
            onPressed: _onPressed,
            child: new Text("Open Webview"),
          ),
          new Text(_history.join(", "))
        ],
      ),
    );
  }

  void _onPressed() {
    try {
      // This way you launch WebView with an url as a parameter.
       String clientId = "46e80b25e8814b6390bc5ccbf68d9a05";
      String redirectUrl = "https://beta.dplay.no";
      String url = "https://api.instagram.com/oauth/authorize/?client_id=$clientId&redirect_uri=$redirectUrl&response_type=token";
      flutterWebviewPlugin.launch(url);
    } catch (e) {
      print(e);
    }
  }
}
