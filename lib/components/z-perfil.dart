import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-header.dart';
import 'package:z_components/components/z-item-tile.dart';
import 'package:z_components/components/z-perfil-item.dart';
import 'package:z_components/config/z-tipo-header.dart';
import 'package:z_components/config/z-type-tile.dart';

class ZPerfil extends StatefulWidget {
  String idConta;
  String token;
  String cpf;
  String tituloAppBar;
  String inicioIntervalo;
  String voltaIntervalo;
  String textoTituloInfo;
  String textoLocalInfo;
  String jornada;
  String textoCargoInfo;
  String textoEscalaInfo;
  String textoHoraEntradaInfo;
  String textoHoraSaidaInfo;
  String textoHoraIntervaloInfo;
  String textoCodigoInfo;
  String tituloHeader;
  String re;
  Color colorBatida;
  int numeroQuadrados;
  List<String> listaTextos;
  List<IconData> listaIcones;
  List<dynamic> listaOnTap;
  bool statusInfo;
  Widget imagemPerfil;
  var onTapVoltar;
  var onTapImage;
  String isExpand;
  Function funcaoIconBatida;

  Function funcao;
  Color color;
  String endereco;
  String telefone;
  String email;

  ZPerfil(
      {this.re: "",
      this.colorBatida: Colors.grey,
      this.funcao,
      this.funcaoIconBatida,
      this.jornada: "",
      this.tituloAppBar,
      this.onTapVoltar,
      this.listaIcones,
      this.inicioIntervalo,
      this.voltaIntervalo,
      this.listaTextos,
      this.numeroQuadrados,
      this.imagemPerfil,
      this.statusInfo,
      this.textoHoraEntradaInfo,
      this.textoCodigoInfo,
      this.textoLocalInfo,
      this.textoEscalaInfo,
      this.textoHoraSaidaInfo,
      this.textoHoraIntervaloInfo,
      this.textoTituloInfo,
      this.textoCargoInfo,
      this.listaOnTap,
      this.onTapImage,
      this.tituloHeader,
      this.token,
      this.cpf,
      this.idConta,
      this.color,
      this.telefone,
      this.email,
      this.endereco});

  @override
  _ZPerfilState createState() => _ZPerfilState();
}

class _ZPerfilState extends State<ZPerfil> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: const Color(0xffEFEFF4),
      appBar: CupertinoNavigationBar(
        middle: new Container(
          child: new Text(
            widget.tituloAppBar,
            style: TextStyle(color: Colors.black),
          ),
        ),
        leading: new GestureDetector(
          onTap: widget.onTapVoltar,
          child: new Container(
            padding: EdgeInsets.only(right: 20.0),
            color: Colors.transparent,
            child: new Icon(
              Icons.arrow_back_ios,
              size: 20.0,
              color: widget.color,
            ),
          ),
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return new Column(
      children: <Widget>[
        ZHeader(
          child: new Container(
            margin: const EdgeInsets.only(top: 8, bottom: 8, left: 20),
            child: new Text(
              "${widget.tituloHeader}",
              style: new TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            ),
          ),
          children: <Widget>[
            new Container(
              color: const Color(0xffF0F0F0),
              padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
              child: ZItemTile(
                zTypeTile: ZTypeTile.isUser,
                nome: widget.textoTituloInfo,
                nomeCentroCusto: widget.textoLocalInfo,
                onTapImage: widget.onTapImage,
                imagemPerfil: widget.imagemPerfil,
                cpf: widget.cpf,
                isExpand: widget.isExpand,
                funcao: widget.funcao,
                email: widget.email,
                endereco: widget.endereco,
                telefone: widget.telefone,
              ),
            )
          ],
          zTipos: ZTipoHeader.isExpansion,
        ),
        new Expanded(
          child: _buildBody(),
        )
      ],
    );
  }

  Widget _buildBody() {
    return new ListView(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.only(
            top: 20.0,
            left: 10.0,
            right: 10.0,
          ),
          child: ZPerfilItem(
            numeroQuadrados: widget.numeroQuadrados,
            listaTextos: widget.listaTextos,
            listaIcones: widget.listaIcones,
            listaOnTap: widget.listaOnTap,
            color: widget.color,
          ),
        ),
      ],
    );
  }
}
