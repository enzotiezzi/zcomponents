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

  String _token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjhhYWQ0YzIzLTExYmQtNDM1MS1hNzE0LWZmNTk5OGZlYWEzYiIsImFjY291bnQiOiJaZWxsYXJUZW5hbnQiLCJpZEFjY291bnQiOiI0ODZhNDliMy00N2QxLTRkNzYtODBkZi0wNzllYjgyZDZkOGYiLCJuYmYiOjE1NjUzODQ0NzEsImV4cCI6MTU2NTk4OTI3MSwiaWF0IjoxNTY1Mzg0NDcxfQ.CzkpWqttVPTXymEHnPBmKlE5L-Du-ZNzktdV6qCBzFQ";
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
          ZBaseLine(
            key: Key("email"),
            context: context,
            zTipos: ZTipoBaseline.isEmail,
            emailFocus: emailFocus,
            controllerEmail: controllerEmail,
          ),
          ZBaseLine(
            key: Key('data'),
            context: context,
            zTipos: ZTipoBaseline.isDataNascimento,
            controllerData: controllerData,
            mesFocus: mesFocus,
          ),
          ZBaseLine(
            key: Key('celular'),
            context: context,
            zTipos: ZTipoBaseline.isCelular,
            celularFocus: celularFocus,
            controllerCelular: controllerCelular,

          ),
          ZBaseLine(
            key: Key('cep'),
            context: context,
            zTipos: ZTipoBaseline.isCEP,
            cEPFocus: cEPFocus,
          ),
          ZBaseLine(
            key: Key('cnpj'),
            context: context,
            zTipos: ZTipoBaseline.isCNPJ,
            controllerCNPJ: controllerCNPJ,
            hintText: 'xx.xxx.xxx/xxxx-xx',
            cNPJFocus: cNPJFocus,
          ),
          new ZBaseLine(
            key: Key('cpf'),
            context: context,
            zTipos: ZTipoBaseline.isCPF,
            controllerCPF: controllerCPF,
            cpfFocus: cpfFocus,
            hintText: "xxx.xxx.xxx-xx",
          ),


          new ZButton(
            text: "ZCadastro",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ZCadastroUsuario(
                          onTapVoltar: () {
                            Navigator.of(context).pop();
                          },
                          key: Key('zcadastro'),
                          controllerEmail: controllerEmail,
                          controllerSenha: controllerSenha,
                          controllerCPF: controllerCPF,
                          controllerData: controllerData,
                          controllerNome: controllerNome,
                          controllerCelular: controllerCelular,
                          context: context,
                          controllerRepetirSenha: controllerRepetirSenha,
                          tituloAppBar: Text("titulo app bar"),
                          onPressed: () {},
                        )),
              );
            },
          ),
          new ZCargo(
            token: _token,
            key: Key('zcargo'),
          ),
          new ZEmpresa(
            token: _token,
            key: Key('zempresa'),
            idUser: _idUser,
          ),
          new ZLocal(
              token:
                  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjhhYWQ0YzIzLTExYmQtNDM1MS1hNzE0LWZmNTk5OGZlYWEzYiIsImFjY291bnQiOiJaZWxsYXJUZW5hbnQiLCJpZEFjY291bnQiOiI0ODZhNDliMy00N2QxLTRkNzYtODBkZi0wNzllYjgyZDZkOGYiLCJuYmYiOjE1NjUzODQ0NzEsImV4cCI6MTU2NTk4OTI3MSwiaWF0IjoxNTY1Mzg0NDcxfQ.CzkpWqttVPTXymEHnPBmKlE5L-Du-ZNzktdV6qCBzFQ",
              filtro: null),

          new ZEscala(token: _token),
          new ZCollection(
            key: Key("zcollectionkey"),
            titulo: "ZCollection*",
            valorPadrao: "Inativo",
            lista: ["Ativo", "Inativo"]
                .map((x) => new ZCollectionItem(chave: x, titulo: x, valor: x))
                .toList(),
            onChange: (item) {},
          ),
          new ZCheckCPF(
            key: Key('zcheckcpf'),
          ),
          new ZExpansion(),
          new ZExpendableItemTile(),
          new ZFloatButton(onPressed: null),
          new ZHeader(
            titulo: "teste do  zheader",
          ),
          new ZHeaderExpansion(),
          new ZHora(
            controllerHoraEntrada: _controllerEntrada,
            controllerHoraSaida: _controllerFim,
            controllerIntervalo: _controllerIntervalo,
            key: Key('zhora'),
          ),

          new ZHoraUmCampo(
            titulo: "titulo",
            key: Key('zhoraumcampo'),
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
                          color: Color(0xFF000000),
                          idConta: '486a49b3-47d1-4d76-80df-079eb82d6d8f',
                          cpf: '41776112806',
                          token:
                              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjhhYWQ0YzIzLTExYmQtNDM1MS1hNzE0LWZmNTk5OGZlYWEzYiIsImFjY291bnQiOiJaZWxsYXJUZW5hbnQiLCJpZEFjY291bnQiOiI0ODZhNDliMy00N2QxLTRkNzYtODBkZi0wNzllYjgyZDZkOGYiLCJuYmYiOjE1NjUyNzkyMjgsImV4cCI6MTU2NTg4NDAyOCwiaWF0IjoxNTY1Mjc5MjI4fQ.QNsJ5DfVH1lRXGirD-ONCH4URIA81HEFmKjljiWhCdU',
                          imagemPerfil: new Container(),
                          onTapImage: () {},
                          tituloAppBar: 'teste',
                        )),
              );
            },
          ),
          new ZPinSenha(
              numeroQuadrados: 4, context: context, key: Key('zpinsenha')),
          new ZText(
            tituloText: 'titulo text',
            text: "blabla",
          ),
          new Row(
            children: <Widget>[
              new ZLoading(
                key: Key('zloading'),
              ),
            ],
          ),

          new ZNavigationBar(
            key: Key('znavigationbar'),
            title: Text('titulo'),
            context: context,
            backgroundColor: Colors.amber,
          ),

          new Container(
            height: 100,
            width: 100,
          ),
          new Container(width: 50,height: 50,child:
          new ZTextField(
            key: Key('text'),
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red))),
          ), ),

          //new ZLocal(),
          //new ZPerfil(),
        ],
      ),
    );
  }
}
