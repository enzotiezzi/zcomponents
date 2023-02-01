import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:z_components/components/z-cargo.dart';
import 'package:z_components/components/z-escala.dart';
import 'package:z_components/components/z-baseline.dart';
import 'package:flutter/cupertino.dart';
import 'package:z_components/components/utils/theme.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/components/z-progress-dialog.dart';
import "package:z_components/view-model/batida-viewmodel.dart";
import "package:z_components/view-model/z-tree-view-viewmodel.dart";
import 'dart:convert' show json;
import 'package:z_components/view-model/atualizar-dados-viewmodel.dart';
import 'package:z_components/components/confirmacao-de-previsto/confirmar-previsto.dart';
import 'package:z_components/view-model/z-dynamic-form-viewmodel.dart';
import 'package:z_components/api/formulario/i-formulario-service.dart';
import 'package:z_components/api/formulario/formulario-service.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/view-model/colaborador-documento-viewmodel.dart';
import 'package:z_components/components/z-sequencia/z-sequencia.dart';
import 'package:z_components/components/z-collection/z-collection.dart';
import 'package:z_components/components/z-collection/z-collection-item.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:z_components_example/tela-teste-card.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  List<ColaboradorDocumentoViewModel> documentos = [
    ColaboradorDocumentoViewModel(
        nomeDocumento: "RG",
        campos: [],
        status: "",
        horizontalOuVertical: "",
        idColaborador: "",
        idDocumento: "",
        idImagemDocumento: "",
        qtdePaginaUpload: "0"),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new TelaTesteCard(),
    );
  }
}

class ComponentExemploClasse extends StatefulWidget {
  @override
  _ComponentExemploClasseState createState() => _ComponentExemploClasseState();
}

class _ComponentExemploClasseState extends State<ComponentExemploClasse> {
  var controllerEmail = new TextEditingController();
  var controlerPadrao = new TextEditingController();
  var controllerNome = new TextEditingController();
  var controllerCPF = new TextEditingController();
  var controllerCelular = new TextEditingController();
  var controllerData = new TextEditingController();
  var controllerSenha = new TextEditingController();
  var controllerRepetirSenha = new TextEditingController();
  var controllerRua = new TextEditingController();
  var controllerCEP = new TextEditingController();
  var controllerCNPJ = new TextEditingController();
  var controllerNumero = new TextEditingController();
  var textEditingControllerNome = new TextEditingController();
  var textEditingControllerNomeB = new TextEditingController();

  final key = GlobalKey<ZProgressDialogState>();
  late FocusNode inputPadraoFocus;
  late FocusNode nomeFocus;
  late FocusNode emailFocus;
  late FocusNode cpfFocus;
  late FocusNode celularFocus;
  late FocusNode dataFocus;
  late FocusNode ruaFocus;
  late FocusNode numeroFocus;
  late FocusNode cepFocus;
  late FocusNode cnpjFocus;
  late FocusNode focusNodeNome;
  var focusNodeNomeB = new FocusNode();

  bool value = false;
  late ZBaseLine valideNome;
  late ZBaseLine valideCPF;
  late ZBaseLine valideData;
  late ZBaseLine valideEmail;
  late ZBaseLine valideCelular;
  bool isSwitched = true;

  var _controllerFim = new TextEditingController();
  var _controllerIntervalo = new TextEditingController();
  var _controllerHorarioInicio = new TextEditingController();

  var _keyEscala = new GlobalKey<ZEscalaState>();

  var _keyCargo = new GlobalKey<ZCargoState>();

  late String vp;
  late String nomeeee;
  late String cpf;

  var _keyStatus = new GlobalKey<ZCollectionState>();

  double valuess = 0.1;

  List<String> titulos = [
    "Lista de Documentos",
    "Espelho de Ponto",
    "Gestão de Ponto",
    "Atestados",
    "Histórico Alocações",
    "Histórico Status",
    "Histórico FériasHistórico Férias",
    "Histórico Afastamento",
    "Dependentes"
  ];
  List<IconData> icones = [
    Icons.assignment,
    Icons.list,
    Icons.add_to_home_screen,
    Icons.attach_file,
    Icons.fastfood,
    Icons.add_circle_outline,
    Icons.backup,
    Icons.voice_chat,
    Icons.view_stream
  ];

  List<dynamic> listaOnTap = [
    () {
      print("1");
    },
    () {
      print("2");
    },
    () {
      print("3");
    },
    () {
      print("4");
    },
    () {
      print("5");
    },
    () {
      print("6");
    },
    () {
      print("7");
    },
    () {
      print("8");
    },
    () {
      print("9");
    },
  ];

