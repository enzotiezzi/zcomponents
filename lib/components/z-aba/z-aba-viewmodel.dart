import 'package:flutter/cupertino.dart';

class ZAbaViewModel {
  String titulo;
  Function onTap;
  Icon icon;

  ZAbaViewModel({@required this.onTap, @required this.titulo,this.icon});
}
