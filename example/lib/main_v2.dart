import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/v2/z_icon.dart';
import 'package:z_components/v2/z_text.dart';
import 'package:z_components/v2/input_text_label.dart';

class MainV2 extends StatefulWidget {
  const MainV2({Key key}) : super(key: key);

  @override
  _MainV2State createState() => _MainV2State();
}

class _MainV2State extends State<MainV2> {
  var textController1 = new TextEditingController();
  var textController2 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MainStyle.get(context).getDefaultScaffold("V2", _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        InputTextLabel(
          textEditingController: textController1,
          label: "Label",
          leading: ZIcon(Icons.search),
          sufix: ZText(
            "grs.",
            textAlign: TextAlign.end,
          ),
          prefix: ZText("R\$"),
          trailing: ZIcon(Icons.search),
          assist: "Preencha tudo",
          showMaxLength: true,
          validator: (value) {
            if (value.isEmpty) return "Texto não pode estar vázio";

            return null;
          },
        ),
        InputTextLabel(
          textEditingController: textController2,
          label: "Label 2",
          leading: ZIcon(Icons.search),
          sufix: ZText(
            "grs.",
            textAlign: TextAlign.end,
          ),
          prefix: ZText("R\$"),
          trailing: ZIcon(Icons.search),
          assist: "Preencha tudo",
          validator: (value) {
            if (value.isEmpty) return "Texto não pode estar vázio";

            return null;
          },
        )
      ],
    );
  }
}