  late List<ZTreeViewViewModel> zTreeViewViewModel;

  late List<ZTreeViewViewModel> zTreeViewViewModel2;

  late List<ZTreeViewViewModel> zTreeViewViewModel2Filho;
  late List<ZTreeViewViewModel> zTreeViewViewModel2FilhoFilho;
  late List<ZTreeViewViewModel> zTreeViewViewModel2FilhoFilhoFilho;

  late List<ZTreeViewViewModel> zTreeViewViewModel3;

  late List<ZCollectionItem> listaTesteSkipTake;

  List<ZBatidaViewModel> listBatidas = [];
  List<ZDynamicFormViewModel> lista = [];
  List<ZDynamicFormViewModel> listaEnvio = [];
  IFormularioService iFormularioService = new FormularioService(
      "eyJhbGciOiJSUzI1NiIsImtpZCI6ImM0YWQ5OTFiMzk0NDIzNzEzZDlkZGI3ZWQzYzRlN2Q3IiwidHlwIjoiSldUIn0.eyJuYmYiOjE2MjIyMTExMDYsImV4cCI6MTYyMjIxNDcwNiwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIiLCJhdWQiOlsiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIvcmVzb3VyY2VzIiwibW9sdHJlcy5hY2Vzc28uYXBpIl0sImNsaWVudF9pZCI6IlpHZXN0b3IiLCJzdWIiOiJiYmMwN2RkYS1hMzQ0LTQ3ZWQtOTRkNC1mZDg0NTI2Y2E3ODgiLCJhdXRoX3RpbWUiOjE2MjIxMjcyMjYsImlkcCI6ImxvY2FsIiwiQXNwTmV0LklkZW50aXR5LlNlY3VyaXR5U3RhbXAiOiJPWjRZREFURVFYRUM3RlNHTjRHNFhDTkIyN0c1UFhBUiIsImFjY291bnQiOiJaZWxsYXIyIiwiaWRBY2NvdW50IjoiNDg2YTQ5YjMtNDdkMS00ZDc2LTgwZGYtMDc5ZWI4MmQ2ZDhmIiwiaWRDb2xhYm9yYWRvciI6IjE2QTgwNDE1LUQyODItNEFDQS04NDMxLThDN0YwNjkzQjE3QiIsInByZWZlcnJlZF91c2VybmFtZSI6IjQzOC4xOTcuNzE4LTE2IiwiZW1haWwiOiJibGFibGFAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOmZhbHNlLCJuYW1lIjoiRW56byBUaWV6emkiLCJwaG9uZV9udW1iZXIiOiIoMTEpOSA5NzE3LTI1NDQiLCJzY29wZSI6WyJvcGVuaWQiLCJwcm9maWxlIiwiZW1haWwiLCJtb2x0cmVzLmFjZXNzby5hcGkuZnVsbCIsIm9mZmxpbmVfYWNjZXNzIl0sImFtciI6WyJwd2QiXX0.hr8JAZBnpOsDvzXgujbajDIAUFp_yZZHXhTHivB-4titwj3_zClaLQyZL1NlW525vknWlD8hY6S1c3mlq6g9Ws2P_sxjhRqE4eUoEJQ6-6UgUdHZDTJSdIZu7B6bp1SY3Al5QPkyLfffAmG0fAFQLTXu746ISVR_dSjOuxidnpT6KsKHG48VLUgpJd9tS3X5hUanNF3oU-rnbiLtt_5TSYTKqrIDdBCW5LxG52MMoWFXYfQtCBZUb_Bd6q68_DAdsyVCxhvmnGFSzJSLyxdQhjkHPa-MWJK4hCRecvZXQNWx-QlrzjuU0F0UcIqSMtUsIq99gkh3XPoDJi31mgKxZg");
  late DialogUtils _dialogUtils;
  List<String> orem = [
    "ENTRADA",
    "SAÍDA",
    "ENTRADA",
    "SAÍDA",
    "ENTRADA",
    "SAÍDA"
  ];

