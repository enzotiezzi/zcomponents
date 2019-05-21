import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter/services.dart';
import 'package:z_components/z-alert-dialog.dart';
import 'package:z_components/z-float-button.dart';
import 'package:z_components/z_switch.dart';
import 'package:z_components/z_picker.dart';
import 'package:z_components/z_tabbar.dart';
import 'package:z_components/z_button.dart';
import 'package:z_components/z_loading.dart';


import 'package:z_components/z_navigationbar.dart';
import 'package:z_components/z_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

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
    return MaterialApp(
      theme: ThemeData(),
      home: Home(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate, // if it's a RTL language
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('ru', 'RU'),
      ],
    );
  }
}

class Home extends StatelessWidget {
  bool value = false;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ZFloatButton(
        onPressed: () {},
      ),
      appBar: new ZNavigationBar(
        title: new Text("teste"),
        centerTitle: true,
      ),
      body: new ListView(
        children: <Widget>[
          new Column(children: <Widget>[
            ZTextField(),
            ZSwitch(value: value, onChanged: (b) {}),
            ZButton(
                child: Text(
                  'Show Date Picker!',
                  style: new TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  new ZPicker(
                    context: context,
                    onTimerDurationChanged: (date) {
                      date;
                    },
                  );
                }),
            ZButton(
              child: Text("Dialog",style: new TextStyle(color: Colors.white),),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => ZAlertDialog(
                      actionsCupertino: <Widget>[
                      new ZButton(onPressed: (){})
                    ],
                          title: Text("Dialog Teste:"),
                          actions: <Widget>[
                            ZButton(
                              color: const Color(0xffF7F7F7),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: new Text("OK",style: new TextStyle(color: Colors.teal),),
                            )
                          ],
                        ));
              },
            ),
            ZLoading(),
          ]),
        ],
      ),
      bottomNavigationBar: ZtabBar(
        backgroundColor: Colors.teal,
        items: <BottomNavigationBarItem>[
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
        onTap: (index) => this.index = index,
        currentIndex: 0,
        iconSize: 16,
        inactiveColor: Colors.red,
        activeColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black45,
        // currentIndex: _selectedIndex,
      ),
    );
  }
}
