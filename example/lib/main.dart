import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter/services.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/components/z-float-button.dart';
import 'package:z_components/config/z-platform.dart';
import 'package:z_components/components/z-size.dart';
import 'package:z_components/components/z_switch.dart';
import 'package:z_components/components/z_picker.dart';
import 'package:z_components/components/z_tabbar.dart';
import 'package:z_components/components/z_button.dart';
import 'package:z_components/components/z_loading.dart';

import 'package:z_components/components/z_navigationbar.dart';
import 'package:z_components/components/z_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:provider/provider.dart';

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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: ChangeNotifierProvider<AppSwitch>(
            builder: (_) => AppSwitch(),
            child: Home()),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate, // if it's a RTL language
        ],
        supportedLocales: [
        if(Platform.isIOS)
          const Locale('en', 'US')
        ,
        if(Platform.isAndroid)
          const Locale('pt','BR'),
        ]
      ,
    );
  }
}

class Home extends StatelessWidget {
  bool value = false;
  int index = 0;
  
  @override
  Widget build(BuildContext context) {
    final appSwitch = Provider.of<AppSwitch>(context);
    
    return Scaffold(
      floatingActionButton: ZFloatButton(
        onPressed: () {},
      ),
      appBar: new ZNavigationBar(
        middle: new Text(
          "ZComponets",
          style: new TextStyle(color: Colors.white),
        ),
        title: new Text(
          "ZComponets",
          style: new TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: new ListView(
        children: <Widget>[
          new Column(children: <Widget>[
            
            new Container(
              child: ZTextField(
              onChanged: (text) => appSwitch.text = text,
            ),padding: EdgeInsets.all(8),),
            ZSwitch(value: appSwitch.value, onChanged: (b) {
              appSwitch.value = b;
            }),
            ZButton(
                child: Text(
                  'Show Date Picker!',
                  style: new TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  new ZPicker(
                    context: context,
                    initialDate: DateTime.now(),
                    lastDate: DateTime(2090),
                    firstDate: DateTime(1090),
                    onTimerDurationChanged: (date) {
                      date;
                    },
                  );
                }),
    new ZSize(context: context,child: ZButton(
              child: Text(
                "Dialog",
                style: new TextStyle(color: Colors.white),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                ZAlertDialog(
                          actionsCupertino: <Widget>[
                            new ZButton(onPressed: () {})],
                          title: Text("Dialog Teste:"),
                          actions: <Widget>[
                            ZButton(
                              color: const Color(0xffF7F7F7),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: new Text(
                                "OK",
                                style: new TextStyle(color: Colors.teal),
                              ),
                            )
                          ],
                        ));
              },
            ),quadrado: false,percentWidth: 90,percentHeight: 10,maxHeight: 30,),
            new ZLoading(zPlatform: ZPlatform.isAndroid,),
            Text(appSwitch.text),
            
            new Row(children: <Widget>[
              new ZSize(
                context: context,
                child: new ZButton(
                child: Text(
                  "Dialog",
                  style: new TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          ZAlertDialog(
                            actionsCupertino: <Widget>[
                              new ZButton(onPressed: () {})],
                            title: Text("Dialog Teste:"),
                            actions: <Widget>[
                              ZButton(
                                color: const Color(0xffF7F7F7),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: new Text(
                                  "OK",
                                  style: new TextStyle(color: Colors.teal),
                                ),
                              )
                            ],
                          ));
                },
              ),
                  percentHeight: 10,
                  maxHeight: 50,
                  maxWidth: 500,
                  padding: EdgeInsets.all(5),
                  percentWidth: 30,
              ),
              new ZSize(context: context,
                child: new ZButton(
                child: Text(
                  "Dialog",
                  style: new TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          ZAlertDialog(
                            actionsCupertino: <Widget>[
                              new ZButton(onPressed: () {})],
                            title: Text("Dialog Teste:"),
                            actions: <Widget>[
                              ZButton(
                                color: const Color(0xffF7F7F7),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: new Text(
                                  "OK",
                                  style: new TextStyle(color: Colors.teal),
                                ),
                              )
                            ],
                          ));
                },
              ),
                  percentWidth: 33.33,
                  percentHeight: 10,
                  maxHeight: 30,
              ),
              new ZSize(
                context: context,
                child: new ZButton(
                child: Text(
                  "Dialog",
                  style: new TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          ZAlertDialog(
                            actionsCupertino: <Widget>[
                              new ZButton(onPressed: () {})],
                            title: Text("Dialog Teste:"),
                            actions: <Widget>[
                              ZButton(
                                color: const Color(0xffF7F7F7),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: new Text(
                                  "OK",
                                  style: new TextStyle(color: Colors.teal),
                                ),
                              )
                            ],
                          ));
                },
              ),
                  percentWidth: 33.33,
                  percentHeight: 100,
                  maxHeight: 50,
                  padding: EdgeInsets.all(5),
                ),
            ],)
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

class AppSwitch with ChangeNotifier {

AppSwitch();

bool _value = false;
String _text = "";

set value(bool text) {
  _value = text;
  notifyListeners();
}

bool get value => _value;

set text(String text) {
  _text = text;
  notifyListeners();
}

String get text => _text;

}
