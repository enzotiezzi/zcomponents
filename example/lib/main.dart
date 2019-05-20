import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:z_components/z_switch.dart';
import 'package:z_components/z_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool value = false;

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new ListView(children: <Widget>[

            ZSwitch(
                value: value,
                activeColor: Colors.teal,
                onChanged: (b) {
                  setState(() {
                    value = b;
                  });
                }),

            ZPicker(
              context: context,
            ),
        ]),
      ),
    );
  }
}
