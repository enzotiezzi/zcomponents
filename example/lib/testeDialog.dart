import 'package:flutter/material.dart';
import 'package:z_components/components/z-local.dart';
import 'package:z_components/components/z-instrucao-batida.dart';
import 'package:z_components/components/z-hora-um-campo.dart';
import 'package:z_components/components/z-hora-padrao.dart';
import 'package:z_components/components/z-header-expansion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:z_components/components/z-float-button.dart';
import 'package:z_components/components/z-header.dart';
import 'package:z_components/components/z-nome-reduzido.dart';
import 'package:z_components/components/z-pin-senha.dart';
import 'package:z_components/components/z-sequencia/z-sequencia.dart';
import 'package:z_components/components/z-text.dart';
import 'package:z_components/components/z_loading.dart';
import 'package:z_components/components/z_picker.dart';
import 'package:z_components/components/z_switch.dart';
import 'package:z_components/components/z_tabbar.dart';
import 'package:z_components/components/z-cadastro-usuario.dart';
import 'package:z_components/components/z-collection.dart';
import 'package:z_components/components/z-collection-item.dart';
import 'package:z_components/components/z-cargo.dart';
import 'package:z_components/components/z-escala.dart';
import 'package:z_components/components/z-baseline.dart';
import 'package:z_components/components/z_navigationbar.dart';
import 'package:z_components/components/z-instrucao-batida.dart';
import 'package:z_components/components/z-check-cpf.dart';
import 'package:z_components/components/z-empresa.dart';
import 'package:flutter/cupertino.dart';
import 'package:z_components/components/z_text_field.dart';
import 'package:z_components/config/z-tipos-baseline.dart';
import 'package:z_components/components/z_button.dart';
import 'package:z_components/components/z-perfil.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/components/z-hora-padrao.dart';
import 'package:z_components/components/zp-grafico.dart';
import 'package:z_components/components/z-expendable-item-tile.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/components/z-expansion-tile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TESTES AUTOMATIZADOS',
      home: MyHomePage(title: 'TESTE DO ZBASELINE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  var _controllerFim = new TextEditingController();
  var _controllerIntervalo = new TextEditingController();
  var _controllerEntrada = new TextEditingController();

  var _keyEscala = new GlobalKey<ZEscalaState>();

  var _keyCargo = new GlobalKey<ZCargoState>();

  String _token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjhhYWQ0YzIzLTExYmQtNDM1MS1hNzE0LWZmNTk5OGZlYWEzYiIsImFjY291bnQiOiJaZWxsYXJUZW5hbnQiLCJpZEFjY291bnQiOiI0ODZhNDliMy00N2QxLTRkNzYtODBkZi0wNzllYjgyZDZkOGYiLCJuYmYiOjE1NjUzODQ0NzEsImV4cCI6MTU2NTk4OTI3MSwiaWF0IjoxNTY1Mzg0NDcxfQ.CzkpWqttVPTXymEHnPBmKlE5L-Du-ZNzktdV6qCBzFQ";
  String _idUser = "486A49B3-47D1-4D76-80DF-079EB82D6D8F";
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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[

          ZBaseLine(
            key: Key("nomecompleto"),
            context: context,
            zTipos: ZTipoBaseline.isNomeCompleto,
            controllerNome: controllerNome,
            nomeFocus: nomeFocus,
            onChangedTextPadrao: 'Nome Completo',
          ),
          Row  (children: <Widget>[

          ZLoading(
            context: context,


          )],)

          //new ZLocal(),
          //new ZPerfil(),
        ],
      ),
    );
  }
}
