import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:z_components/z_switch.dart';
import 'package:z_components/z_picker.dart';
import 'package:z_components/z_tabbar.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool value = false;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(), home: Home());
  }
}

class Home extends StatelessWidget {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new ListView(
          children: <Widget>[
        ZSwitch(value: value, onChanged: (b) {}),
        RaisedButton(
            child: Text('Show dialog!'),
            onPressed: () {
              new ZPicker(
                context: context,
                onTimerDurationChanged: (date) {
                  date;
                },
              );
            }),

      ]),
      bottomNavigationBar: ZtabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
        ],
        currentIndex: 0,
       iconSize: 15,
       elevation: 0.0,
       inactiveColor: Colors.red,
       activeColor: Colors.black,
       // currentIndex: _selectedIndex,
      ),
    );
  }

}
