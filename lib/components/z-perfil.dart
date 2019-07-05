import 'package:flutter/material.dart';
import 'package:z_components/components/z-header.dart';
import 'package:z_components/components/z-item-tile.dart';
import 'package:z_components/components/z-perfil-item.dart';
import 'package:z_components/components/z-text.dart';
import 'package:z_components/components/z_navigationbar.dart';
import 'package:z_components/config/z-tipo-header.dart';

class ZPerfil extends StatefulWidget {
  @override
  _ZPerfilState createState() => _ZPerfilState();
}

class _ZPerfilState extends State<ZPerfil> {
  List<String> titulos = ["Lista de Documentos", "Espelho de Ponto", "Gestão de Ponto", "Atestados"];
  List<IconData> icones = [Icons.assignment, Icons.list, Icons.add_to_home_screen, Icons.attach_file];
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
        ZHeader(children: <Widget>[new Container(margin: EdgeInsets.all(10.0),child: ZItemTile(),)],
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
        new Container(height: 250.0,
          child: ZPerfilItem(count: 4,listaTextos: titulos,listaIcones: icones,),
        ),
        ZText(),
        ZText()
      ],
    );
  }
}
