import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ZAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  //tamanho da app bar
  Size get preferredSize => Size(double.infinity, tamanho());
  Widget card;
  bool expandable;
  String texto = "texto de teste";
  String title = "Dashboard";
  String assets;


  Color cor = Color(0xff2BBAB4);

  ZAppBar({this.card, @required this.texto, @required this.expandable,@required this.title, this.cor,@required this.assets });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: (!expandable)
          ? Material(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.only(
                      bottomLeft: const Radius.circular(30.0),
                      bottomRight: const Radius.circular(30.0))),
              color: cor,
              child: Container(
                child: new Column(
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        (title!=null)?
                        new Container(
                          margin: const EdgeInsets.only(
                              left: 10, top: 40, bottom: 10),
                          child: new Text(
                            "$title",
                            style: new TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ):new Container(
                          //margin: EdgeInsets.only(top: 20),
                            height: 35.0,
                            width: 35.0,
                            decoration: new BoxDecoration(
                              borderRadius:
                              new BorderRadius.all(const Radius.circular(1.0)),
                              image: DecorationImage(
                                image: new AssetImage('$assets'),
                                fit: BoxFit.scaleDown,
                              ),
                            )),
                      ],
                    ),
                    new Container(
                      margin: const EdgeInsets.only(
                          bottom: 10, left: 16, right: 16),
                      height: 0.5,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    Text(
                      "$texto",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Container(
                      child: card,
                    )
                  ],
                ),
              ))
          : Material(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.only(
                      bottomLeft: const Radius.circular(30.0),
                      bottomRight: const Radius.circular(30.0))),
              elevation: 2,
              color: cor,
              child: ConfigurableExpansionTile(
                animatedWidgetFollowingHeader: new Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 30),
                ),
                header: Expanded(
                  child: IntrinsicHeight(
                    child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 40, bottom: 10, left: 40),
                                  child: new Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () => Navigator.pop(context),
                              ),
                              (title!=null)?
                              new Container(
                                  padding: const EdgeInsets.only(
                                      top: 40, bottom: 10, left: 40),
                                  child: new Text(
                                    "$title",
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )):new Container(
                                height: 35.0,
                                width: 35.0,
                                decoration: new BoxDecoration(
                                  borderRadius:
                                  new BorderRadius.all(const Radius.circular(1.0)),
                                  image: DecorationImage(
                                    image: new AssetImage('$assets'),
                                    fit: BoxFit.scaleDown,
                                  ),
                                )),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 40, bottom: 10, left: 40),
                                child: new Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              )
                            ],
                          ),
                        ]),
                  ),
                ),
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.only(
                            bottom: 20, left: 16, right: 16),
                        height: 0.5,
                        width: MediaQuery.of(context).size.width - 80,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      (texto!=null)?
                      Container(
                          child: Text(
                        "$texto",
                        style: TextStyle(color: Colors.white),
                      )):new Container(
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10),
                        child: card,
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  double tamanho() {
    if (!expandable) {
      return 240;
    } else {
      return 340;
    }
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();

    p.lineTo(0, size.height + 6);
    p.lineTo(size.width, size.height + 5);
    p.lineTo(size.width, 0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
