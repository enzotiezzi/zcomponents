import 'package:flutter/cupertino.dart';

class ZRadioItem {
  String description;
  String value;
  bool checked;

  ZRadioItem({@required this.description, @required this.value, this.checked: false});
}