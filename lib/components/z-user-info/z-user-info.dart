import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/utils/icone-voltar.dart';
import 'package:z_components/components/z-inputs/z-input-celular.dart';
import 'package:z_components/components/z-inputs/z-input-cpf.dart';
import 'package:z_components/components/z-inputs/z-input-data-de-nascimento.dart';
import 'package:z_components/components/z-inputs/z-input-email.dart';
import 'package:z_components/components/z-inputs/z-input-generic.dart';
import 'package:z_components/components/z-inputs/z-input-name.dart';
import 'package:z_components/components/z-text.dart';
import 'package:z_components/components/z-user-info/z-user-info-view.dart';
import 'package:z_components/components/z_button.dart';
import 'package:z_components/config/z-button-type.dart';
import 'package:z_components/config/z-tipo-textos.dart';
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
    return new Scaffold(
      appBar: AppBar(
        leading: IconeVoltar(context: context,),
        centerTitle: true,
        title: new Text(
          "Editar Perfil",
        ),
        actions: [
          new GestureDetector(
            child: new Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.edit,
                size: 26,
                color: Theme.of(context).accentColor,
              ),
            ),
            onTap: () {
              _view.editarAtivo = !_view.editarAtivo;

              if (mounted) {
                setState(() {
                  if (_view.editarAtivo) {
                    FocusScope.of(context).requestFocus(_view.focusNodeNome);
                    _view.textoFoto = "Editar foto";
                  } else {
                    _view.textoFoto = "";
                  }
                });
              }
            },
          )
        ],
      ),
      body: _buildBody(),
    );
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
                    children: <Widget>[new Text(_view.textoFoto)],
                  )
                ],
              )),
          onTap: _view.escolherMetodoSelecionarFoto,
        ),
        ZText(
          tituloText: "DADOS GERAIS",
          zTipos: ZTipoTextos.isTitulo,
        ),
        new Divider(
          height: 1.0,
        ),
        Container(
          child: new ZInputName(
              enabled: _view.editarAtivo,
              themeData: Theme.of(context),
              nomeFocus: _view.focusNodeNome,
              controllerNome: _view.textEditingControllerNome,
              proximoFocus: _view.focusNodeDataNascimento,
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
            proximoFocus: _view.focusNodeDataNascimento,
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
        new Divider(
          height: 1.0,
        ),
        new ZInputDataNascimento(
          enabled: _view.editarAtivo,
          dataFocus: _view.focusNodeDataNascimento,
          themeData: Theme.of(context),
          controllerData: _view.textEditingControllerDataNascimento,
          proximoFocus: _view.focusNodeTelefone,
          validacao: (bool) {},
        ),
        new Divider(
          height: 1.0,
        ),
        new Container(
          margin: EdgeInsets.only(top: 10.0),
          child: ZText(
            tituloText: "DADOS DE CONTATO",
            zTipos: ZTipoTextos.isTitulo,
          ),
        ),
        new Divider(
          height: 1.0,
        ),
        new Container(
          child: new ZInputCelular(
            enabled: _view.editarAtivo,
            themeData: Theme.of(context),
            celularFocus: _view.focusNodeTelefone,
            controllerCelular: _view.textEditingControllerTelefone,
            proximoFocus: _view.focusNodeEmail,
          ),
        ),
        new Container(
          child: new ZInputEmail(
              enabled: _view.editarAtivo,
              themeData: Theme.of(context),
              emailFocus: _view.focusNodeEmail,
              controllerEmail: _view.textEditingControllerEmail),
        ),
        _montarBotaoSalvar()
      ],
    );
  }

  Widget _montarBotaoSalvar() {
    if (_view.editarAtivo) {
      return new Container(
        padding: const EdgeInsets.all(16.0),
        child: new ZButton(
          zButtonType: ZButtonType.isContained,
          text: "SALVAR",
          color: Colors.white,
          onPressed: () {
            _view.submit();
          },
        ),
      );
    } else
      return new Container();
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
