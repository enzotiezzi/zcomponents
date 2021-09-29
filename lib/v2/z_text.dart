import 'package:flutter/widgets.dart';

class ZText extends Text {
  final TextAlign textAlign;

  ZText(String data, {this.textAlign}) : super(data, textAlign: textAlign);
}