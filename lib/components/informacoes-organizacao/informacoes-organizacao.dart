import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:z_components/components/informacoes-organizacao/informacoes-organizacao-view.dart';
import 'package:z_components/components/utils/icone-voltar.dart';
import 'package:z_components/components/z-inputs/z-input-celular.dart';
import 'package:z_components/components/z-inputs/z-input-cep.dart';
import 'package:z_components/components/z-inputs/z-input-cnpj.dart';
import 'package:z_components/components/z-inputs/z-input-cpf.dart';
import 'package:z_components/components/z-inputs/z-input-email.dart';
import 'package:z_components/components/z-inputs/z-input-generic.dart';
import 'package:z_components/components/z-inputs/z-input-name.dart';
import 'package:z_components/config/z-tipo-textos.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/info-organizacao-viewmodel.dart';

import '../z-text.dart';

class InformacoesOrganizacao extends StatefulWidget {
  ThemeData themeData;
  bool editarDados;
  String textoFoto;
  InfoOrganizacaoViewModel infoOrganizacaoViewModel;
  String idConta;
  Uint8List imagemPerfil;

  InformacoesOrganizacao(
      {this.themeData,
      this.textoFoto,
      this.editarDados,
      this.infoOrganizacaoViewModel,
      this.idConta,
      this.imagemPerfil});

  @override
  _InformacoesOrganizacaoState createState() => _InformacoesOrganizacaoState();
}

class _InformacoesOrganizacaoState extends State<InformacoesOrganizacao> {
  InformacoesOrganizacaoView _view;

