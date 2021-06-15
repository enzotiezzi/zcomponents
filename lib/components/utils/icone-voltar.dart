import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:z_components/components/utils/svg.dart';

class IconeVoltar extends StatefulWidget {
  final BuildContext context;
  final Function onTap;

  IconeVoltar({this.context, this.onTap});

  @override
  _IconeVoltarState createState() => _IconeVoltarState();
}

class _IconeVoltarState extends State<IconeVoltar> {
  Function onTapVoltar() {
    if (widget.onTap == null) {
      return () {
        Navigator.of(context).pop();
      };
    } else {
      return widget.onTap;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new IconButton(
        icon: SvgPicture.asset(
          SvgUtils.ASSETLEFTICON,
          semanticsLabel: "leftIcon.svg",
          placeholderBuilder: (context) => Icon(Icons.error),
        ),
        onPressed: onTapVoltar());
  }
}
