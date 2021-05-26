import 'package:flutter/material.dart';
import 'package:z_components/components/informacoes-organizacao/informacoes-organizacao-view.dart';
import 'package:z_components/components/z-inputs/z-input-celular.dart';
import 'package:z_components/components/z-inputs/z-input-cnpj.dart';
import 'package:z_components/components/z-inputs/z-input-cpf.dart';
import 'package:z_components/components/z-inputs/z-input-email.dart';
import 'package:z_components/components/z-inputs/z-input-generic.dart';
import 'package:z_components/components/z-inputs/z-input-name.dart';
import 'package:z_components/styles/main-style.dart';

class InformacoesOrganizacao extends StatefulWidget {
  ThemeData themeData;
  bool editarDados;
  String textoFoto;

  InformacoesOrganizacao({this.themeData, this.textoFoto, this.editarDados});

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
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InformacoesOrganizacao(
                        themeData: Theme.of(context),
                        editarDados: true,
                        textoFoto: "Editar Logo",
                      )));
        },
      );
    }
  }

  Widget _buildBody() {
    return new SingleChildScrollView(
      child: new Column(
        children: [
          _montarFotoPerfil(),
          new ZInputName(
            themeData: widget.themeData,
            nomeFocus: _view.nomeFocusNode,
            controllerNome: _view.nomeController,
            enabled: false,
          ),
          _montarCamposPfPj(true),
          ZInputCelular(
            themeData: widget.themeData,
            celularFocus: _view.telefoneFocusNode,
            controllerCelular: _view.telefoneController,
            enabled: widget.editarDados,
          ),
          ZInputEmail(
            themeData: widget.themeData,
            emailFocus: _view.emailFocusNode,
            controllerEmail: _view.emailController,
            enabled: widget.editarDados,
          ),
          ZInputGeneric(
              themeData: widget.themeData,
              titulo: "Código Ativação",
              inputPadraoFocus: _view.codigoFocusNode,
              controllerInputPadrao: _view.codigoController,
              enabled: false),
          _buildRowCorPrimaria(),
          _buildTextoCorPrimaria(),
          _buildRowCorSecundaria(),
          _buildTextoCorSecundaria(),
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
                children: <Widget>[new Text(widget.textoFoto)],
              )
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
          ZInputCNPJ(
              themeData: widget.themeData,
              cnpjFocus: _view.cnpjFocusNode,
              controllerCNPJ: _view.cnpjController,
              enabled: false)
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

  Widget _buildTextoCorSecundaria() {
    return new Container(
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

  ImageProvider _buildImagemPerfil() {
    if (_view.imagemPerfil != null) return MemoryImage(_view.imagemPerfil);

    return NetworkImage(
        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png");
  }
}
