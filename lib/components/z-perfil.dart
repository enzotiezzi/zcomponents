import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-header.dart';
import 'package:z_components/components/z-item-tile.dart';
import 'package:z_components/components/z-perfil-item.dart';
import 'package:z_components/components/z-text.dart';
import 'package:z_components/config/z-tipo-header.dart';
import 'package:z_components/config/z-tipo-textos.dart';

class ZPerfil extends StatefulWidget {
  Widget tituloAppBar;
  String textoTituloInfo;
  String textoLocalInfo;
  String textoCargoInfo;
  String textoEscalaInfo;
  String textoHoraEntradaInfo;
  String textoHoraSaidaInfo;
  String textoHoraIntervaloInfo;
  String textoCodigoInfo;
  String tituloHeader;
  int numeroQuadrados;
  List<String> listaTextos;
  List<IconData> listaIcones;
  List<dynamic> listaOnTap;
  bool statusInfo;
  Widget imagemPerfil;
  var onTapVoltar;
  var onTapImage;

  ZPerfil(
      {this.tituloAppBar,
      this.onTapVoltar,
      this.listaIcones,
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
      this.tituloHeader});

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
            "PERFIL DO COLABORADOR",
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
              color: const Color(0xff2BB9B4),
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
          titulo: widget.tituloHeader,
          children: <Widget>[
            new Container(color: const Color(0xffF0F0F0),
              padding: EdgeInsets.only(right: 10.0, left: 10.0, bottom: 5.0, top: 5.0),
              child: ZItemTile(
                onTapImage: widget.onTapImage,
                imagemPerfil: widget.imagemPerfil,
                status: widget.statusInfo,
                textoCodigo: widget.textoCodigoInfo,
                textoSete: widget.textoHoraIntervaloInfo,
                textoSeis: widget.textoHoraSaidaInfo,
                textoCinco: widget.textoHoraEntradaInfo,
                textoQuatro: widget.textoEscalaInfo,
                textoTres: widget.textoCargoInfo,
                textoDois: widget.textoLocalInfo,
                textoTitulo: widget.textoTituloInfo,
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
          ),
        ),

      ],
    );
  }
}
