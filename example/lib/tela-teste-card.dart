import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-item-tile-convite.dart';
import 'package:z_components/components/z-selection/z-selection-item.dart';
import 'package:z_components/components/z-collection/z-collection-item.dart';
import 'package:z_components/components/z-collection/z-collection.dart';
import 'package:z_components/config/z-tipo-header.dart';
import 'package:z_components/components/z-header.dart';
import 'package:z_components/components/z-selection/z-selection.dart';
import 'package:z_components/components/z-inputs/z-input-data-padrao.dart';
import 'package:z_components/components/z-estrutura-empresa/z-estrutura-empresa.dart';
import 'package:z_components/components/z-estrutura-empresa/bloc/z-estrutura-empresa-cubit.dart';


class TelaTesteCard extends StatefulWidget {
  @override
  _TelaTesteCardState createState() => _TelaTesteCardState();
}

class _TelaTesteCardState extends State<TelaTesteCard> {
  List<ZSelectionItem> listaSelecao = [];
  List<ZSelectionItem> listaSelecaoRespostas = [];

  final zEstrutura = new GlobalKey();

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
      new ZSelectionItem(
          chave: "Universidade", titulo: "Universidade", valor: "Universidade"),
      new ZSelectionItem(
          chave: "1",
          titulo:
              "Instalador de isolantes térmicos de caldeira e tubulações de teste 123 testando overflow",
          valor: "Instalador de isolantes térmicos de caldeira e tubulações"),
      new ZSelectionItem(chave: "2", titulo: "2", valor: "2"),
      new ZSelectionItem(chave: "3", titulo: "3", valor: "3"),
      new ZSelectionItem(chave: "4", titulo: "4", valor: "4"),
      new ZSelectionItem(chave: "5", titulo: "5", valor: "5"),
      new ZSelectionItem(chave: "6", titulo: "6", valor: "6"),
      new ZSelectionItem(chave: "7", titulo: "7", valor: "7"),
      new ZSelectionItem(chave: "8", titulo: "8", valor: "8"),
      new ZSelectionItem(chave: "9", titulo: "9", valor: "9"),
      new ZSelectionItem(chave: "10", titulo: "10", valor: "10"),
      new ZSelectionItem(chave: "11", titulo: "11", valor: "11"),
      new ZSelectionItem(chave: "12", titulo: "12", valor: "12"),
      new ZSelectionItem(chave: "13", titulo: "13", valor: "13"),
      new ZSelectionItem(chave: "14", titulo: "14", valor: "14"),
      new ZSelectionItem(chave: "15", titulo: "15", valor: "15"),
      new ZSelectionItem(chave: "16", titulo: "16", valor: "16"),
      new ZSelectionItem(chave: "17", titulo: "17", valor: "17"),
      new ZSelectionItem(chave: "18", titulo: "18", valor: "18"),
      new ZSelectionItem(chave: "19", titulo: "19", valor: "19"),
      new ZSelectionItem(chave: "20", titulo: "20", valor: "20"),
    ];
    listaSelecaoRespostas = [
      new ZSelectionItem(chave: "2", titulo: "2", valor: "2"),
      new ZSelectionItem(chave: "3", titulo: "3", valor: "3"),
      new ZSelectionItem(chave: "4", titulo: "4", valor: "4"),
    ];
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body:Container(
        child: ZEstruturaEmpresa(
          token: "eyJhbGciOiJSUzI1NiIsImtpZCI6ImFhNmNiYWFjMmE0NDc3MThhNDg3YjNkOWE5YWU4YWM0IiwidHlwIjoiSldUIn0.eyJuYmYiOjE2MzI0MTYwMjEsImV4cCI6MTYzMjQxOTYyMSwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIiLCJhdWQiOlsiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIvcmVzb3VyY2VzIiwibW9sdHJlcy5hY2Vzc28uYXBpIl0sImNsaWVudF9pZCI6IlpSZWNydXRhbWVudG8iLCJzdWIiOiIwMjFmOTE4Mi0zZjQxLTRmMGEtYWFkYy00MDc3NmU2MGQwNGMiLCJhdXRoX3RpbWUiOjE2MzI0MTYwMjEsImlkcCI6ImxvY2FsIiwiQXNwTmV0LklkZW50aXR5LlNlY3VyaXR5U3RhbXAiOiIzS0U2RUNEUlRIR0dYQURBTUNXR1pHQUVEWDJEM1lPTCIsImFjY291bnQiOiJ6ZWxsYXIyIiwiaWRBY2NvdW50IjoiZGRiNDQwNzUtMmJjYS00MDIzLWJhYTktYmU3NmNjNWM3Mzk3IiwiaWRDb2xhYm9yYWRvciI6IjE1ODQyQzJFLUM3RDctNERENS04RkE5LUZFMzNDQkQ2NENFQyIsInByZWZlcnJlZF91c2VybmFtZSI6IjQyNi45MTAuMjU4LTYxIiwiZW1haWwiOiJsdWl6Lmx1Y2lhQHplbGxhci5jb20uYnIiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsInBob25lX251bWJlcl92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJMdWl6IEx1Y2lhIE5ldG8iLCJwaG9uZV9udW1iZXIiOiIxMTk0ODQ4NDEyMCIsInNjb3BlIjpbIm9wZW5pZCIsInByb2ZpbGUiLCJlbWFpbCIsIm1vbHRyZXMuYWNlc3NvLmFwaS5mdWxsIiwib2ZmbGluZV9hY2Nlc3MiXSwiYW1yIjpbInB3ZCJdfQ.iYdr58utZ1lIDMKSb-lEWeZB2bZZI9fXrnmfCytz4xq1j5K19FTnf9LiYuzIJ9SDZZ4ty3zp44hquUXWqAYjHv3RcuJG0rC8VN0RwVDKdNp4Lbmx8ChCy_jgflxkL-1-bEQXNxS-oYDD-8xucsmeM0LuODPzPkKMwxZ_j8EBMdBt2jF7MEssbRvk6d0FFKQx9PlsPELK-Akdkkfhnuj7y4UORoJ0I28nEneyZKSIe-UvMx6B4UYnuJ9wU56xtkTl5VC-1Vriy7aLPz26aF8m0-IEoMh6tJva4el_eU5xNR9EUknpGJmsorTRCXDUk1Xe7MACCMuDvi6Sxt75V3gGJA",
          headerAtivo: false,
          header: " ",
          bloc: ZEstruturaEmpresaCubit(),
          exibeIconeVoltar: true,

        ),
      ),
    );
  }

  Widget selectIcon(SelectStatus selectStatus) {
    switch (selectStatus) {
      case SelectStatus.EM_ANDAMENTO:
        return new Container(
            child: new Icon(
          Icons.article_outlined,
          size: 14,
          color: new Color(0xff2BBAB4),
        ));

      case SelectStatus.FINALIZADO:
        return new Container(
            child: new Icon(
          Icons.sd_card_outlined,
          size: 14,
          color: new Color(0xff2BBAB4),
        ));
      case SelectStatus.APROVADO:
        return new Container(
            child: new Icon(
          Icons.check_circle_outline,
          size: 14,
          color: new Color(0xff2BBAB4),
        ));

      case SelectStatus.NAO_LIDO:
        return new Container(
            child: new Icon(
          Icons.remove_red_eye_outlined,
          size: 14,
          color: Colors.red,
        ));
      case SelectStatus.LIDO:
        return new Container(
            child: new Icon(
          Icons.remove_red_eye_outlined,
          size: 14,
          color: new Color(0xff2BBAB4),
        ));

      case SelectStatus.VENCIDO:
        return new Container(
          child: new Icon(
            Icons.circle,
            color: Colors.red,
            size: 8,
          ),
        );
    }
  }
}
