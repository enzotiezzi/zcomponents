import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/utils/icone-voltar.dart';
import 'package:z_components/components/z-inputs/z-input-celular.dart';
import 'package:z_components/components/z-inputs/z-input-cpf.dart';
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
  bool editarAtivo;

  Function(BuscarInfo) onEditFinish;
  Function(String) onChangeProfileImage;

  ZUserInfo(
      {@required this.token,
      @required this.userInfo,
      this.onEditFinish,
      this.onChangeProfileImage,
      this.editarAtivo: false});

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
        leading: IconeVoltar(
          context: context,
        ),
        centerTitle: true,
        title: new Text(
          "Editar Perfil",
        ),
        actions: [_montarBotaoEditar()],
      ),
      body: _buildBody(),
    );
  }

  Widget _montarBotaoEditar() {
    if (!widget.editarAtivo) {
      return new GestureDetector(
        child: new Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(4.0),
          child: Icon(
            Icons.edit,
            size: 26,
            color: Color(0xFF2BBAB4),
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ZUserInfo(
                        editarAtivo: true,
                        userInfo: new BuscarInfo(),
                      )));
        },
      );
    } else
      return new Container();
  }

  Widget _buildBody() {
    return new SingleChildScrollView(
      child: new Column(
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
                enabled: widget.editarAtivo,
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
              enabled: widget.editarAtivo,
              themeData: Theme.of(context),
              celularFocus: _view.focusNodeTelefone,
              controllerCelular: _view.textEditingControllerTelefone,
              proximoFocus: _view.focusNodeEmail,
            ),
          ),
          new Container(
            child: new ZInputEmail(
                enabled: widget.editarAtivo,
                themeData: Theme.of(context),
                emailFocus: _view.focusNodeEmail,
                controllerEmail: _view.textEditingControllerEmail),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 8,
          ),
          _montarBotaoSalvar()
        ],
      ),
    );
  }

  Widget _montarBotaoSalvar() {
    if (widget.editarAtivo) {
      return new Material(
        elevation: 4.0,
        child: new Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height / 8,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new RaisedButton(
                onPressed: () {
                  _view.submit();
                },
                child: new Container(
                  child: new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      new Container(
                        padding: const EdgeInsets.only(right: 40, left: 40),
                        child: new Text(
                          "SALVAR",
                          style: Theme.of(context)
                              .textTheme
                              .button
                              .copyWith(color: Color(0xFFFFFFFF)),
                        ),
                      )
                    ],
                  ),
                ),
                color: Theme.of(context).accentColor,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.only(left: 10, right: 10),
              )
            ],
          ),
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
