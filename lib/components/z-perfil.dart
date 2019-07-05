import 'package:flutter/material.dart';
import 'package:z_components/components/z-header.dart';
import 'package:z_components/components/z-item-tile.dart';
import 'package:z_components/components/z-perfil-item.dart';
import 'package:z_components/components/z-text.dart';
import 'package:z_components/components/z_navigationbar.dart';
import 'package:z_components/config/z-tipo-header.dart';
import 'package:z_components/config/z-tipo-textos.dart';

class ZPerfil extends StatefulWidget {
  String textoTituloInfo;
  String textoDoisInfo;
  String textoTresInfo;
  String textoQuatroInfo;
  String textoCincoInfo;
  String textoSeisInfo;
  String textoSeteInfo;
  String textoCodigoInfo;
  String tituloHeader;
  String textoContato;
  String textoLocalizacao;
  int numeroQuadrados;
  List<String> listaTextos;
  List<IconData> listaIcones;
  bool statusInfo;
  var image;




  @override
  _ZPerfilState createState() => _ZPerfilState();
}

class _ZPerfilState extends State<ZPerfil> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: ZNavigationBar(
        voltar: true,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return new Column(
      children: <Widget>[
        ZHeader(titulo: widget.tituloHeader,
          children: <Widget>[
            new Container(
              margin: EdgeInsets.all(10.0),
              child: ZItemTile(
                image: widget.image,
                status: widget.statusInfo,
                textoCodigo: widget.textoCodigoInfo,
                textoSete: widget.textoSeteInfo,
                textoSeis: widget.textoSeisInfo,
                textoCinco: widget.textoCincoInfo,
                textoQuatro: widget.textoQuatroInfo,
                textoTres: widget.textoTresInfo,
                textoDois: widget.textoDoisInfo,
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
          margin:
              EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0,),
          child: ZPerfilItem(
            numeroQuadrados: widget.numeroQuadrados,
            listaTextos: widget.listaTextos,
            listaIcones: widget.listaIcones,
          ),
        ),
        ZText(
          ZTipos: ZTipoTextos.isTitulo,
          tituloText: "CONTATO",
        ),
        ZText(tituloText: "Telefone",
          ZTipos: ZTipoTextos.isPadrao,
          text: widget.textoContato,
        ),
        ZText(
          ZTipos: ZTipoTextos.isTitulo,
          tituloText: "LOCALIZAÇÃO",

        ),
        new Container(
          margin: EdgeInsets.only(bottom: 20.0),
          child: ZText(tituloText: "Endereço",
            text: widget.textoLocalizacao,
            ZTipos: ZTipoTextos.isPadrao,
          ),
        )
      ],
    );
  }
}
