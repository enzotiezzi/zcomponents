import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZSearchBar extends StatefulWidget {
  final GlobalKey key;

  ZSearchBar({this.key}) : super(key: key);

  @override
  ZSearchBarState createState() => ZSearchBarState();
}

class ZSearchBarState extends State<ZSearchBar> {
  @override
  Widget build(BuildContext context) {
    return _buildSearchBar();
  }

  Widget _buildSearchBar() {
    return new Material(
        elevation: 5,
        child: new Row(
          children: <Widget>[
            new Expanded(
              flex: 85,
              child: new Container(
                margin: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                child: new Container(
                  margin: EdgeInsets.only(left: 16, right: 2),
                  decoration: BoxDecoration(
                      color: Color(0xfff0f0f0),
                      borderRadius: BorderRadius.all(Radius.circular(9.0))),
                  child: new Row(
                    children: <Widget>[
                      new Container(
                          padding: EdgeInsets.only(left: 8.0),
                          child: new Icon(
                            Icons.search,
                            color: Color(0xff999999),
                          )),
                      new Expanded(
                          child: new CupertinoTextField(
                        placeholderStyle: new TextStyle(
                            color: Color(0xff999999), fontSize: 17),
                        keyboardType: TextInputType.text,
                        placeholder: "Busca",
                        decoration:
                            new BoxDecoration(color: Colors.transparent),
                      )),
                    ],
                  ),
                ),
              ),
            ),
            new Expanded(
                flex: 15,
                child: new IconButton(
                    icon: new Icon(
                      Icons.filter_list_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {}))
          ],
        ));
  }
}
