import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:z_components/components/z-collection.dart';
import 'package:z_components/components/z-cargo.dart';
import 'package:z_components/components/z-escala.dart';
import 'package:z_components/components/z-baseline.dart';
import 'package:flutter/cupertino.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/components/z-conta/z-conta.dart';
import 'package:z_components/components/z-progress-dialog.dart';
import 'package:z_components/components/z-checkbox/z-checkbox.dart';
import 'package:z_components/view-model/z-checkbox-viewmodel.dart';
import 'package:z_components/components/z-inputs/z-input-generic.dart';
import 'package:z_components/config/z-tipos-baseline.dart';
import 'package:z_components/view-model/atualizar-dados-viewmodel.dart';
import 'package:after_layout/after_layout.dart';
import "package:z_components/components/z-inputs/z-input-data-de-nascimento.dart";
import 'package:z_components/components/z-injector/z-injector.dart';
import 'package:z_components/api/identity-server/i-identity-server.dart';
import 'package:z_components/api/identity-server/identity-server.dart';
import 'package:z_components/components/z-radio-group/z-radio-group.dart';
import 'package:z_components/components/z-radio-group/z-radio-item.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/components/confirmacao-de-previsto/confirmar-previsto.dart';
import 'dart:convert' show json;
import 'package:z_components/view-model/z-dynamic-form-viewmodel.dart';
import 'package:z_components/components/z-dynamic-form/z-dynamic-form.dart';
import 'package:z_components/api/formulario/i-formulario-service.dart';
import 'package:z_components/api/formulario/formulario-service.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: ComponentExemploClasse());
    //ZUserInfo(token: "eyJhbGciOiJSUzI1NiIsImtpZCI6ImVhNGU1YWY5OGQ2ZTZmZjNhMmNmOTc1MGNlMGQ0YzE3IiwidHlwIjoiSldUIn0.eyJuYmYiOjE1ODUyNTM3MjcsImV4cCI6MTU4NTI1NzMyNywiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIiLCJhdWQiOlsiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIvcmVzb3VyY2VzIiwibW9sdHJlcy5hY2Vzc28uYXBpIl0sImNsaWVudF9pZCI6IlpQb250byIsInN1YiI6ImJiYzA3ZGRhLWEzNDQtNDdlZC05NGQ0LWZkODQ1MjZjYTc4OCIsImF1dGhfdGltZSI6MTU4NTI1MzcyMiwiaWRwIjoibG9jYWwiLCJBc3BOZXQuSWRlbnRpdHkuU2VjdXJpdHlTdGFtcCI6Ik9aNFlEQVRFUVhFQzdGU0dONEc0WENOQjI3RzVQWEFSIiwiaWRDb2xhYm9yYWRvciI6IjU0OEQ1MjRELUE2REUtNEQ4QS05NDVFLUE3MDZBRDJGODdGMiIsImlkQWNjb3VudCI6IjQ4NmE0OWIzLTQ3ZDEtNGQ3Ni04MGRmLTA3OWViODJkNmQ4ZiIsImFjY291bnQiOiJaZWxsYXIyIiwicHJlZmVycmVkX3VzZXJuYW1lIjoiNDM4LjE5Ny43MTgtMTYiLCJlbWFpbCI6ImJsYWJsYUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiI0MzguMTk3LjcxOC0xNiIsInNjb3BlIjpbIm9wZW5pZCIsInByb2ZpbGUiLCJlbWFpbCIsIm1vbHRyZXMuYWNlc3NvLmFwaS5mdWxsIiwib2ZmbGluZV9hY2Nlc3MiXSwiYW1yIjpbInB3ZCJdfQ.ZsSxc59voVlTcjizRGBVuCfE0FwWnz_uUucsnzypLQKI-yf-pFgPT6VLCCQ-WF4BGgxgAEKovR2YbFCApD80XbkyXVLzqNbZSq34Tkqh54G_lFwUsg_st2GzL7oQ9aMaM-XV0cktHPSobpzqNyZkln1MkLveln67Hg7ZxB2w5rO4ECL3VBe0JPs8lmqmOijWCjUfgrmTHpeU2TVgVHnXuxZej3bAskVCRP_YWA_ayFtZz7vibTdFoBYVCQFX_AEX8hunuTmt98PXZs5aL3KngRhVyLhnYoMWv5wI_vfJx3bl0UimCN_h5wnvzJpGh5NwFmpDk_5KSfPlRiwkZQTu0g"));
  }
}

class ComponentExemploClasse extends StatefulWidget {
  @override
  _ComponentExemploClasseState createState() => _ComponentExemploClasseState();
}

