import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('samples.flutter.dev/oneLogin');
  String _response = 'nothing';

  void _clearText() {
    setState(() {
      _response = 'nothing';
    });
  }

  Future<void> _getSignIn() async {
    try {
      final int result = await platform.invokeMethod('getSignIn');
      print(result);
    } on PlatformException catch (e) {
      print('ERR ${e.message}');
    }
  }

  Future<void> _getInfo() async {
    try {
      final int result = await platform.invokeMethod('getInfo');
      print(result);
    } on PlatformException catch (e) {
      print('ERR ${e.message}');
    }
  }

  Future<void> _getToken() async {
    try {
      final int result = await platform.invokeMethod('getToken');
      print(result);
    } on PlatformException catch (e) {
      print('ERR ${e.message}');
    }
  }

  Future<void> _signOut() async {
    try {
      final int result = await platform.invokeMethod('signOut');
      print(result);
    } on PlatformException catch (e) {
      print('ERR ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () => _getSignIn(),
              child: Text('Sign in'),
            ),
            RaisedButton(
              onPressed: () => _getInfo(),
              child: Text('Show user Info'),
            ),
            RaisedButton(
              onPressed: () => _getToken(),
              child: Text('Check Token'),
            ),
            RaisedButton(
              onPressed: () => _signOut(),
              child: Text('Sign out'),
            ),
            Text(
              'Response:',
            ),
            Text(
              _response,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _clearText,
        tooltip: 'Increment',
        child: Icon(Icons.reset_tv),
      ),
    );
  }
}
