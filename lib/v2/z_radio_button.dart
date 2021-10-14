import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:z_components/v2/z_check_box.dart';
import 'package:z_components/v2/z_theme.dart';

class ZRadioButton<T> extends StatefulWidget {
  final String label;
  final ValueChanged<dynamic> onChanged;
  final ZTextAlignment textAlignment;
  final T groupValue;
  final T value;

  const ZRadioButton(
      {Key key,
      @required this.label,
      this.textAlignment: ZTextAlignment.start,
      @required this.onChanged,
      @required this.groupValue,
      @required this.value})
      : assert(label != null, groupValue != null),
        super(key: key);

  @override
  _ZRadioButtonState createState() => _ZRadioButtonState<T>();
}

class _ZRadioButtonState<T> extends State<ZRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(4.0),
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    List<Widget> widgets = [];
    var text = Text(widget.label);

    widgets.add(Radio<T>(
      value: widget.value,
      groupValue: widget.groupValue,
      fillColor: MaterialStateProperty.all<Color>(ZTheme.primaryColor),
      onChanged: (T value){
        if(widget.onChanged != null)
          widget.onChanged(value);
      },
    ));

    switch (widget.textAlignment) {
      case ZTextAlignment.start:
        widgets.insert(0, text);
        break;
      case ZTextAlignment.end:
        widgets.add(text);
        break;
    }

    return Row(
      children: widgets,
    );
  }
}
