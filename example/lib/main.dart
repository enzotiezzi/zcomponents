import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:z_components/components/z-cadastro-usuario.dart';
import 'package:z_components/components/z-float-button.dart';
import 'package:z_components/components/z_button.dart';
import 'package:z_components/components/z_tabbar.dart';
import 'package:z_components/components/z-baseline.dart';
import 'package:z_components/components/z_navigationbar.dart';
import 'package:z_components/components/z-hora-padrao.dart';
import 'package:z_components/components/z-instrucao-batida.dart';
import 'package:flutter/cupertino.dart';
import 'package:z_components/components/z-empresa.dart';
import 'package:z_components/components/z-escala.dart';
import 'package:z_components/components/z-local.dart';
import 'package:z_components/components/z-perfil.dart';
import 'package:z_components/components/z-collection.dart';
import 'package:z_components/components/z-collection-item.dart';


import 'package:z_components/config/z-tipos-baseline.dart';

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
  var _controllerFim = new TextEditingController();
  var _controllerIntervalo = new TextEditingController();
  var _controllerHorarioInicio = new TextEditingController();
  ZBaseLine valideNome;
  ZBaseLine valideCPF;
  ZBaseLine valideData;
  ZBaseLine valideEmail;
  ZBaseLine valideCelular;
  var _keyStatus = new GlobalKey<ZCollectionState>();

  String vp;

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

  var _keyEscala = new GlobalKey<ZEscalaState>();
  var _keyLocal = new GlobalKey<ZLocalState>();
  var _keyEmpresa = new GlobalKey<ZEmpresaState>();

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
        body: new ListView(children: <Widget>[
          new ZBaseLine(
            proximoFocus: cpfFocus,
            cNPJFocus: cNPJFocus,
            context: context,
            zTipos: ZTipoBaseline.isCNPJ,
            controllerCNPJ: controllerCNPJ,
          ),
          new ZBaseLine(
            proximoFocus: cEPFocus,
            cpfFocus: cpfFocus,
            context: context,
            zTipos: ZTipoBaseline.isCPF,
            controllerCPF: controllerCPF,
          ),
          new ZBaseLine(
            proximoFocus: mesFocus,
            cEPFocus: cEPFocus,
            context: context,
            zTipos: ZTipoBaseline.isCEP,
            controllerCEP: controllerCEP,
          ),
          new ZBaseLine(
            proximoFocus: nomeFocus,
            mesFocus: mesFocus,
            context: context,
            zTipos: ZTipoBaseline.isDataNascimento,
            controllerData: controllerData,
          ),
          new ZBaseLine(
            proximoFocus: celularFocus,
            nomeFocus: nomeFocus,
            context: context,
            zTipos: ZTipoBaseline.isNomeCompleto,
            controllerNome: controllerNome,
          ),
          new ZBaseLine(
            proximoFocus: emailFocus,
            celularFocus: celularFocus,
            context: context,
            zTipos: ZTipoBaseline.isCelular,
            controllerCelular: controllerCelular,
          ),
          new ZBaseLine(
            proximoFocus: numeroFocus,
            emailFocus: emailFocus,
            context: context,
            zTipos: ZTipoBaseline.isEmail,
            controllerEmail: controllerEmail,
          ),
          new ZBaseLine(
            padraoFocus: numeroFocus,
            proximoFocus: ruaFocus,
            context: context,
            zTipos: ZTipoBaseline.semTituloNumero,
            text: "Número",
            hintText: "Número",
            controllerPadrao: controllerNumero,
          ),
          new ZBaseLine(
            padraoFocus: ruaFocus,
            context: context,
            zTipos: ZTipoBaseline.semTituloText,
            text: "Rua",
            hintText: "Rua",
            controllerPadrao: controllerRua,
          ),
          new ZEmpresa(
            onChange: (item) {
              print("${item.titulo}");
            },
            key: _keyEmpresa,
            token:
                "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjZmYWI2Yjk3LTkyMjctNGUyOS05MzVhLTM5ZjNmN2E4Y2E1ZiIsImFjY291bnQiOiJaZWxsYXJUZW5hbnQiLCJpZEFjY291bnQiOiI5YzZlZDk2ZC1iODM1LTQzNGEtOWE0My01NmNhMjFiZDg0YzEiLCJuYmYiOjE1NjM0ODYxNDEsImV4cCI6MTU2NDA5MDk0MSwiaWF0IjoxNTYzNDg2MTQxfQ.SdWm6Dvy8ovACuOCYABLpfaWprbdmUJc6jYA3taSPf4",
            idUser: "6fab6b97-9227-4e29-935a-39f3f7a8ca5f",
            valorPadrao: "49e30e86-7864-4594-818d-3cc572189dcb",
          ),
          new ZCollection(
            key: _keyStatus,
            titulo: "Status*",
            valorPadrao: "efdfdfgd",
            lista: ["Ativo", "Inativo"]
                .map((x) => new ZCollectionItem(chave: x, titulo: x, valor: x))
                .toList(),
            onChange: (item) {
              if (item == null) {

              } else {
               print(item.chave);
                print(item.valor);
                print(item.titulo);

              }
            },
          ),
          new ZEscala(
            onChange: (item) {
              print("${item.titulo}");
            },
            key: _keyEscala,
            token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjZmYWI2Yjk3LTkyMjctNGUyOS05MzVhLTM5ZjNmN2E4Y2E1ZiIsImFjY291bnQiOiJaZWxsYXJUZW5hbnQiLCJpZEFjY291bnQiOiI5YzZlZDk2ZC1iODM1LTQzNGEtOWE0My01NmNhMjFiZDg0YzEiLCJuYmYiOjE1NjM0ODYxNDEsImV4cCI6MTU2NDA5MDk0MSwiaWF0IjoxNTYzNDg2MTQxfQ.SdWm6Dvy8ovACuOCYABLpfaWprbdmUJc6jYA3taSPf4",
            valorPadrao: "5x2",
          ),
          new ZHora(
            controllerIntervalo: _controllerIntervalo,
            controllerHoraSaida: _controllerFim,
            controllerHoraEntrada: _controllerHorarioInicio,
          ),
          new ZLocal(
            onChange: (item) {
              print("${item.titulo}");
            },
            key: _keyLocal,
            token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjZmYWI2Yjk3LTkyMjctNGUyOS05MzVhLTM5ZjNmN2E4Y2E1ZiIsImFjY291bnQiOiJaZWxsYXJUZW5hbnQiLCJpZEFjY291bnQiOiI5YzZlZDk2ZC1iODM1LTQzNGEtOWE0My01NmNhMjFiZDg0YzEiLCJuYmYiOjE1NjM0ODYxNDEsImV4cCI6MTU2NDA5MDk0MSwiaWF0IjoxNTYzNDg2MTQxfQ.SdWm6Dvy8ovACuOCYABLpfaWprbdmUJc6jYA3taSPf4",
            idEmpresa: "638ee1f4-649e-415f-9e60-a2b504972379",
            valorPadrao: "e9bebc02-f63c-4c56-9f7d-711d7d0191c2",
          ),
          new ZButton(
            text: "CADASTRO USUARIO",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new ZCadastroUsuario(
                          onTapVoltar: () {
                            Navigator.of(context).pop();
                          },
                          context: context,
                          controllerNome: controllerNome,
                          controllerCPF: controllerCPF,
                          controllerEmail: controllerEmail,
                          controllerCelular: controllerCelular,
                          controllerData: controllerData,
                          controllerSenha: controllerSenha,
                          controllerRepetirSenha: controllerRepetirSenha,
                          onPressed: () {
                            print(controllerNome.text);
                            print(controllerCPF.text);
                            print(controllerEmail.text);
                            print(controllerCelular.text);
                            print(controllerData.text);
                            print(controllerSenha.text);
                            print(controllerRepetirSenha.text);
                          },
                        )),
              );
            },
          ),
          new ZButton(
            text: "PERFIL",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ZPerfil(
                          onTapVoltar: () => Navigator.of(context).pop(),
                          listaIcones: icones,
                          listaTextos: titulos,
                          listaOnTap: listaOnTap,
                          numeroQuadrados: titulos.length,
                          statusInfo: true,
                          textoContato: "(11)9 98679893",
                          textoLocalizacao:
                              "Rua do Poeta, 18, ,A2 Jardim Julieta, São Paulo - SP, Brasil, 02161160",
                          tituloHeader: "Giuliano Ortiz",
                          textoTituloInfo: "Giuliano Ortiz",
                          textoLocalInfo: "Sede - Xolis ltda.",
                          textoCargoInfo: "Garoto de TI",
                          textoEscalaInfo: "5x2(seg-sex)",
                          textoHoraEntradaInfo: "09:00",
                          textoHoraSaidaInfo: "15:30",
                          textoHoraIntervaloInfo: "1:00",
                          textoCodigoInfo: "012345",
                        )),
              );
            },
          ),
          ZButton(
            text: "TESTE",
            onPressed: () {
              print(controllerRua.text);
              print(controllerNumero.text);
              print(controllerCelular.text);
              print(controllerNome.text);
              print(controllerData.text);
              print(controllerCEP.text);
              print(controllerCPF.text);
              print(controllerCNPJ.text);
              print(controllerEmail.text);
            },
          )
        ]));
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
