import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/components/z-collection-item.dart';
import 'package:z_components/components/z-float-button.dart';
import 'package:z_components/config/z-button-type.dart';
import 'package:z_components/config/z-platform.dart';
import 'package:z_components/config/z-mask.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/components/z-size.dart';
import 'package:z_components/components/z_switch.dart';
import 'package:z_components/components/z_picker.dart';
import 'package:z_components/components/z_tabbar.dart';
import 'package:z_components/components/z_button.dart';
import 'package:z_components/components/z_loading.dart';
import 'package:z_components/components/z-baseline.dart';
import 'package:z_components/components/z_navigationbar.dart';
import 'package:z_components/components/z_text_field.dart';
import 'package:z_components/components/z-collection.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xff2BBAB4),
        accentColor: const Color(0xff2BBAB4),
        splashColor: const Color(0xff2BBAB4),
      ),
      home: ChangeNotifierProvider<AppSwitch>(
          builder: (_) => AppSwitch(), child: Home()),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate, // if it's a RTL language
      ],
      supportedLocales: [
        if (Platform.isIOS) const Locale('en', 'US'),
        if (Platform.isAndroid) const Locale('pt', 'BR'),
      ],
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
        //middle: IOS
        middle: new Text(
          "ZComponets",
          style: new TextStyle(color: Colors.white),
        ),
        //title: ANDROID
        title: new Text(
          "ZComponets",
          style: new TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: new ListView(
        children: <Widget>[
          new Column(children: <Widget>[
            new ZCollection(
              titulo: "Estados",
              lista: ["Azerbaifodase", "Ibirapufodase"]
                  .map(
                      (x) => new ZCollectionItem(chave: x, titulo: x, valor: x))
                  .toList(),
              onChange: (item) {
                if(item != null)
                  print(item.valor);
              },
            ),
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
