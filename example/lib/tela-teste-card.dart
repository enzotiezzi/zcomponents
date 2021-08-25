

import 'package:flutter/material.dart';
import 'package:z_components/components/z-selection/z-selection.dart';
import 'package:z_components/components/z-selection/z-selection-item.dart';
import 'package:z_components/components/z-collection/z-collection-item.dart';
import 'package:z_components/components/z-endereco/z-input-endereco.dart';
import 'package:z_components/components/z-collection/z-collection.dart';
import 'package:z_components/components/z-inputs/z-input-email.dart';
import 'package:z_components/components/z-inputs/z-input-cnpj.dart';
import 'package:z_components/components/z-inputs/z-input-cpf.dart';
import 'package:z_components/components/z-inputs/z-input-data-expiracao.dart';
import 'package:z_components/components/z-inputs/z-input-data-de-nascimento.dart';
import 'package:z_components/components/z-inputs/z-input-name.dart';
import 'package:z_components/components/z-inputs/z-input-cep.dart';
import 'package:z_components/components/z-inputs/z-input-telefone-fixo.dart';
import 'package:z_components/components/z-inputs/z-input-celular.dart';
import 'package:z_components/components/z-inputs/z-input-generic.dart';
import 'package:z_components/components/z-estrutura-empresa/z-estrutura-empresa.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/styles/main-style.dart';

class TelaTesteCard extends StatefulWidget {
  @override
  _TelaTesteCardState createState() => _TelaTesteCardState();
}

class _TelaTesteCardState extends State<TelaTesteCard> {
  List<ZSelectionItem> listaSelecao = [];

  final zEstrutura = GlobalKey();

  TextEditingController cep = new TextEditingController();
  TextEditingController logradouro = new TextEditingController();
  TextEditingController numero = new TextEditingController();
  TextEditingController cidade = new TextEditingController();
  TextEditingController bairro = new TextEditingController();
  TextEditingController complemento = new TextEditingController();
  TextEditingController estado = new TextEditingController();
  List<ZCollectionItem> lista = [];

  GlobalKey<ZCollectionState> keyPorte =
  new GlobalKey<ZCollectionState>();

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
    setState(() {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new ZEstruturaEmpresa(
      onInfoSelected: () {
        return showDialog(
          context: context,
          builder: (BuildContext context) => new ZAlertDialog(
            zDialog: ZDialog.normal,
            child: new Column(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      margin: const EdgeInsets.all(16),
                      child: new Text("INTRODUÇÃO",
                          style: MainStyle.get(context)
                              .styleTittleDialog),
                    ),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                        bottom: 8,
                      ),
                      width: MediaQuery.of(context).size.width *
                          0.7,
                      child: new Column(
                        children: <Widget>[
                          new Text(
                              "Visualize o painel que representa "
                                  "a sua Estrutura de Empresa e "
                                  "adicione uma Empresa, "
                                  "Filial ou Departamento Clicando no Botão"
                                  "\n  \"+\".",
                              style: new TextStyle(
                                  fontSize: MainStyle.get(
                                      context)
                                      .fontSizeEntradaSaida),
                              textAlign: TextAlign.center),
                          new Divider(
                            color: const Color(0xffdbdbdb),
                          ),
                          new Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: [
                              new Container(
                                child: new InkWell(
                                  borderRadius:
                                  new BorderRadius.all(
                                      const Radius.circular(
                                          20)),
                                  splashColor:
                                  const Color(0xffe6e6e6),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: new Container(
                                    padding:
                                    const EdgeInsets.all(
                                        16),
                                    child: new Text(" OK ",
                                        style: new TextStyle(
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: MainStyle
                                                .get(
                                                context)
                                                .fontSizeLeadinCancelar)),
                                    margin:
                                    const EdgeInsets.only(
                                        bottom: 8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      onNodeSelected: (nivel){
        print(nivel);
      },
      token: "eyJhbGciOiJSUzI1NiIsImtpZCI6ImFhNmNiYWFjMmE0NDc3MThhNDg3YjNkOWE5YWU4YWM0IiwidHlwIjoiSldUIn0.eyJuYmYiOjE2Mjk4MTE2MzcsImV4cCI6MTYyOTgxNTIzNywiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIiLCJhdWQiOlsiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIvcmVzb3VyY2VzIiwibW9sdHJlcy5hY2Vzc28uYXBpIl0sImNsaWVudF9pZCI6IlpSZWNydXRhbWVudG8iLCJzdWIiOiIwMjFmOTE4Mi0zZjQxLTRmMGEtYWFkYy00MDc3NmU2MGQwNGMiLCJhdXRoX3RpbWUiOjE2Mjk4MTE2MzUsImlkcCI6ImxvY2FsIiwiQXNwTmV0LklkZW50aXR5LlNlY3VyaXR5U3RhbXAiOiIzS0U2RUNEUlRIR0dYQURBTUNXR1pHQUVEWDJEM1lPTCIsImFjY291bnQiOiJaZWxsYXIyIiwiaWRBY2NvdW50IjoiOGU2ZWI2MzItYjcwNy00MTNmLWExNTItM2NmZmQxZjk4MmI1IiwiaWRDb2xhYm9yYWRvciI6IjE1ODQyQzJFLUM3RDctNERENS04RkE5LUZFMzNDQkQ2NENFQyIsInByZWZlcnJlZF91c2VybmFtZSI6IjQyNi45MTAuMjU4LTYxIiwiZW1haWwiOiJsdWl6Lmx1Y2lhQHplbGxhci5jb20uYnIiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsInBob25lX251bWJlcl92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJMdWl6IEx1Y2lhIE5ldG8iLCJwaG9uZV9udW1iZXIiOiIxMTk0ODQ4NDEyMCIsInNjb3BlIjpbIm9wZW5pZCIsInByb2ZpbGUiLCJlbWFpbCIsIm1vbHRyZXMuYWNlc3NvLmFwaS5mdWxsIiwib2ZmbGluZV9hY2Nlc3MiXSwiYW1yIjpbInB3ZCJdfQ.wzop2ZnRcyrQYmDzF3n7OyG3m_o3pb_BHvibO853CqZE3pCC17zU4D2g_OsvJLugu8Bauu1CT7_RcraVVQ73Q-i3lqT84wIz1WBp5OiFDKdBe_EdyoD0fBBo5v6ksmXm0YDlKPzyOB0A4Xenvjqj10X4NCWGmZI4Y6lX9xf9jHE0q-4VlNEuBqBPSnGucI8R9zb-gniPdjhxXxxGX4X34oIeM109knHK1lMiruGWsnlggzxA_cp9P8uZWbe3NbURrWxUMezzmn14yIfYtBfHq7sxRmx8Ml5VHOlGxuYoBSVV_e8vfp-vAQxAPTf253J3QyEp8HsHKxgWH_Mxhdf9Eg",
      headerAtivo: false,);
  }
}
