import 'package:flutter/material.dart';
import 'package:z_components/v2/z_theme.dart';

class ZOutLinedButton extends StatefulWidget {
  final String text;
  final void Function() onPressed;

  const ZOutLinedButton(
      {Key key, @required this.text, @required this.onPressed})
      : assert(text != null, onPressed != null),
        super(key: key);

  @override
  _ZOutLinedButtonState createState() => _ZOutLinedButtonState();
}

class _ZOutLinedButtonState extends State<ZOutLinedButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: OutlinedButton(
        onPressed: widget.onPressed,
        child: new Text(widget.text ?? ""),
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(color: ZTheme.primaryColor))),
      ),
    );
  }
}
