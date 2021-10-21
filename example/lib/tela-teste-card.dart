import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-item-tile-convite.dart';
import 'package:z_components/components/z-selection/z-selection-item.dart';
import 'package:z_components/components/z-collection/z-collection-item.dart';
import 'package:z_components/components/z-collection/z-collection.dart';
import 'package:z_components/components/z-selection/z-selection.dart';
import 'package:z_components/components/z-inputs/z-input-data-padrao.dart';
import 'package:z_components/components/z-item-tile-pergunta-adicional.dart';
import 'package:z_components/components/utils/dialog-pesquisa-organizacional.dart';
import 'package:z_components/view-model/dialog-pesquisa-orgazinacional-viewmodel.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/config/z-dialog.dart';

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
      appBar: AppBar(
        leading: new Text("TESTE"),
      ),
      body: new Container(
        child: new Column(
          children: [
            new ZInputDataPadrao(
              themeData: Theme.of(context),
              controllerData: TextEditingController(),
              dataFocus: FocusNode(),
              legenda: "Data de inicio",
              validacao: (validacaoDataInicio) {},
            ),
            new ZInputDataPadrao(
              themeData: Theme.of(context),
              controllerData: TextEditingController(),
              dataFocus: FocusNode(),
              legenda: "Data final",
              validacao: (validacaoDataFinal) {},
            ),
            new ZSelection(
              titulo: "Teste",
              lista: listaSelecao,
              listaRespostas: listaSelecaoRespostas,
              themeData: Theme.of(context),
              onChange: (value) {},
            ),
            ZItemTilePerguntaAdicional(
              textoPergunta: "Teste",
              onPressed: () {},
            ),
            RaisedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => DialogIntroducaoPesquisaOrganizacional(
                      dialogPesquisaOrgazinacionalViewModel:
                          new DialogPesquisaOrgazinacionalViewModel(
                        titulo:
                            "Queremos saber como está sua experiência no Grupo GTP - Conte pra gente!",
                        descricaoCentral:
                            "Está pesquisa é ANÔNIMA e de acesso exclusivo do RH",
                        textoBotaoConfirmar: "RESPONDER",
                        textoBotaoCancelar: "IGNORAR",
                        onTapBotaoConfirmar: () {},
                        onTapBotaoCancelar: () async {
                          Navigator.of(context).pop();
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) => ZAlertDialog(
                              zDialog: ZDialog.alert,
                              child: new Column(
                                children: <Widget>[
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 8, top: 4),
                                        child: new Text("Atenção",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Container(
                                        padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          bottom: 4,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: new Column(
                                          children: <Widget>[
                                            new Text(
                                                "Você deseja responder está pesquisa "
                                                "em outro momento,quando se sentir mais "
                                                "à vontade, ou não deseja mais visualiza-la?",
                                                textAlign: TextAlign.center),
                                            new Divider(
                                              color: const Color(0xffdbdbdb),
                                            ),
                                            new Column(
                                              children: [
                                                new Container(
                                                  child: new InkWell(
                                                    borderRadius:
                                                        new BorderRadius.all(
                                                            const Radius
                                                                .circular(30)),
                                                    splashColor:
                                                        const Color(0xffe6e6e6),
                                                    onTap: () async {
                                                      Navigator.of(context)
                                                          .pop();
                                                      await showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return new ZAlertDialog(
                                                              zDialog: ZDialog
                                                                  .sucess,
                                                              child: new Column(
                                                                children: [
                                                                  new Container(
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            8,
                                                                        left:
                                                                            16,
                                                                        right:
                                                                            16,
                                                                        top:
                                                                            16),
                                                                    child:
                                                                        new Text(
                                                                      "A pesquisa estará disponível fora do seu horário de trabalho, "
                                                                      "para responde-la basta abrir o aplicativo",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  ),
                                                                  new Divider(
                                                                    height: 1.0,
                                                                  ),
                                                                  new Container(
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            8,
                                                                        top: 8),
                                                                    child:
                                                                        new GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: new Text(
                                                                          "OK"),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          });
                                                    },
                                                    child: new Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: new Text(
                                                        "RESPONDER DEPOIS",
                                                        style: new TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: MainStyle
                                                                    .get(
                                                                        context)
                                                                .fontSizeLeadinCancelar),
                                                      ),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 8),
                                                    ),
                                                  ),
                                                ),
                                                new Container(
                                                  child: new InkWell(
                                                    borderRadius:
                                                        new BorderRadius.all(
                                                            const Radius
                                                                .circular(30)),
                                                    splashColor:
                                                        const Color(0xffe6e6e6),
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: new Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: new Text(
                                                        "NÃO VISUALIZAR MAIS",
                                                        style: new TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: MainStyle
                                                                    .get(
                                                                        context)
                                                                .fontSizeLeadinCancelar),
                                                      ),
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
                      ),
                    ),
                  );
                },
                child: Text("Teste")),
          ],
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