class _ComponentExemploClasseState extends State<ComponentExemploClasse>
    with AfterLayoutMixin<ComponentExemploClasse> {
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
  FocusNode inputPadraoFocus;
  FocusNode nomeFocus;
  FocusNode emailFocus;
  FocusNode cpfFocus;
  FocusNode celularFocus;
  FocusNode dataFocus;
  FocusNode ruaFocus;
  FocusNode numeroFocus;
  FocusNode cepFocus;
  FocusNode cnpjFocus;
  FocusNode focusNodeNome;
  var focusNodeNomeB = new FocusNode();

  bool value = false;
  ZBaseLine valideNome;
  ZBaseLine valideCPF;
  ZBaseLine valideData;
  ZBaseLine valideEmail;
  ZBaseLine valideCelular;
  bool isSwitched = true;

  var _controllerFim = new TextEditingController();
  var _controllerIntervalo = new TextEditingController();
  var _controllerHorarioInicio = new TextEditingController();

  var _keyEscala = new GlobalKey<ZEscalaState>();

  var _keyCargo = new GlobalKey<ZCargoState>();

  String vp;
  String nomeeee;
  String cpf;

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

  List<ZDynamicFormViewModel> lista = new List();
  List<ZDynamicFormViewModel> listaEnvio = new List();
  IFormularioService iFormularioService = new FormularioService("eyJhbGciOiJSUzI1NiIsImtpZCI6IjQ4ZDE1YmExNGJkNWQ1OGFiODRlNGI5YTMzZjg1NjIwIiwidHlwIjoiSldUIn0.eyJuYmYiOjE1ODYyMDQzOTUsImV4cCI6MTU4NjIwNzk5NSwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIiLCJhdWQiOlsiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIvcmVzb3VyY2VzIiwibW9sdHJlcy5hY2Vzc28uYXBpIl0sImNsaWVudF9pZCI6IlpDb2xhYm9yYWRvciIsInN1YiI6IjU0NTMyNDM1LTY0ZTAtNDczMS05NmQwLTcxOTY5YjJkY2QwNyIsImF1dGhfdGltZSI6MTU4NjE4NDExNiwiaWRwIjoibG9jYWwiLCJBc3BOZXQuSWRlbnRpdHkuU2VjdXJpdHlTdGFtcCI6Ijc1NzMxNGU3LTM0NDYtNGY5Ny04M2IwLWNhOWY4NmI2OGM3MCIsImFjY291bnQiOiJaZWxsYXJUZW5hbnQiLCJpZEFjY291bnQiOiI0ODZBNDlCMy00N0QxLTRENzYtODBERi0wNzlFQjgyRDZEOEYiLCJpZENvbGFib3JhZG9yIjoiNEUzMkRGMjktOTNFMC00RDU1LTk1REQtQzI2MjIyNTdDQ0Q2IiwicHJlZmVycmVkX3VzZXJuYW1lIjoiNDQ3LjkzMC42MzgtMjkiLCJlbWFpbCI6InZpY3RvcnRtYXJxdWVzQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjpbZmFsc2UsIkZhbHNlIl0sIm5hbWUiOiJWaWN0b3IgVGF2YXJlcyBNYXJxdWVzIiwicGhvbmVfbnVtYmVyIjoiKDExKSA5IDgyMzctMjYyMiIsInNjb3BlIjpbIm9wZW5pZCIsInByb2ZpbGUiLCJlbWFpbCIsIm1vbHRyZXMuYWNlc3NvLmFwaS5mdWxsIiwib2ZmbGluZV9hY2Nlc3MiXSwiYW1yIjpbInB3ZCJdfQ.pwwxzqA5DqWyWMxN_Z5KTjDY3ZICbxbTahBO0zhcDIIj3WrXEQszzLYxACmXUlYaK8cc3_5Ee82n7FofPIoOUKRMk7hfPBSJNCCqiNlgWF1_csd8T5cRwTPhxnOC6t_pzi09gTik21VrIq860WZ-hu8ho2dktlpKGNbCo-ZItqjqTUJ1PkN2J8KPLAYgH2uP0WhIM_WFtwQRXEfIsOhZmnpOYoqpek2a288rM3pCny22hIuPcFp24oadaY4BBuGSEEOrPtad6KSY_HmDgAj9rMx_nlo1DkxuVelDVraiKwgLJX_m2-8Q2EdmanQt-rEkPt6mq_45s3dYSzHkxYeSow");


  @override
  void initState() {
    super.initState();
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
      appBar: new AppBar(title: new Text("TESTESS"),),
      body: new ZInputDataNascimento(
        dataFocus: focusNodeNome,
        controllerData: controllerData,
        validacaoAno: false,),
    );
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
      key.currentState.refresh(0.35, "Carregando Fotos");
    });
    Future.delayed(Duration(seconds: 6), () {
      key.currentState.refresh(0.6, "So mais um momento");
    });
    Future.delayed(Duration(seconds: 9), () {
      key.currentState.refresh(0.85,
          "Ewerweerwerwer wer wer wer weljr nweljnr wojern weojnrowjen roejwn");
    });
    Future.delayed(Duration(seconds: 12), () {
      key.currentState.refresh(1.0,
          "Ewerweerwerwer wer wer wer weljr nweljnr wojern weojnrowjen roejwn",
          success: true);
    });
    Future.delayed(Duration(seconds: 15), () {
      Navigator.pop(context);
    });
  }

  void montarLista() async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/carlos.json");
    var responseBody = json.decode(data);

    lista =
        (responseBody as List).map((x) => ZDynamicFormViewModel.fromJson(x)).toList();

    setState(() {
      print(lista);
    });
  }

  void montarFormulario()async{

    var formulario = await iFormularioService.buscarFormularios();

    var formularioSellecionado = formulario.first;

    lista = await iFormularioService.montarFormulario(formularioSellecionado.idModelo);

    setState(() {
      print(lista);
    });
  }

  void enviarFormulario()async{
    lista.forEach((item) async{
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
    await listaEnvio.add(zDynamicFormViewModel);
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
