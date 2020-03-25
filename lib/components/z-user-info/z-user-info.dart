import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-baseline.dart';
import 'package:z_components/components/z-user-info/z-user-info-view.dart';
import 'package:z_components/components/z_button.dart';
import 'package:z_components/config/z-button-type.dart';
import 'package:z_components/config/z-tipos-baseline.dart';
import 'package:z_components/styles/main-style.dart';

class ZUserInfo extends StatefulWidget {
  String token;

  ZUserInfo({@required this.token});

  @override
  State<StatefulWidget> createState() => ZUserInfoState();
}

class ZUserInfoState extends State<ZUserInfo> {
  ZUserInfoView _view;

  @override
  void initState() {
    super.initState();

    _view = new ZUserInfoView(this);
    _view.initView();
  }

  @override
  Widget build(BuildContext context) {
    return MainStyle.get(context)
        .getDefaultScaffold("Editar informações de usuário", _buildBody());
  }

  Widget _buildBody() {
    return new Column(
      children: <Widget>[
        new ZBaseLine(
          zTipos: ZTipoBaseline.isNomeCompleto,
          controllerNome: _view.textEditingControllerNome,
          nomeFocus: _view.focusNodeNome,
        ),
        new ZBaseLine(
          zTipos: ZTipoBaseline.isCelular,
          controllerCelular: _view.textEditingControllerTelefone,
          celularFocus: _view.focusNodeTelefone,
        ),
        new ZBaseLine(
          zTipos: ZTipoBaseline.isEmail,
          controllerEmail: _view.textEditingControllerEmail,
          emailFocus: _view.focusNodeEmail,
        ),
        new Container(
          padding: const EdgeInsets.all(16.0),
          child: new ZButton(
            zButtonType: ZButtonType.isContained,
            text: "SALVAR",
            onPressed: () {
              print("salvou");
            },
          ),
        )
      ],
    );
  }
}
