import 'dart:io';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:z_components/components/z-baseline.dart';
import 'package:z_components/components/z-collection/z-collection-bottomsheet.dart';
import 'package:z_components/components/z-identity-server/token-info.dart';
import 'package:z_components/components/z-inputs/z-input-celular.dart';
import 'package:z_components/components/z-inputs/z-input-cep.dart';
import 'package:z_components/components/z-inputs/z-input-cpf.dart';
import 'package:z_components/components/z-inputs/z-input-data-de-nascimento.dart';
import 'package:z_components/components/z-inputs/z-input-email.dart';
import 'package:z_components/components/z-inputs/z-input-generic.dart';
import 'package:z_components/components/z-inputs/z-input-name.dart';
import 'package:z_components/components/z-tile.dart';
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
        Container(
          child: new ZInputName(
              themeData: Theme.of(context),
              nomeFocus: _view.focusNodeNome,
              controllerNome: _view.textEditingControllerNome,
              campoObrigatorio: true,
              validacao: (bool) {
                setState(() {
                  if (bool) {
                    _view.preencheuNome = true;
                    _view.validarCamposObrigatorios();
                  } else {
                    _view.preencheuNome = false;
                  }
                });
              },
              onChange: (text) {
                String primeiroNome = "";
                String ultimoNome = "";
                if (text.trim().contains(" ")) {
                  var textoSeparado = text.trim().split(" ");
                  primeiroNome = textoSeparado[0];
                  ultimoNome = textoSeparado.last;
                } else {
                  primeiroNome = text;
                }
                _view.textEditingControllerNomeReduzido.text =
                    primeiroNome.trim() + " " + ultimoNome.trim();
                _view.camposObrigatoriosValidados =
                    _view.validarCamposObrigatorios();
              }),
        ),
        new Divider(
          height: 1.0,
        ),
        new Container(
          child: new ZInputGeneric(
            titulo: "Nome de Exibição",
            themeData: Theme.of(context),
            inputPadraoFocus: _view.focusNodeNomeReduzido,
            controllerInputPadrao: _view.textEditingControllerNomeReduzido,
            enabled: false,
          ),
        ),
        new Divider(
          height: 1.0,
        ),
        new Container(
          child: new ZInputCPF(
            enabled: false,
            themeData: Theme.of(context),
            controllerCpf: _view.textEditingControllerCPF,
            cpfFocus: _view.focusNodeCPF,
          ),
        ),
        new Divider(height: 1.0,),
        new ZInputDataNascimento(
          dataFocus: _view.focusNodeDataNascimento,
          themeData: Theme.of(context),
          controllerData: _view.textEditingControllerDataNascimento,
        ),


        //tel
        Divider(
          height: 1,
        ),
        Container(
          color: Colors.white,
          child: new Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TELEFONE",
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xF0000000),
                      fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.flag,
                        color: _view.definirCorFlag(),
                      ),
                      onPressed: _view.flagHabilitarTelefone(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        new Divider(
          height: 1,
        ),
        new Container(
          child: new ZCollectionBottomSheet(
            campoObrigatorio: false,
            themeData: Theme.of(context),
            valorPadrao: _view.tipoTelSelecionado,
            title: "Tipo de Telefone",
            lista: _view.listaTipoTelefone,
            onChange: (value) {
              setState(() {
                _view.textEditingControllerTelefone.text = "";
                _view.definirMascaraTelefone(value);
                _view.focusNodeTelefone.requestFocus();
                _view.tipoTelSelecionado = value.titulo;
              });
            },
          ),
        ),
        new Divider(height: 1,),

        _view.inputTel(_view.tipoTelSelecionado),

        _view.telefoneSecundario(),
        zTileAdcTel(),
        //email
        new Divider(
          height: 1,
        ),

        Container(
          margin: EdgeInsets.only(top: 8),
          color: Colors.white,
          child: new Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "EMAIL",
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xF0000000),
                      fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.flag,
                        color: _view.definirCorEmailFlag(),
                      ),
                      onPressed: _view.flagHabilitarEmailSecundario(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        new Divider(
          height: 1,
        ),
        new Container(
          child: new ZCollectionBottomSheet(
            campoObrigatorio: false,
            themeData: Theme.of(context),
            valorPadrao: _view.tipoEmailSelecionado,
            title: "Tipo de Email",
            lista: _view.listaTipoEmail,
            onChange: (value) {
              setState(() {
                _view.textEditingControllerEmail.text = "";
                _view.tipoEmailSelecionado = value.titulo;
              });
            },
          ),
        ),
        new Divider(
          height: 1.0,
        ),
        new Container(
          child: new ZInputEmail(
            campoObrigatorio: _view.flagEmail,
            themeData: Theme.of(context),
            controllerEmail: _view.textEditingControllerEmail,
            emailFocus: _view.focusNodeEmail,
            validacao: (validacao) {
              setState(() {
                if (validacao) {
                  _view.preencheuEmail = true;
                } else {
                  _view.preencheuEmail = false;
                }
              });
            },
          ),
        ),

        _view.emailSecundario(),

        new Divider(
          height: 1,
        ),
        new Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          child: new ZTile(
            onTap: () {},
            leading: Text(_view.textoEmail,
                style: TextStyle(
                    color: Color(0xFF801F92),
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
            trailing: SizedBox(
              width: 35,
              child: IconButton(
                onPressed: _view.tileHabilitarEmailSecundario(),
                color: Color(0xFF801F92),
                icon: _view.iconEmail,
              ),
            ),
          ),
        ),

        new Divider(
          height: 1.0,
        ),

        new Container(
          child: new ZInputCEP(
            themeData: Theme.of(context),
            controllerCep: _view.textEditingControllerCEP,
            cepFocus: _view.focusNodeCEP,
            onChange: _view.onCEPChange,
          ),
        ),
        new Divider(
          height: 1.0,
        ),
        new Container(
          child: new ZInputGeneric(
            themeData: Theme.of(context),
            titulo: "Estado",
            controllerInputPadrao: _view.textEditingControllerEstado,
            hintText: "Estado",
          ),
        ),
        new Divider(
          height: 1.0,
        ),
        new Container(
          child: new ZInputGeneric(
            themeData: Theme.of(context),
            titulo: "Cidade",
            controllerInputPadrao: _view.textEditingControllerCidade,
            hintText: "Cidade",
          ),
        ),
        new Divider(
          height: 1.0,
        ),
        new Container(
          child: new ZInputGeneric(
            themeData: Theme.of(context),
            titulo: "Bairro",
            controllerInputPadrao: _view.textEditingControllerBairro,
            hintText: "Bairro",
          ),
        ),
        new Divider(
          height: 1.0,
        ),
        new Container(
          child: new ZInputGeneric(
            themeData: Theme.of(context),
            titulo: "Rua",
            controllerInputPadrao: _view.textEditingControllerRua,
            hintText: "Rua",
          ),
        ),
        new Divider(
          height: 1.0,
        ),
        new Container(
          child: new ZInputGeneric(
            themeData: Theme.of(context),
            titulo: "Número",
            controllerInputPadrao: _view.textEditingControllerNumero,
            inputPadraoFocus: _view.focusNodeNumero,
            hintText: "Número",
          ),
        ),
        new Divider(
          height: 1.0,
        ),
        new Container(
          padding: const EdgeInsets.all(16.0),
          child: new ZButton(
            zButtonType: ZButtonType.isContained,
            text: "SALVAR",
            color: Colors.white,
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

  Widget zTileAdcTel() {
    if (_view.preencheuTelefone) {
      return new Container(
        margin: EdgeInsets.only(top: 16),
        child: new ZTile(
          onTap: () {},
          leading: Text(_view.textoTelefone,
              style: TextStyle(
                  color: Color(0xFF801F92),
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          trailing: SizedBox(
            width: 35,
            child: IconButton(
              onPressed: _view.textEditingControllerNumero.text != null
                  ? () {
                      setState(() {
                        _view.segundoTel = !_view.segundoTel;
                        if (_view.segundoTel) {
                          _view.textoTelefone = "REMOVER TELEFONE";
                          _view.icon = Icon(Icons.remove);
                          //_view.resetTelSec();
                        } else {
                          _view.textoTelefone = "ADICIONAR TELEFONE";
                          _view.icon = Icon(Icons.add);
                          _view.resetTelSec();
                        }
                      });
                    }
                  : () {},
              color: Color(0xFF801F92),
              icon: _view.icon,
            ),
          ),
        ),
      );
    } else
      return new Container();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _view.afterBuild();
  }
}
