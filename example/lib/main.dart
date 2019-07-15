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
import 'package:z_components/components/z-cargo.dart';
import 'package:z_components/components/z-escala.dart';
import 'package:z_components/components/z-perfil.dart';

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

  bool value = false;

  ZBaseLine valideNome;
  ZBaseLine valideCPF;
  ZBaseLine valideData;
  ZBaseLine valideEmail;
  ZBaseLine valideCelular;


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

  var _key = new GlobalKey<ZCargoState>();
  var _keyEscala = new GlobalKey<ZEscalaState>();
  var _keyLocal = new GlobalKey<ZEscalaState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.5),
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
          new ZCargo(
            onChange: (item){
              print("${item.titulo}");
            },
            key: _key,
            token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjhhYWQ0YzIzLTExYmQtNDM1MS1hNzE0LWZmNTk5OGZlYWEzYiIsImFjY291bnQiOiJaZWxsYXJUZW5hbnQiLCJpZEFjY291bnQiOiI0ODZhNDliMy00N2QxLTRkNzYtODBkZi0wNzllYjgyZDZkOGYiLCJuYmYiOjE1NjI3Nzg5NDYsImV4cCI6MTU2MzM4Mzc0NiwiaWF0IjoxNTYyNzc4OTQ2fQ.qQ6UVUZGy9HZ8Z9Ay4wUZXpLtttEBfCGIzKi6bcKstY",),
          new ZEscala(
            onChange: (item){
              print("${item.titulo}");
            },
            key: _keyEscala,
            token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjhhYWQ0YzIzLTExYmQtNDM1MS1hNzE0LWZmNTk5OGZlYWEzYiIsImFjY291bnQiOiJaZWxsYXJUZW5hbnQiLCJpZEFjY291bnQiOiI0ODZhNDliMy00N2QxLTRkNzYtODBkZi0wNzllYjgyZDZkOGYiLCJuYmYiOjE1NjI3Nzg5NDYsImV4cCI6MTU2MzM4Mzc0NiwiaWF0IjoxNTYyNzc4OTQ2fQ.qQ6UVUZGy9HZ8Z9Ay4wUZXpLtttEBfCGIzKi6bcKstY",),
          new ZHora()
 /*         new ZLocal(
            onChange: (item){
              print("${item.titulo}");
            },
            key: _keyEscala,
            token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjhhYWQ0YzIzLTExYmQtNDM1MS1hNzE0LWZmNTk5OGZlYWEzYiIsImFjY291bnQiOiJaZWxsYXJUZW5hbnQiLCJpZEFjY291bnQiOiI0ODZhNDliMy00N2QxLTRkNzYtODBkZi0wNzllYjgyZDZkOGYiLCJuYmYiOjE1NjI3Nzg5NDYsImV4cCI6MTU2MzM4Mzc0NiwiaWF0IjoxNTYyNzc4OTQ2fQ.qQ6UVUZGy9HZ8Z9Ay4wUZXpLtttEBfCGIzKi6bcKstY",),*/

, new ZButton(
            text: "CADASTRO USUARIO",
            onPressed: (){

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>   new ZCadastroUsuario(
                onTapVoltar: (){Navigator.of(context).pop();},
                context: context,
                controllerNome: controllerNome,
                controllerCPF: controllerCPF,
                controllerEmail: controllerEmail,
                controllerCelular: controllerCelular,
                controllerData: controllerData,
                controllerSenha: controllerSenha,
                controllerRepetirSenha: controllerRepetirSenha,
                onPressed: (){
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


          },),
          new ZButton(
            text: "PERFIL",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ZPerfil(
                      onTapVoltar:() =>
                        Navigator.of(context).pop()
                      ,
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
