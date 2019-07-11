import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:z_components/components/z-cadastro-usuario.dart';
import 'package:z_components/components/z-collection-item.dart';
import 'package:z_components/components/z-float-button.dart';
import 'package:z_components/components/z-item-tile.dart';
import 'package:z_components/components/z-check-cpf.dart';
import 'package:z_components/components/z-perfil.dart';
import 'package:z_components/components/z-pin-senha.dart';
import 'package:z_components/components/z_button.dart';
import 'package:z_components/components/z_tabbar.dart';
import 'package:z_components/components/z-baseline.dart';
import 'package:z_components/components/z_navigationbar.dart';
import 'package:z_components/components/z-header.dart';
import 'package:z_components/components/z-header-expansion.dart';
import 'package:z_components/components/z-hora-padrao.dart';
import 'package:z_components/components/zp-grafico.dart';
import 'package:z_components/components/z-expansion-tile.dart';
import 'package:z_components/components/z-hora-um-campo.dart';
import 'package:z_components/components/z-instrucao-batida.dart';
import 'package:flutter/cupertino.dart';
import 'package:z_components/config/z-button-type.dart';
import 'package:z_components/config/z-tipo-header.dart';
import 'package:z_components/config/z-tipo-senha.dart';
import 'package:z_components/config/z-tipos-baseline.dart';
import 'package:z_components/components/z-expendable-item-tile.dart';

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
          inactiveColor: Colors.red,
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

  bool value = false;

  ZBaseLine valideNome;
  ZBaseLine valideCPF;
  ZBaseLine valideData;
  ZBaseLine valideEmail;
  ZBaseLine valideCelular;

  Key _expansionTile;
  bool _collapsed = true;
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

  @override
  void initState() {
    super.initState();
    _expansionTile = PageStorageKey<String>(_value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffEFEFF4),
        floatingActionButton: ZFloatButton(
          onPressed: () {},
        ),
        appBar: ZNavigationBar(
          leading: new Icon(Icons.print),
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
          new Column(children: <Widget>[
            new ZHeader(
              zTipos: ZTipoHeader.isExpansion,
              titulo: "TESTE",
            ),
            new ZHeaderExpansion(
              titulo: "Teste Expanded",
              collapsed: _collapsed,
              onTap: () {
                print("TabTeste");
              },
            ),
            valideNome = new ZBaseLine(
              zTipos: ZTipoBaseline.isNomeCompleto,
              context: context,
            ),
            valideCPF = new ZBaseLine(
              zTipos: ZTipoBaseline.isCPF,
              context: context,
            ),
            valideCelular = new ZBaseLine(
              zTipos: ZTipoBaseline.isCelular,
              context: context,
            ),
            valideEmail = new ZBaseLine(
              zTipos: ZTipoBaseline.isEmail,
              context: context,
            ),
            valideData = new ZBaseLine(
              zTipos: ZTipoBaseline.isDataNascimento,
              context: context,
            ),
            new Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: new ZExpansion(
                childTitle: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: new Text("Titulo"),
                    ),
                  ],
                ),
              ),
            ),
            new ZPGrafico(
              key: _expansionTile,
              tituloCenterCircle: "ESCOLA",
              titulo: "Ponto Hoje",
              tituloItem1: "Sapatos",
              tituloItem2: "Escovas",
              tituloItem3: "Disco Vinil",
              valueItem1: 10.0,
              valueItem2: 30.0,
              valueItem3: 10.0,
              onTapItem1: () {
                print("Tap Item 1");
              },
              onTapItem2: () {
                print("Tap Item 2");
              },
              onTapItem3: () {
                print("Tap Item 3");
              },
            ),
            new ZHora(),
            new ZHoraUmCampo(
              titulo: "Horinha",
            ),
            new ZPinSenha(
              context: context,
              numeroQuadrados: 4,
              zTipos: ZTipoSenha.isSenha,
            ),
            new ZPinSenha(
              context: context,
              numeroQuadrados: 4,
              zTipos: ZTipoSenha.isRepetirSenha,
            ),
            new ZCheckCPF(),
            new ZItemTile(
              textoTitulo:
                  "Bento Raimundo da Mata ag rg G wrgWRAER HGAER H tshssth ",
              textoDois: "Sede - Fernando ltda.",
              textoTres: "Sede - Fernando ltda.",
              textoQuatro: "5x2",
              textoCinco: "(seg-sex)",
              textoSeis: "08:00-17:48",
              textoSete: "1:00",
              textoCodigo: "012345",
              status: true,
              funcao: () {},
            ),
            Container(
              height: 30.0,
            ),
            new ZItemTile(),
            Container(
              height: 30.0,
            ),
            new ZExpendableItemTile(
              textoTitulo:
                  "Bento Raimundo da Mata ag rg G wrgWRAER HGAER H tshssth ",
              textoDois: "Sede - Fernando ltda.",
              textoTres: "Sede - Fernando ltda.",
              textoQuatro: "5x2",
              textoCinco: "(seg-sex)",
              textoSeis: "08:00-17:48",
              textoSete: "1:00",
              textoCodigo: "012345",
              status: true,
              funcao: () {},
              iconeUm: new Icon(Icons.phone, color: const Color(0xff2BB9B4)),
              textoIconeUm: "(11)99867-9893",
              iconeDois: new Icon(Icons.map, color: const Color(0xff2BB9B4)),
              textoIconeDois: "Casa - trabalho",
              iconeTres:
                  new Icon(Icons.description, color: const Color(0xff2BB9B4)),
              textoIconeTres: "Espelho de Ponto",
              iconeQuatro:
                  new Icon(Icons.warning, color: const Color(0xff2BB9B4)),
              textoIconeQuatro: "Ocorrencia",
            ),
            Container(
              height: 30.0,
            ),
            ZExpendableItemTile(),
            Container(
              height: 30.0,
            ),
            new Container(
              height: 80.0,
            ),
            new RaisedButton(
                color: Colors.blue,
                child: new Text(
                  "teste aprovacao",
                  style: new TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (valideNome.valideNome == true) {
                    print("apto");
                  } else {
                    print("naoApto");
                  }
                }),
            new ZButton(
              zButtonType: ZButtonType.isContained,
              text: "CADASTRO USUARIO",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ZCadastroUsuario(tituloAppBar: new Text("CADASTRO USUARIO"),
                            onTapVoltar: () {
                              Navigator.of(context).pop();
                            },
                            controllerData: controllerData,
                            controllerCelular: controllerCelular,
                            controllerCPF: controllerCPF,
                            controllerNome: controllerNome,
                            controllerEmail: controllerEmail,
                        controllerSenha: controllerSenha,
                        controllerRepetirSenha: controllerRepetirSenha,
                        context: context,
                            onPressed: () {
                              print(controllerNome.text);
                              print(controllerCPF.text);
                              print(controllerCelular.text);
                              print(controllerData.text);
                              print(controllerEmail.text);
                              print(controllerSenha.text);
                              print(controllerRepetirSenha.text);

                            },
                          )),
                );
              },
            ),
            ZButton(
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
          ]),
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
