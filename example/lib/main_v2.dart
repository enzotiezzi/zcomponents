import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/v2/z_icon.dart';
import 'package:z_components/v2/z_text.dart';
import 'package:z_components/v2/z_input_field/z_input_field_text.dart';
import 'package:z_components/v2/z_outlined_button.dart';
import 'package:z_components/v2/z_check_box.dart';
import 'package:z_components/v2/z_radio_button.dart';

class MainV2 extends StatefulWidget {
  const MainV2({Key key}) : super(key: key);

  @override
  _MainV2State createState() => _MainV2State();
}

class _MainV2State extends State<MainV2> {
  var textController1 = new TextEditingController();
  var textController2 = new TextEditingController();

  String _groupValue = "Teste";

  @override
  Widget build(BuildContext context) {
    return MainStyle.get(context).getDefaultScaffold("V2", _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ZInpuFieldText(
          textEditingController: textController1,
          label: "Label",
          placeHolder: "Texto aqui",
          leadingIcon: ZIcon(Icons.search),
          preffix: ZText("R\$"),
          suffix: ZText(
            "grs.",
            textAlign: TextAlign.end,
          ),
          trailingIcon: ZIcon(Icons.search),
          supportingText: "Preencha tudo",
          characterCounter: true,
          validations: (value) {
            if (value.isEmpty) return "Texto não pode estar vázio";

            return null;
          },
        ),
        ZInpuFieldText(
          textEditingController: textController2,
          label: "Label 2",
          placeHolder: "Texto aqui",
          leadingIcon: ZIcon(Icons.search),
          preffix: ZText("R\$"),
          suffix: ZText(
            "grs.",
            textAlign: TextAlign.end,
          ),
          trailingIcon: ZIcon(Icons.search),
          supportingText: "Preencha tudo",
          validations: (value) {
            if (value.isEmpty) return "Texto não pode estar vázio";

            return null;
          },
        ),
        ZOutLinedButton(
          text: "Button",
          onPressed: () {},
        ), ZCheckBox(
          label: "Teste",
        ),
        ZCheckBox(
          label: "Teste",
          textAlignment: ZTextAlignment.end,
        ),
        ZRadioButton<String>(
          label: "Teste1",
          textAlignment: ZTextAlignment.end,
          groupValue: _groupValue,
          value: "Teste1",
          onChanged: (value){
            setState(() {
              _groupValue = value;
            });
          },
        ),
        ZRadioButton<String>(
          label: "Teste2",
          groupValue: _groupValue,
          value: "Teste2",
          onChanged: (value){
            setState(() {
              _groupValue = value;
            });
          },
        )
      ],
    );
  }
}