  @override
  void initState() {
    _view = InformacoesOrganizacaoView(this);
    _view.initView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconeVoltar(context: context,),
        centerTitle: true,
        title: new Text("Info. da Organização"),
        actions: [_montarBotaoEditar()],
      ),
      body: _buildBody(),
    );
  }

  Widget _montarBotaoEditar() {
    if (widget.editarDados) {
      return new Container();
    } else {
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
            color: Theme.of(context).accentColor,
          ),
        ),
        onTap: () async {
          var res = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InformacoesOrganizacao(
                        themeData: Theme.of(context),
                        editarDados: true,
                        textoFoto: "Editar Logo",
                        idConta: "3f2bdcbb-764f-48c7-0c33-08d7cf63e45b",
                        infoOrganizacaoViewModel:
                            _view.infoOrganizacaoViewModel,
                        imagemPerfil: _view.imagemPerfil,
                      )));

          if (res != null) {
            await _view.initView();
          }
        },
      );
    }
  }

  Widget _buildBody() {
    return new SingleChildScrollView(
      child: new Column(
        children: [
          _montarFotoPerfil(),
          ZText(
            tituloText: "DADOS GERAIS",
            zTipos: ZTipoTextos.isTitulo,
          ),
          new Divider(
            height: 1.0,
          ),
          new ZInputName(
            themeData: widget.themeData,
            nomeFocus: _view.nomeFocusNode,
            controllerNome: _view.nomeController,
            enabled: false,
          ),
          new Divider(
            height: 1.0,
          ),
          _montarCamposPfPj(true),
          new Divider(
            height: 1.0,
          ),
          new Container(
            child: ZInputGeneric(
                themeData: widget.themeData,
                titulo: "Código Ativação",
                inputPadraoFocus: _view.codigoFocusNode,
                controllerInputPadrao: _view.codigoController,
                enabled: false),
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
          ZInputCelular(
            themeData: widget.themeData,
            celularFocus: _view.telefoneFocusNode,
            controllerCelular: _view.telefoneController,
            enabled: widget.editarDados,
            validacao: (bool) {},
          ),
          new Divider(
            height: 1.0,
          ),
          ZInputEmail(
            themeData: widget.themeData,
            emailFocus: _view.emailFocusNode,
            controllerEmail: _view.emailController,
            enabled: widget.editarDados,
            validacao: (bool) {},
          ),
          new Divider(
            height: 1.0,
          ),
          new Container(
            margin: EdgeInsets.only(top: 10.0),
            child: ZText(
              tituloText: "DADOS DE LOCALIZAÇÃO",
              zTipos: ZTipoTextos.isTitulo,
            ),
          ),
          new Divider(
            height: 1.0,
          ),
          new Container(
            child: new ZInputCEP(
              enabled: widget.editarDados,
              themeData: Theme.of(context),
              controllerCep: _view.textEditingControllerCEP,
              cepFocus: _view.focusNodeCEP,
              onChange: _view.onCEPChange,
              validacao: (bool) {},
            ),
          ),
          new Divider(
            height: 1.0,
          ),
          new Container(
            child: new ZInputGeneric(
              enabled: widget.editarDados,
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
              enabled: widget.editarDados,
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
              enabled: widget.editarDados,
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
              enabled: widget.editarDados,
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
              enabled: widget.editarDados,
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
            child: new ZInputGeneric(
              enabled: widget.editarDados,
              themeData: Theme.of(context),
              titulo: "Complemento",
              controllerInputPadrao: _view.complementoController,
              hintText: "Complemento",
            ),
          ),
          new Divider(
            height: 1.0,
          ),
          _buildRowCorPrimaria(),
          // _buildTextoCorPrimaria(),
          _buildRowCorSecundaria(),
          //   _buildTextoCorSecundaria(),
          _exibirBotao()
        ],
      ),
    );
  }

  Widget _montarFotoPerfil() {
    return new GestureDetector(
      child: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Stack(
                    alignment: Alignment.center,
                    children: [
                      _buildImagemPerfil(),
                      new Text(
                        widget.textoFoto,
                        style: TextStyle(color: _corTextoFoto()),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
      onTap: _view.escolherMetodoSelecionarFoto,
    );
  }

  Widget _montarCamposPfPj(bool pj) {
    if (pj) {
      return new Column(
        children: [
          ZInputGeneric(
              themeData: widget.themeData,
              titulo: "Nome Fantasia",
              inputPadraoFocus: _view.nomeFantasiaFocusNode,
              controllerInputPadrao: _view.nomeFantasiaController,
              enabled: false),
          new Divider(
            height: 1.0,
          ),
          ZInputCNPJ(
              themeData: widget.themeData,
              cnpjFocus: _view.cnpjFocusNode,
              controllerCNPJ: _view.cnpjController,
              enabled: false),
        ],
      );
    } else {
      return new ZInputCPF(
          themeData: widget.themeData,
          cpfFocus: _view.cpfFocusNode,
          controllerCpf: _view.cpfController,
          enabled: false);
    }
  }

  Widget _buildRowCorPrimaria() {
    return new Container(
      color: Color(0xFFFFFFFF),
      margin: EdgeInsets.only(
        top: 16.0,
      ),
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      height: 42.0,
      child: new Column(
        children: [
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Container(
                child: new Text("Cor Primária"),
              ),
              new GestureDetector(
                onTap: () => _view.showDialogCorPrimaria(),
                child: new CircleAvatar(
                  radius: 20,
                  backgroundColor: _view.corPrimaria,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextoCorPrimaria() {
    return new Container(
      color: Color(0xFFF0F0F0),
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          new Text(
            "Esta cor é aplicada nos cabeçalhos e elementos base \ndas telas.",
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Color(0xFF707070)),
          ),
        ],
      ),
    );
  }

  Widget _buildRowCorSecundaria() {
    return new Container(
      color: Color(0xFFFFFFFF),
      margin: EdgeInsets.only(
        top: 16.0,
      ),
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      height: 42.0,
      child: new Column(
        children: [
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Container(
                child: new Text("Cor Secundária"),
              ),
              new GestureDetector(
                onTap: () => _view.showDialogCorSecundaria(),
                child: new CircleAvatar(
                  radius: 20,
                  backgroundColor: _view.corSecundaria,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _exibirBotao() {
    if (widget.editarDados) {
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
                  _view.editarDadosOrganizacao();
                },
                child: new Container(
                  child: new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      new Container(
                        padding: const EdgeInsets.only(right: 40, left: 40),
                        child: new Text(
                          "PRÓXIMO",
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
    } else {
      return new Container();
    }
  }

  Widget _buildTextoCorSecundaria() {
    return new Container(
      margin: EdgeInsets.only(bottom: 10.0),
      color: Color(0xFFF0F0F0),
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          new Text(
            "Esta cor é aplicada em botões e elementos clicáveis de \ndestaque.",
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Color(0xFF707070)),
          ),
        ],
      ),
    );
  }

  Widget _buildImagemPerfil() {
    if (_view.imagemPerfil != null)
      return new Container(
        width: 150.0,
        height: 100.0,
        decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            image: new DecorationImage(
              image: MemoryImage(_view.imagemPerfil),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(6.0)),
      );
    else
      return new Container(
        width: 150.0,
        height: 100.0,
        decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(6.0)),
        child: new Icon(
          Icons.camera_alt,
          color: Color(0xff2BBAB4),
          size: 40,
        ),
      );
  }

  Color _corTextoFoto() {
    if (_view.imagemPerfil != null) {
      return Colors.white;
    } else
      return Colors.black;
  }
}
