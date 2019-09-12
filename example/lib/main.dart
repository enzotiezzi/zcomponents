import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:z_components/components/z-float-button.dart';
import 'package:z_components/components/z-nome-reduzido.dart';
import 'package:z_components/components/z-sequencia/z-sequencia.dart';
import 'package:z_components/components/z_loading.dart';
import 'package:z_components/components/z_tabbar.dart';
import 'package:z_components/components/z-collection.dart';
import 'package:z_components/components/z-collection-item.dart';
import 'package:z_components/components/z-cargo.dart';
import 'package:z_components/components/z-escala.dart';
import 'package:z_components/components/z-baseline.dart';
import 'package:z_components/components/z_navigationbar.dart';
import 'package:z_components/components/z-instrucao-batida.dart';
import 'package:flutter/cupertino.dart';
import 'package:z_components/config/z-tipos-baseline.dart';
import 'package:z_components/components/z_button.dart';
import 'package:z_components/components/z-perfil.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/components/z-hora-padrao.dart';
import 'package:z_components/components/zp-grafico.dart';
import 'package:z_components/components/z-expendable-item-tile.dart';
import 'package:z_components/components/z-tile.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/components/z_switch.dart';
import 'package:z_components/components/z-expansion-tile.dart';
import 'package:z_components/components/z-item-tile.dart';
import 'package:z_components/components/z-header.dart';
import 'package:z_components/config/z-tipo-header.dart';
import 'package:z_components/infra/db/database.dart';
import 'package:z_components_example/entities/pessoa.dart';
import 'package:z_components_example/repositories/i-pessoa-repository.dart';
import 'package:z_components_example/repositories/pessoa-repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: ComponentExemploClasse()),
        bottomNavigationBar: ZtabBar(
          backgroundColor: Colors.teal,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              title: Text('Business'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              title: Text('School'),
            ),
          ],
          onTap: (index) => index = index,
          currentIndex: 0,
          iconSize: 16,
          inactiveColor: Colors.black,
          activeColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black45,
          // currentIndex: _selectedIndex,
        ),
      ),
    );
  }
}

class ComponentExemploClasse extends StatefulWidget {
  @override
  _ComponentExemploClasseState createState() => _ComponentExemploClasseState();
}

class _ComponentExemploClasseState extends State<ComponentExemploClasse> {
  var controllerEmail = new TextEditingController();
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

  FocusNode nomeFocus;
  FocusNode emailFocus;
  FocusNode cpfFocus;
  FocusNode celularFocus;
  FocusNode mesFocus;
  FocusNode ruaFocus;
  FocusNode numeroFocus;
  FocusNode cEPFocus;
  FocusNode cNPJFocus;

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
  var _keyStatus = new GlobalKey<ZCollectionState>();

  String _value = "open";

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

  ZDatabase _db;

  @override
  void initState() {
    super.initState();

    nomeFocus = new FocusNode();
    emailFocus = new FocusNode();
    cpfFocus = new FocusNode();
    celularFocus = new FocusNode();
    mesFocus = new FocusNode();
    ruaFocus = new FocusNode();
    numeroFocus = new FocusNode();
    cEPFocus = new FocusNode();
    cNPJFocus = new FocusNode();

    _db = new ZDatabase(version: 1, dbName: "teste", entidades: [new Pessoa()]);

    _db.init().then((_){
      _query();
    });
  }

  void _query() async{
    IPessoaRepository rep = new PessoaRepository();

    rep.insert(new Pessoa(nome: "Andreza", idade: 20));

    var a = await rep.findById(1);
    var b = await rep.listarPessoas();

    print("");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold();
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
