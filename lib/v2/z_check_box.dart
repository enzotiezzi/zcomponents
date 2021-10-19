import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:z_components/v2/z_theme.dart';

class ZCheckBox extends StatefulWidget {
  final String label;
  final void Function(bool) onChange;
  final ZTextAlignment textAlignment;

  const ZCheckBox(
      {Key key,
      @required this.label,
      this.onChange,
      this.textAlignment: ZTextAlignment.start})
      : assert(label != null),
        super(key: key);

  @override
  _ZCheckBoxState createState() => _ZCheckBoxState();
}

class _ZCheckBoxState extends State<ZCheckBox> {
  bool _currentValue = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(4.0),
        child: _buildBody(context),
      ),
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget _buildBody(BuildContext context) {
    List<Widget> widgets = [];
    var text = Text(widget.label);

    var checkbox = Theme(
      data: ThemeData(
        unselectedWidgetColor: ZTheme.primaryColor
      ),
      child: Checkbox(
        onChanged: (bool value) {
          setState(() {
            _currentValue = value;
          });

          if (widget.onChange != null) widget.onChange(value);
        },
        value: _currentValue,
        activeColor: Colors.white,
        checkColor: ZTheme.primaryColor,
      ),
    );

    widgets.add(checkbox);

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

enum ZTextAlignment { start, end }
