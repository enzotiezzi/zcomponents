
import 'package:z_components/api/z-estrutura-empresa/nivel.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-selection/z-selection.dart';
import 'package:z_components/components/z-selection/z-selection-item.dart';
import 'package:z_components/components/z-estrutura-empresa/bloc/z-estrutura-empresa-cubit.dart';
import 'package:z_components/components/z-estrutura-empresa/z-estrutura-empresa.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/styles/main-style.dart';

class TelaTesteCard extends StatefulWidget {

  ZEstruturaEmpresaCubit bloc;

  TelaTesteCard({this.bloc});

  @override
  _TelaTesteCardState createState() => _TelaTesteCardState();
}

class _TelaTesteCardState extends State<TelaTesteCard> {
  List<ZSelectionItem> listaSelecao = [];

  final zEstrutura = GlobalKey();

  GlobalKey<State> key =
  new GlobalKey<State>();

  Nivel nivelSelcionado = new Nivel();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: new ZEstruturaEmpresa(
                key: key,
                bloc: widget.bloc,
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

                  nivelSelcionado = nivel;
                },
                token: "eyJhbGciOiJSUzI1NiIsImtpZCI6ImFhNmNiYWFjMmE0NDc3MThhNDg3YjNkOWE5YWU4YWM0IiwidHlwIjoiSldUIn0.eyJuYmYiOjE2MzA2MDg2NjksImV4cCI6MTYzMDYxMjI2OSwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIiLCJhdWQiOlsiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIvcmVzb3VyY2VzIiwibW9sdHJlcy5hY2Vzc28uYXBpIl0sImNsaWVudF9pZCI6IlpSZWNydXRhbWVudG8iLCJzdWIiOiIwMjFmOTE4Mi0zZjQxLTRmMGEtYWFkYy00MDc3NmU2MGQwNGMiLCJhdXRoX3RpbWUiOjE2MzA1MjE5ODEsImlkcCI6ImxvY2FsIiwiQXNwTmV0LklkZW50aXR5LlNlY3VyaXR5U3RhbXAiOiIzS0U2RUNEUlRIR0dYQURBTUNXR1pHQUVEWDJEM1lPTCIsImFjY291bnQiOiJaZWxsYXIyIiwiaWRBY2NvdW50IjoiMjM4MzE3ODMtOGY4Yy00MTY5LWFjZTUtODlmYzBjMThlNGFmIiwiaWRDb2xhYm9yYWRvciI6IjE1ODQyQzJFLUM3RDctNERENS04RkE5LUZFMzNDQkQ2NENFQyIsInByZWZlcnJlZF91c2VybmFtZSI6IjQyNi45MTAuMjU4LTYxIiwiZW1haWwiOiJsdWl6Lmx1Y2lhQHplbGxhci5jb20uYnIiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsInBob25lX251bWJlcl92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJMdWl6IEx1Y2lhIE5ldG8iLCJwaG9uZV9udW1iZXIiOiIxMTk0ODQ4NDEyMCIsInNjb3BlIjpbIm9wZW5pZCIsInByb2ZpbGUiLCJlbWFpbCIsIm1vbHRyZXMuYWNlc3NvLmFwaS5mdWxsIiwib2ZmbGluZV9hY2Nlc3MiXSwiYW1yIjpbInB3ZCJdfQ.v1uH6wcti8cQKrLY3Lj02JQTpJglSdI2KOhDIp_quKXREkyvxAHUIo4wPJFJXI21DJLHQ3xVg900qgElnYOlfNMriFG7xNKAcwaMOs3p0aLxtmf1b_pFhkmTB0WTnfdsZ6GdNPkuybXDfGVMXTM0BhSBREcmixsn3Yxly8qULDoQy-9pnfeYu66AZj3oXwEi8VfItmB7AX0zY4CaaMLu8XXI_iTFXAbmPW0DQ1brv61PABPUawo_XOtzXN0H3jqM0hATrjzbp2Qv9Xlu4h0bBIhBnLThGR-uOkxlfaxPgwwZsYDnBvhfH_n_gYdeBMJOoMNCyid-e3OPcymnekCMrA",
                headerAtivo: false,
              ),
            ),
            new Container(
              child: new Material(
                elevation: 4,
                child: new Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height / 8,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      new RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: (){

                          widget.bloc.adicionarNivel(new Nivel(
                            nome: "Teste de Nivel",
                            niveis: [],
                            idNivel: "",
                          ));
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            new Container(
                              padding: const EdgeInsets.only(right: 40, left: 40),
                              child: Text(
                                "FINALIZAR",
                                style: Theme.of(context).textTheme.button.copyWith(
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