  @override
  void initState() {
    zTreeViewViewModel2FilhoFilho = [];
    zTreeViewViewModel2 = [];
    zTreeViewViewModel = [];
    zTreeViewViewModel3 = [];
    zTreeViewViewModel2Filho = [];
    zTreeViewViewModel2FilhoFilhoFilho = [];
    listaTesteSkipTake = [];

    listaTesteSkipTake = [
      ZCollectionItem(
          chave: "Universidade", titulo: "Universidade", valor: "Universidade"),
      ZCollectionItem(chave: "1", titulo: "1", valor: "1"),
      ZCollectionItem(chave: "2", titulo: "2", valor: "2"),
      ZCollectionItem(chave: "3", titulo: "3", valor: "3"),
      ZCollectionItem(chave: "4", titulo: "4", valor: "4"),
      ZCollectionItem(chave: "5", titulo: "5", valor: "5"),
      ZCollectionItem(chave: "6", titulo: "6", valor: "6"),
      ZCollectionItem(chave: "7", titulo: "7", valor: "7"),
      ZCollectionItem(chave: "8", titulo: "8", valor: "8"),
      ZCollectionItem(chave: "9", titulo: "9", valor: "9"),
      ZCollectionItem(chave: "10", titulo: "10", valor: "10"),
      ZCollectionItem(chave: "11", titulo: "11", valor: "11"),
      ZCollectionItem(chave: "12", titulo: "12", valor: "12"),
      ZCollectionItem(chave: "13", titulo: "13", valor: "13"),
      ZCollectionItem(chave: "14", titulo: "14", valor: "14"),
      ZCollectionItem(chave: "15", titulo: "15", valor: "15"),
      ZCollectionItem(chave: "16", titulo: "16", valor: "16"),
      ZCollectionItem(chave: "17", titulo: "17", valor: "17"),
      ZCollectionItem(chave: "18", titulo: "18", valor: "18"),
      ZCollectionItem(chave: "19", titulo: "19", valor: "19"),
      ZCollectionItem(chave: "20", titulo: "20", valor: "20"),
    ];
    zTreeViewViewModel2FilhoFilhoFilho = [
      new ZTreeViewViewModel(
          nome: "FILHOF FO FLHIFO",
          idNivelPai: "118",
          idNivel: "hghgh",
          filhos: zTreeViewViewModel3),
    ];
    super.initState();
    zTreeViewViewModel2FilhoFilho = [
      new ZTreeViewViewModel(
          nome: "FILHOF FO FLHIFO",
          idNivelPai: "11",
          idNivel: "118",
          filhos: zTreeViewViewModel2FilhoFilhoFilho),
    ];

    zTreeViewViewModel2 = [
      new ZTreeViewViewModel(
          nome: "sdfsdf",
          idNivelPai: "1",
          idNivel: "11",
          filhos: zTreeViewViewModel2FilhoFilho),
      new ZTreeViewViewModel(
          nome: "ert ",
          idNivelPai: "1",
          idNivel: "12",
          filhos: zTreeViewViewModel3),
      new ZTreeViewViewModel(
          nome: "ert ert",
          idNivelPai: "1",
          idNivel: "32",
          filhos: zTreeViewViewModel3),
      new ZTreeViewViewModel(
          nome: "Huilf",
          idNivelPai: "1",
          idNivel: "52",
          filhos: zTreeViewViewModel3)
    ];

    zTreeViewViewModel = [
      new ZTreeViewViewModel(
          nome:
              "posicao alocao alocaocalocaro alocao alocaocalocaro alocaocalocaro ",
          idNivel: "1",
          filhos: zTreeViewViewModel2),
      new ZTreeViewViewModel(
          nome: "JUsytificativadss vAMOS VEWR QUE MEH MAIS",
          idNivel: "2",
          filhos: zTreeViewViewModel2Filho),
    ];

    zTreeViewViewModel2Filho = [
      new ZTreeViewViewModel(
          nome: "Huilf",
          idNivelPai: "2",
          idNivel: "52",
          filhos: zTreeViewViewModel3)
    ];

    listBatidas = [
      ZBatidaViewModel(ordem: "ENTRADA", horarioBatidaRealizada: "07:30"),
      ZBatidaViewModel(
          ordem: "INÍCIO INTERVALO", horarioBatidaRealizada: "12:30"),
      ZBatidaViewModel(ordem: "FIM INTERVALO", horarioBatidaRealizada: "13:30"),
      ZBatidaViewModel(ordem: "SAÍDA", horarioBatidaRealizada: "14:30"),
      ZBatidaViewModel(ordem: "ENTRADA", horarioBatidaRealizada: "18:00"),
    ];
    _dialogUtils = new DialogUtils(context);
    focusNodeNome = new FocusNode();
    nomeFocus = new FocusNode();
    emailFocus = new FocusNode();
    cpfFocus = new FocusNode();
    celularFocus = new FocusNode();
    dataFocus = new FocusNode();
    ruaFocus = new FocusNode();
    numeroFocus = new FocusNode();
    cepFocus = new FocusNode();
    cnpjFocus = new FocusNode();
    inputPadraoFocus = new FocusNode();

    //montarFormulario();
//    await montarLista();
//    await enviarFormulario();
    // super.initState();

    // _db = new ZDatabase(version: 2, dbName: "teste", entities: [new Pessoa(), new Monstro()]);

    /*  _db.init().then((_){
      _query();
    });*/
  }

/*  void _query() async{
    IPessoaRepository rep = new PessoaRepository();

    rep.insert(new Pessoa(nome: "Andreza", idade: 20));

    IMonstroRepository _monstroRepository = new MonstroRepository();

    _monstroRepository.insert(new Monstro(nome: "Gustavo", habilidade: "Super forca"));

    var a = await rep.findById(1);
    var b = await rep.listarPessoas();


    var ma = await _monstroRepository.findById(1);

    print("");
  }*/

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ConfirmarPrevisto(
                          dadosViewModel: AtualizarDadosViewModel(
                              cargo: "Dev",
                              centroCusto: "Zellar",
                              escala: "5x2",
                              horaInicio: "08:00",
                              horaTermino: "17:00",
                              nomeColaborador: "Giuliano Ortiz Goria",
                              statusColaborador: "Ativo",
                              tempoIntervalo: "01:00"),
                        )));
          },
        ),
        body: new Container(
          padding: EdgeInsets.only(top: 50.0),
          child: new Column(
            children: <Widget>[
              /*   new Container(
              padding: EdgeInsets.only(top: 16.0),
              child: new ZInputCelular(
                themeData: CustomTheme.appTheme,
                  celularFocus: celularFocus,
                  controllerCelular: controllerCelular),
            ),
            new Divider(
              height: 1.0,
            ),
            new Container(
                padding: EdgeInsets.only(top: 16.0),
                child: new ZInputDataNascimento(themeData: CustomTheme.appTheme,
                  enabled: true,
                  dataFocus: dataFocus,
                  controllerData: controllerData,
                  onChange: (text) {},
                )),
            new Divider(
              height: 1.0,
            ),
            ZCollection(
              lista: listaTesteSkipTake,
              titulo: "Escala",
              themeData: Theme.of(context),
              onChange: (item) {},
            ),*/

              new ZSequencia(
                escala: "5x2",
                primeiroDiaEscala: "2020-12-25 00:00:00",
                themeData: CustomTheme.appTheme,
                data: DateTime.now(),
              ),
            ],
          ),
        ));
  }

  void showAlertDialogNew() async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => ZAlertDialog(
              zDialog: ZDialog.erro,
              child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.all(20),
                        child: new Text(
                          "Dialog Test",
                          style: new TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          bottom: 10.0,
                        ),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: new Column(
                          children: <Widget>[
                            new Text("Este aqui eh um dialogo teste de um tipo",
                                style: new TextStyle(fontSize: 14),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      )
                    ],
                  ),
                  new Divider(
                    color: const Color(0xffdbdbdb),
                  ),
                  new Container(
                    child: new InkWell(
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(20.0)),
                      splashColor: const Color(0xffe6e6e6),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: new Container(
                        padding: const EdgeInsets.all(12),
                        child: new Text(
                          "ENTENDI",
                          style: new TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                  )
                ],
              ),
            ));
  }

  void showAlertDialogNewAlert() async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => ZAlertDialog(
              zDialog: ZDialog.alert,
              child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.all(20),
                        child: new Text(
                          "Dialog Test",
                          style: new TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          bottom: 10.0,
                        ),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: new Column(
                          children: <Widget>[
                            new Text("Este aqui eh um dialogo teste de um tipo",
                                style: new TextStyle(fontSize: 14),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      )
                    ],
                  ),
                  new Divider(
                    color: const Color(0xffdbdbdb),
                  ),
                  new Container(
                    child: new InkWell(
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(20.0)),
                      splashColor: const Color(0xffe6e6e6),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: new Container(
                        padding: const EdgeInsets.all(12),
                        child: new Text(
                          "ENTENDI",
                          style: new TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                  )
                ],
              ),
            ));
  }

  void showAlertDialogNewSuccess() async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => ZAlertDialog(
              zDialog: ZDialog.sucess,
              child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.all(20),
                        child: new Text(
                          "Dialog Test",
                          style: new TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          bottom: 10.0,
                        ),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: new Column(
                          children: <Widget>[
                            new Text("Este aqui eh um dialogo teste de um tipo",
                                style: new TextStyle(fontSize: 14),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      )
                    ],
                  ),
                  new Divider(
                    color: const Color(0xffdbdbdb),
                  ),
                  new Container(
                    child: new InkWell(
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(20.0)),
                      splashColor: const Color(0xffe6e6e6),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: new Container(
                        padding: const EdgeInsets.all(12),
                        child: new Text(
                          "ENTENDI",
                          style: new TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                  )
                ],
              ),
            ));
  }

  void showAlertDialogNewNormal() async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => ZAlertDialog(
              zDialog: ZDialog.normal,
              child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.all(20),
                        child: new Text(
                          "Dialog Test",
                          style: new TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          bottom: 10.0,
                        ),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: new Column(
                          children: <Widget>[
                            new Text("Este aqui eh um dialogo teste de um tipo",
                                textAlign: TextAlign.center),
                          ],
                        ),
                      )
                    ],
                  ),
                  new Divider(
                    color: const Color(0xffdbdbdb),
                  ),
                  new Container(
                    child: new InkWell(
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(20.0)),
                      splashColor: const Color(0xffe6e6e6),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: new Container(
                        padding: const EdgeInsets.all(12),
                        child: new Text(
                          "ENTENDI",
                          style: new TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                  )
                ],
              ),
            ));
  }

  void showAlertDialogNewProgress() async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => ZAlertDialog(
              zDialog: ZDialog.linearLoad,
              child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.all(20),
                        child: new Text(
                          "Dialog Test",
                          style: new TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          bottom: 10.0,
                        ),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: new Column(
                          children: <Widget>[
                            new Text("Este aqui eh um dialogo teste de um tipo",
                                style: new TextStyle(fontSize: 14),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      )
                    ],
                  ),
                  new Divider(
                    color: const Color(0xffdbdbdb),
                  ),
                  new Container(
                    child: new InkWell(
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(20.0)),
                      splashColor: const Color(0xffe6e6e6),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: new Container(
                        padding: const EdgeInsets.all(12),
                        child: new Text(
                          "ENTENDI",
                          style: new TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                  )
                ],
              ),
            ));
  }

  void refrehs() {
    Future.delayed(Duration(seconds: 3), () {
      key.currentState?.refresh(0.35, "Carregando Fotos");
    });
    Future.delayed(Duration(seconds: 6), () {
      key.currentState?.refresh(0.6, "So mais um momento");
    });
    Future.delayed(Duration(seconds: 9), () {
      key.currentState?.refresh(0.85,
          "Ewerweerwerwer wer wer wer weljr nweljnr wojern weojnrowjen roejwn");
    });
    Future.delayed(Duration(seconds: 12), () {
      key.currentState?.refresh(1.0,
          "Ewerweerwerwer wer wer wer weljr nweljnr wojern weojnrowjen roejwn",
          success: true);
    });
    Future.delayed(Duration(seconds: 15), () {
      Navigator.pop(context);
    });
  }

  void montarLista() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/carlos.json");
    var responseBody = json.decode(data);

    lista = (responseBody as List)
        .map((x) => ZDynamicFormViewModel.fromJson(x))
        .toList();

    setState(() {
      print(lista);
    });
  }

  void montarFormulario() async {
    var formulario = await iFormularioService.buscarFormularios();

    var formularioSellecionado = formulario!.first;

    lista = (await iFormularioService
        .montarFormulario(formularioSellecionado.idModelo!))!;

    setState(() {
      print(lista);
    });
  }

  void enviarFormulario() async {
    lista.forEach((item) async {
      ZDynamicFormViewModel zDynamicFormViewModel = new ZDynamicFormViewModel(
        sistema: "teste",
        descricao: item.descricao,
        idAtributo: item.idAtributo,
        idModelo: item.idModelo,
        idTipo: item.idTipo,
        label: item.label,
        modelo: item.modelo,
        multiplaEscolha: item.multiplaEscolha,
        nomeCampo: item.nomeCampo,
        obrigatorio: item.obrigatorio,
        opcoes: item.opcoes,
        ordem: item.ordem,
        tamanhoMaximo: item.tamanhoMaximo,
        tipo: item.tipo,
        versao: item.versao,
      );
       listaEnvio.add(zDynamicFormViewModel);
    });

    print(listaEnvio);
  }

  Future showProgress() async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => ZProgressDialog(
              message: "Executando!",
              barrierDismissible: false,
              progressBarValue: valuess,
              key: key,
            ));
  }

  @override
  void afterFirstLayout(BuildContext context) {}
}

class AppSwitch with ChangeNotifier {
  AppSwitch();

  bool _value = false;
  String _text = "";

  set value(bool text) {
    _value = text;
    notifyListeners();
  }

  bool get value => _value;

  set text(String text) {
    _text = text;
    notifyListeners();
  }

  String get text => _text;
}
