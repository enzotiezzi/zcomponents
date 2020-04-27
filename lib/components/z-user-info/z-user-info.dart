import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-baseline.dart';
import 'package:z_components/components/z-identity-server/token-info.dart';
import 'package:z_components/components/z-inputs/z-input-celular.dart';
import 'package:z_components/components/z-inputs/z-input-data-de-nascimento.dart';
import 'package:z_components/components/z-user-info/z-user-info-view.dart';
import 'package:z_components/components/z_button.dart';
import 'package:z_components/config/z-button-type.dart';
import 'package:z_components/config/z-tipos-baseline.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/buscarinfo-viewmodel.dart';

class ZUserInfo extends StatefulWidget {
  String token;
  BuscarInfo userInfo;

  Function(BuscarInfo) onEditFinish;
  Function(String) onChangeProfileImage;

  ZUserInfo(
      {@required this.token,
      @required this.userInfo,
      this.onEditFinish,
      this.onChangeProfileImage});

  @override
  State<StatefulWidget> createState() => ZUserInfoState();
}

class ZUserInfoState extends State<ZUserInfo> with AfterLayoutMixin<ZUserInfo> {
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
    return new ListView(
      shrinkWrap: true,
      children: <Widget>[
        new GestureDetector(
          child: new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            image: _buildImagemPerfil(),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                          border: new Border.all(
                            color: MainStyle.get(context).primaryColor,
                            width: 4.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[new Text("Editar foto")],
                  )
                ],
              )),
          onTap: _view.escolherMetodoSelecionarFoto,
        ),
        new ZBaseLine(
          zTipos: ZTipoBaseline.isNomeCompleto,
          controllerNome: _view.textEditingControllerNome,
          nomeFocus: _view.focusNodeNome,
        ),
        new ZInputDataNascimento(
            dataFocus: _view.focusNodeDataNascimento,
            controllerData: _view.textEditingControllerDataNascimento),
        new ZInputCelular(
            celularFocus: _view.focusNodeTelefone,
            controllerCelular: _view.textEditingControllerTelefone),
        new ZBaseLine(
          zTipos: ZTipoBaseline.isEmail,
          controllerEmail: _view.textEditingControllerEmail,
          emailFocus: _view.focusNodeEmail,
        ),
        new ZBaseLine(
          zTipos: ZTipoBaseline.isCEP,
          controllerCEP: _view.textEditingControllerCEP,
          cEPFocus: _view.focusNodeCEP,
          onChangedCEP: _view.onCEPChange,
        ),
        new ZBaseLine(
          zTipos: ZTipoBaseline.semTituloText,
          text: "Estado",
          controllerPadrao: _view.textEditingControllerEstado,
          hintText: "Estado",
        ),
        new ZBaseLine(
          zTipos: ZTipoBaseline.semTituloText,
          text: "Cidade",
          controllerPadrao: _view.textEditingControllerCidade,
          hintText: "Cidade",
        ),
        new ZBaseLine(
          zTipos: ZTipoBaseline.semTituloText,
          text: "Bairro",
          controllerPadrao: _view.textEditingControllerBairro,
          hintText: "Bairro",
        ),
        new ZBaseLine(
          zTipos: ZTipoBaseline.semTituloText,
          text: "Rua",
          controllerPadrao: _view.textEditingControllerRua,
          hintText: "Rua",
        ),
        new ZBaseLine(
          zTipos: ZTipoBaseline.semTituloText,
          text: "Número",
          controllerPadrao: _view.textEditingControllerNumero,
          padraoFocus: _view.focusNodeNumero,
          hintText: "Número",
        ),
        new Container(
          padding: const EdgeInsets.all(16.0),
          child: new ZButton(
            zButtonType: ZButtonType.isContained,
            text: "SALVAR",
            onPressed: () {
              _view.submit();
            },
          ),
        )
      ],
    );
  }

  ImageProvider _buildImagemPerfil() {
    if (_view.imagemPerfil != null) return MemoryImage(_view.imagemPerfil);

    return NetworkImage(
        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png");
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _view.afterBuild();
  }
}
