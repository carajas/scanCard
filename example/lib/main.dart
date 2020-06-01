import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:core_card_io/core_card_io.dart';

Map<dynamic, dynamic> details;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = "";
      details = await CoreCardIo.scanCard({
        "hideCardIOLogo": true,
        "requireExpiry": true,
        "scanExpiry": true,
        "requireCVV": true,
        "requireCardHolderName": true,
        "scanInstructions": "tes test teste",
        "suppressConfirmation": false,
        "suppressManualEntry": false
      });
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Text('Running on: $_platformVersion\n'),
            ),
            FlatButton(
                onPressed: initPlatformState,
                color: Colors.green,
                child: Text("cartão")
            ),
            FlatButton(
                onPressed: (){
                  print(details);
                },
                color: Colors.green,
                child: Text("dados")
            ),
          ],
        ),
      ),
    );
  }
}
