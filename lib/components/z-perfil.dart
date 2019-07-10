import 'package:flutter/material.dart';
import 'package:z_components/components/z-header.dart';
import 'package:z_components/components/z-item-tile.dart';
import 'package:z_components/components/z-perfil-item.dart';
import 'package:z_components/components/z-text.dart';
import 'package:z_components/components/z_navigationbar.dart';
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
  String textoContato;
  String textoLocalizacao;
  int numeroQuadrados;
  List<String> listaTextos;
  List<IconData> listaIcones;
  bool statusInfo;
  var image;
  var onTapVoltar;

  ZPerfil({
    this.tituloAppBar,
    this.onTapVoltar,
    this.textoLocalizacao,
    this.listaIcones,
    this.listaTextos,
    this.numeroQuadrados,
    this.image,
    this.statusInfo,
    this.textoHoraEntradaInfo,
    this.textoCodigoInfo,
    this.textoContato,
    this.textoLocalInfo,
    this.textoEscalaInfo,
    this.textoHoraSaidaInfo,
    this.textoHoraIntervaloInfo,
    this.textoTituloInfo,
    this.textoCargoInfo,
    this.tituloHeader});

  @override
  _ZPerfilState createState() => _ZPerfilState();
}

class _ZPerfilState extends State<ZPerfil> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: ZNavigationBar(middle: widget.tituloAppBar,
        voltar: true,
        onTap: widget.onTapVoltar,
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
            new Container(
              margin: EdgeInsets.all(10.0),
              child: ZItemTile(
                image: widget.image,
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
          ),
        ),
        ZText(
          zTipos: ZTipoTextos.isTitulo,
          tituloText: "CONTATO",
        ),
        ZText(
          tituloText: "Telefone",
          zTipos: ZTipoTextos.isPadrao,
          text: widget.textoContato,
        ),
        ZText(
          zTipos: ZTipoTextos.isTitulo,
          tituloText: "LOCALIZAÇÃO",
        ),
        new Container(
          margin: EdgeInsets.only(bottom: 20.0),
          child: ZText(
            tituloText: "Endereço",
            text: widget.textoLocalizacao,
            zTipos: ZTipoTextos.isPadrao,
          ),
        )
      ],
    );
  }
}
