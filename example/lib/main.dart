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
import 'package:z_components/config/z-dialog.dart';

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

  @override
  void initState() {
    nomeFocus = new FocusNode();
    emailFocus = new FocusNode();
    cpfFocus = new FocusNode();
    celularFocus = new FocusNode();
    mesFocus = new FocusNode();
    ruaFocus = new FocusNode();
    numeroFocus = new FocusNode();
    cEPFocus = new FocusNode();
    cNPJFocus = new FocusNode();
    super.initState();
    Future.delayed(new Duration(milliseconds: 1000), () {
      dialogCargoJornada("Esta é a sua jornada de trabalho?","5x2 (de SEG à SEX) das 08:00 às 17:48 com 1:00 de intervalo.");
    }
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: ZFloatButton(
          onPressed: () {},
        ),
        appBar: ZNavigationBar(
          leading: new Icon(Icons.print),
          middle: new Container(
            child: new Text('teste'),
          ),
          trailing: new GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new InformacaoBatida(
                          bottomChild: new Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(bottom: 5),
                              child: new ButtonTheme(
                                minWidth: 145,
                                child: new RaisedButton(
                                    color: Color(0xff2bbab4),
                                    child: new Text(
                                      "ENTENDI",
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0))),
                              )),
                        )),
              );
            },
            child: new Container(
              child: new Icon(
                Icons.info,
                color: Colors.blue,
                size: 19.0,
              ),
            ),
          ),
        ),
        body: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              color: Colors.grey,
              padding: const EdgeInsets.all(16.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new ZSequencia(
                    token:
                        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjZmYWI2Yjk3LTkyMjctNGUyOS05MzVhLTM5ZjNmN2E4Y2E1ZiIsImFjY291bnQiOiJaZWxsYXJUZW5hbnQiLCJpZEFjY291bnQiOiI5YzZlZDk2ZC1iODM1LTQzNGEtOWE0My01NmNhMjFiZDg0YzEiLCJuYmYiOjE1NjM0ODA5NzYsImV4cCI6MTU2NDA4NTc3NiwiaWF0IjoxNTYzNDgwOTc2fQ.xK3ROTSn6rP-9ODwGou4wA5mwa4vgeC5gGqyigMIix4",
                    idConta: "486A49B3-47D1-4D76-80DF-079EB82D6D8F",
                    idColaborador: "548D524D-A6DE-4D8A-945E-A706AD2F87F2",
                  )
                ],
              ),
            ),
            ZBaseLine(
              zTipos: ZTipoBaseline.isDataNascimento,
              controllerData: controllerData,
              context: context,
              mesFocus: mesFocus,
            ),
            ZBaseLine(
              zTipos: ZTipoBaseline.isCNPJ,
              cNPJFocus: cNPJFocus,
              controllerCNPJ: controllerCNPJ,
              context: context,
            ),
            new ZNomeReduzido(
              text: "Giuliano Ortiz Goria",
              textStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
            ),
            new ZCargo(
              token:
                  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjZmYWI2Yjk3LTkyMjctNGUyOS05MzVhLTM5ZjNmN2E4Y2E1ZiIsImFjY291bnQiOiJaZWxsYXJUZW5hbnQiLCJpZEFjY291bnQiOiI5YzZlZDk2ZC1iODM1LTQzNGEtOWE0My01NmNhMjFiZDg0YzEiLCJuYmYiOjE1NjM0ODA5NzYsImV4cCI6MTU2NDA4NTc3NiwiaWF0IjoxNTYzNDgwOTc2fQ.xK3ROTSn6rP-9ODwGou4wA5mwa4vgeC5gGqyigMIix4",
              key: _keyCargo,
            ),
            new ZEscala(
              token:
                  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjZmYWI2Yjk3LTkyMjctNGUyOS05MzVhLTM5ZjNmN2E4Y2E1ZiIsImFjY291bnQiOiJaZWxsYXJUZW5hbnQiLCJpZEFjY291bnQiOiI5YzZlZDk2ZC1iODM1LTQzNGEtOWE0My01NmNhMjFiZDg0YzEiLCJuYmYiOjE1NjM0ODA5NzYsImV4cCI6MTU2NDA4NTc3NiwiaWF0IjoxNTYzNDgwOTc2fQ.xK3ROTSn6rP-9ODwGou4wA5mwa4vgeC5gGqyigMIix4",
              key: _keyEscala,
              //valorPadrao: widget.escala,
            ),
            new ZCollection(
              key: _keyStatus,
              titulo: "Status*",
              //valorPadrao: valorPadraoStatus,
              lista: ["Ativo", "Inativo"]
                  .map(
                      (x) => new ZCollectionItem(chave: x, titulo: x, valor: x))
                  .toList(),
              onChange: (item) {},
            ),
            new ZButton(
              text: "PERFIL",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ZPerfil(
                            onTapVoltar: () {
                              Navigator.of(context).pop();
                            },
                            listaIcones: icones,
                            listaTextos: titulos,
                            numeroQuadrados: 6,
                            statusInfo: true,
                            tituloHeader: "Giuliano Ortiz",
                            textoTituloInfo: "Giuliano Ortiz",
                            textoLocalInfo: "Sede - Xolis ltda.",
                            textoCargoInfo: "Garoto de TI",
                            textoEscalaInfo: "5x2(seg-sex)",
                            textoHoraEntradaInfo: "09:00",
                            textoHoraSaidaInfo: "15:30",
                            textoHoraIntervaloInfo: "1:00",
                            textoCodigoInfo: "012345",
                            listaOnTap: listaOnTap,
                          )),
                );
              },
            ),
            new Row(
              children: <Widget>[
                ZLoading(
                  color: Colors.purple,
                ),
                ZLoading(
                  color: Colors.yellow,
                ),
                ZLoading(
                  color: Colors.blueGrey,
                ),
                ZLoading(
                  color: Colors.amber,
                ),
                ZLoading(
                  color: Colors.red,
                ),
              ],
            )
          ],
        ));
  }
  void olaColab(String nomeColab,{Function onOkPressed = null}){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => new ZAlertDialog(
          colorLine: const Color(0xff2BBAB4),
          zDialog: ZDialog.normal,
          child: new Container(
            padding: new EdgeInsets.only(top:16.0,bottom: 10.0),
            child: new Column(
              children: <Widget>[
                new Container(
                  child: new Text(
                    "Olá,",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                new Container(
                  padding: new EdgeInsets.all(8.0),
                  child: new Text(
                    nomeColab,
                    style: new TextStyle(color: const Color(0xff2BBAB4),fontWeight: FontWeight.bold,fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                ),
                new Container(
                  padding: new EdgeInsets.only(left:8.0,right: 8.0,bottom: 12.0,top: 8.0),
                  child: new Text(
                    "Como este é o seu primeiro acesso,\n vamos confirmar alguns dados.",
                    style: new TextStyle(color: const Color(0xFF707070),fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                new Divider(
                  color: const Color(0xffdbdbdb),
                ),
                new Container(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Container(
                        margin: new EdgeInsets.only(left: 4),
                        child: new InkWell(
                            borderRadius:
                            new BorderRadius.all(const Radius.circular(20.0)),
                            splashColor: const Color(0xffe6e6e6),
                            onTap: () {
                              Navigator.pop(context);
                              if(onOkPressed != null)onOkPressed();
                            },
                            child: new Container(
                              padding: const EdgeInsets.all(12),
                              child: new Text(
                                "OK",
                                style: new TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900),
                                textAlign: TextAlign.center,
                              ),
                            )
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
  void dialogCargoJornada(String text, String text2,{Function onNaoPressed = null,Function onSimPressed = null}){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => new ZAlertDialog(
          colorLine: const Color(0xff2BBAB4),
          zDialog: ZDialog.normal,
          child: new Container(
            padding: new EdgeInsets.only(top:16.0,bottom: 10.0),
            child: new Column(
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: new Text(
                    text,
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                new Container(
                  padding: new EdgeInsets.all(8.0),
                  child: new Text(
                    text2,
                    style: new TextStyle(color: const Color(0xff2BBAB4),fontWeight: FontWeight.normal,fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                ),
                new Divider(
                  color: const Color(0xffdbdbdb),
                ),
                new Container(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Container(
                        child: new InkWell(
                            borderRadius:
                            new BorderRadius.all(const Radius.circular(20.0)),
                            splashColor: const Color(0xffe6e6e6),
                            onTap: () {
                              Navigator.pop(context);
                              if(onNaoPressed != null)onNaoPressed();
                            },                            child: new Container(
                              padding: const EdgeInsets.all(12),
                              child: new Text(
                                "NÃO",
                                style: new TextStyle(
                                    color: Color(0xff707070),
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center,
                              ),
                            )
                        ),
                      ),
                      new Container(
                        child: new InkWell(
                            borderRadius:
                            new BorderRadius.all(const Radius.circular(20.0)),
                            splashColor: const Color(0xffe6e6e6),
                            onTap: () {
                              Navigator.pop(context);
                              if(onSimPressed != null)onSimPressed();
                            },
                            child: new Container(
                              padding: const EdgeInsets.all(12),
                              child: new Text(
                                "SIM",
                                style: new TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900),
                                textAlign: TextAlign.center,
                              ),
                            )
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
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
