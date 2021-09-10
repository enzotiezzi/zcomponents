import 'package:flutter/material.dart';
import 'package:z_components/components/z-selection/z-selection.dart';
import 'package:z_components/components/z-selection/z-selection-item.dart';
import 'package:z_components/components/z-collection/z-collection-item.dart';
import 'package:z_components/components/z-collection/z-collection.dart';
import 'package:z_components/config/z-tipo-header.dart';
import 'package:z_components/components/z-header.dart';

class TelaTesteCard extends StatefulWidget {
  @override
  _TelaTesteCardState createState() => _TelaTesteCardState();
}

class _TelaTesteCardState extends State<TelaTesteCard> {
  List<ZSelectionItem> listaSelecao = [];
  List<ZSelectionItem> listaSelecaoRespostas = [];

  final zEstrutura = GlobalKey();

  TextEditingController cep = new TextEditingController();
  TextEditingController logradouro = new TextEditingController();
  TextEditingController numero = new TextEditingController();
  TextEditingController cidade = new TextEditingController();
  TextEditingController bairro = new TextEditingController();
  TextEditingController complemento = new TextEditingController();
  TextEditingController estado = new TextEditingController();
  List<ZCollectionItem> lista = [];

  GlobalKey<ZCollectionState> keyPorte = new GlobalKey<ZCollectionState>();

  List<ZCollectionItem> listaPorte = [
    ZCollectionItem(valor: "T-E-S-T", chave: "TesteChave", titulo: "Teste"),
    ZCollectionItem(valor: "Teste2", chave: "Teste2", titulo: "Teste2"),
    ZCollectionItem(valor: "Teste3", chave: "Teste3", titulo: "Teste3"),
    ZCollectionItem(valor: "Teste4", chave: "Teste4", titulo: "Teste4"),
    ZCollectionItem(valor: "Teste5", chave: "Teste5", titulo: "Teste5"),
  ];

  @override
  void initState() {
    listaSelecao = [
      ZSelectionItem(
          chave: "Universidade", titulo: "Universidade", valor: "Universidade"),
      ZSelectionItem(
          chave: "1",
          titulo:
              "Instalador de isolantes térmicos de caldeira e tubulações de teste 123 testando overflow",
          valor: "Instalador de isolantes térmicos de caldeira e tubulações"),
      ZSelectionItem(chave: "2", titulo: "2", valor: "2"),
      ZSelectionItem(chave: "3", titulo: "3", valor: "3"),
      ZSelectionItem(chave: "4", titulo: "4", valor: "4"),
      ZSelectionItem(chave: "5", titulo: "5", valor: "5"),
      ZSelectionItem(chave: "6", titulo: "6", valor: "6"),
      ZSelectionItem(chave: "7", titulo: "7", valor: "7"),
      ZSelectionItem(chave: "8", titulo: "8", valor: "8"),
      ZSelectionItem(chave: "9", titulo: "9", valor: "9"),
      ZSelectionItem(chave: "10", titulo: "10", valor: "10"),
      ZSelectionItem(chave: "11", titulo: "11", valor: "11"),
      ZSelectionItem(chave: "12", titulo: "12", valor: "12"),
      ZSelectionItem(chave: "13", titulo: "13", valor: "13"),
      ZSelectionItem(chave: "14", titulo: "14", valor: "14"),
      ZSelectionItem(chave: "15", titulo: "15", valor: "15"),
      ZSelectionItem(chave: "16", titulo: "16", valor: "16"),
      ZSelectionItem(chave: "17", titulo: "17", valor: "17"),
      ZSelectionItem(chave: "18", titulo: "18", valor: "18"),
      ZSelectionItem(chave: "19", titulo: "19", valor: "19"),
      ZSelectionItem(chave: "20", titulo: "20", valor: "20"),
    ];
    listaSelecaoRespostas = [
      ZSelectionItem(chave: "2", titulo: "2", valor: "2"),
      ZSelectionItem(chave: "3", titulo: "3", valor: "3"),
      ZSelectionItem(chave: "4", titulo: "4", valor: "4"),
    ];
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: new Text("TESTE"),
      ),
      body: new Container(
        child: ZHeader(
          initiallyExpanded: true,
          titulo: "Giuliano Ortiz Goria",
          children: <Widget>[
            new Container(
              color: const Color(0xffF0F0F0),
              padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
            )
          ],
          zTipos: ZTipoHeader.isExpansion,
        ),
      ),
    );
  }
}
