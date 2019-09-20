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
import 'package:z_components/config/z-type-tile.dart';
import 'package:z_components/components/z_button.dart';
import 'package:z_components/components/z-perfil.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/components/z-hora-padrao.dart';
import 'package:z_components/components/zp-grafico.dart';
import 'package:z_components/components/z-expendable-item-tile.dart';
import 'package:z_components/components/z-tile.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/components/z-expansion-tile.dart';
import 'package:z_components/components/z-item-tile.dart';
import 'package:z_components/components/z-header.dart';
import 'package:z_components/config/z-tipo-header.dart';
import 'package:z_components/infra/db/database.dart';
/*
import 'package:z_components_example/entities/pessoa.dart';
import 'package:z_components_example/repositories/i-monstro-repository.dart';
import 'package:z_components_example/repositories/i-pessoa-repository.dart';
import 'package:z_components_example/repositories/monstro-repository.dart';
import 'package:z_components_example/repositories/pessoa-repository.dart';*/

import 'entities/monstro.dart';

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

    super.initState();


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
    return Scaffold(
        backgroundColor: Color(0xffEFEFF4),
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
        body: new ListView(
          children: <Widget>[
            new ZBaseLine(
              zTipos: ZTipoBaseline.isNomeCompleto,
              controllerNome: _controllerFim,
              nomeFocus: nomeFocus,
            ),
            new ZExpansion(
              childTitle: new IconButton(
                onPressed: () {},
                icon: new Icon(Icons.arrow_back_ios),
                iconSize: 20.0,
              ),
              titulo: 'TESTE',
            ),
          /*  new ZItemTile(
              zTypeTile: ZTypeTile.isUser,
              token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjhhYWQ0YzIzLTExYmQtNDM1MS1hNzE0LWZmNTk5OGZlYWEzYiIsImFjY291bnQiOiJaZWxsYXJUZW5hbnQiLCJpZEFjY291bnQiOiI0ODZhNDliMy00N2QxLTRkNzYtODBkZi0wNzllYjgyZDZkOGYiLCJuYmYiOjE1NjUzODQ0NzEsImV4cCI6MTU2NTk4OTI3MSwiaWF0IjoxNTY1Mzg0NDcxfQ.CzkpWqttVPTXymEHnPBmKlE5L-Du-ZNzktdV6qCBzFQ',
              cpf: '447.930.638-29',
              idConta: '486A49B3-47D1-4D76-80DF-079EB82D6D8F',
              status: true,
              escala: "5x2",
              nome: "VICTOR MARQUES",
              nomeCentroCusto: "ZELLAR",
              horaEntrada: "09:00",
              horaSaida: "18h00",
              tempoPausa: "01:00",
              cargo: "DEV",
            ),*/
           /* new ZItemTile(
              nome: "Aleff Apararecido dos Santos Lima",
              zTypeTile: ZTypeTile.isUser,
              token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjhhYWQ0YzIzLTExYmQtNDM1MS1hNzE0LWZmNTk5OGZlYWEzYiIsImFjY291bnQiOiJaZWxsYXJUZW5hbnQiLCJpZEFjY291bnQiOiI0ODZhNDliMy00N2QxLTRkNzYtODBkZi0wNzllYjgyZDZkOGYiLCJuYmYiOjE1NjUzODQ0NzEsImV4cCI6MTU2NTk4OTI3MSwiaWF0IjoxNTY1Mzg0NDcxfQ.CzkpWqttVPTXymEHnPBmKlE5L-Du-ZNzktdV6qCBzFQ',
              cpf: '447.930.638-29',
              idConta: '486A49B3-47D1-4D76-80DF-079EB82D6D8F',
              telefone: "(00) 9 1234-5678",
              email: "gustavo.ortiz.zellartec@email.com.br",
              rua: "Rua Lorem ipsum, Nº 123, Bairro Adipiscing - São Paulo - SP",
            ),*/
            new Container(
              child:
              new ZItemTile(
              status: true,
              zTypeTile: ZTypeTile.isColab,
              cpf: "333.972.458-00",
              escala: "5x2x6x1",
              tempoPausa: "01:00",
              inicioIntervalo: "11:00",
              voltaIntervalo: "12:00",
              horaSaida: "18:00",
              re: "909.280",
              jornada: "12:00",
              horaEntrada: "06:00",
              telefone: "(00) 9 1234-5678",
              nomeCentroCusto: ";k;km ;m;m;km;kllmlkm;km;km;km;km;m;m;km;klm;km;km;km;k;;l;ll;;ll;l;l;l;",
              nome: "Gusoh ASjisaidjas",
              token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjhhYWQ0YzIzLTExYmQtNDM1MS1hNzE0LWZmNTk5OGZlYWEzYiIsImFjY291bnQiOiJaZWxsYXJUZW5hbnQiLCJpZEFjY291bnQiOiI0ODZhNDliMy00N2QxLTRkNzYtODBkZi0wNzllYjgyZDZkOGYiLCJuYmYiOjE1NjUzODQ0NzEsImV4cCI6MTU2NTk4OTI3MSwiaWF0IjoxNTY1Mzg0NDcxfQ.CzkpWqttVPTXymEHnPBmKlE5L-Du-ZNzktdV6qCBzFQ',
              idConta: '486A49B3-47D1-4D76-80DF-079EB82D6D8F',
              codEmpresa: "",
              cargo: "asojnasojnaspnfapskfnapskdnapskdnaskdnadspn",
              endereco: "",
              colorBatida: Color(0xff1AC15D),
            ),),
            new Container(
              height: 17.0,
            ),
            new ZHeader(
              zTipos: ZTipoHeader.isExpansion,
              titulosAppBar: true,
              child: new Container(
                color: const Color(0xff000000),
                padding: const EdgeInsets.only(
                  left: 16.0,
                  bottom: 6.0,
                  top: 6.0,
                ),
                child: new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Container(
                      child: new Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                    ),
                    new Container(
                      width: MediaQuery.of(context).size.width / 3,
                      margin: EdgeInsets.only(left: 5.0),
                      child: new Text(
                        "VICTOR",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 6.0),
                      child: new Icon(
                        Icons.my_location,
                        color: Colors.grey,
                      ),
                    ),
                    new Container(
                      width: MediaQuery.of(context).size.width / 3.2,
                      margin: EdgeInsets.only(left: 8.0),
                      child: new Text(
                        "ZELLAR TESTE DE TAMANHO",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              children: <Widget>[
                new Container(
                  child: new ZItemTile(
                    token:
                        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjhhYWQ0YzIzLTExYmQtNDM1MS1hNzE0LWZmNTk5OGZlYWEzYiIsImFjY291bnQiOiJaZWxsYXJUZW5hbnQiLCJpZEFjY291bnQiOiI0ODZhNDliMy00N2QxLTRkNzYtODBkZi0wNzllYjgyZDZkOGYiLCJuYmYiOjE1NjUzODQ0NzEsImV4cCI6MTU2NTk4OTI3MSwiaWF0IjoxNTY1Mzg0NDcxfQ.CzkpWqttVPTXymEHnPBmKlE5L-Du-ZNzktdV6qCBzFQ',
                    cpf: '447.930.638-29',
                    idConta: '486A49B3-47D1-4D76-80DF-079EB82D6D8F',
                    status: true,
                  ),
                )
              ],
            ),
            new Container(
              height: 17.0,
            ),
            new ZExpendableItemTile(
              nome: "Gustavo Ortiz",
              nomeCentroCusto: "Sede - Fernando ltda.",
              tempoPausa: "01:00",
              inicioIntervalo: "11:00",
              voltaIntervalo: "12:00",
              escala: "5x2x6x1",
              horaSaida: "18:00",
              jornada: "12:00",
              horaEntrada: "06:00",
              re: "909.293",
              token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjhhYWQ0YzIzLTExYmQtNDM1MS1hNzE0LWZmNTk5OGZlYWEzYiIsImFjY291bnQiOiJaZWxsYXJUZW5hbnQiLCJpZEFjY291bnQiOiI0ODZhNDliMy00N2QxLTRkNzYtODBkZi0wNzllYjgyZDZkOGYiLCJuYmYiOjE1NjUzODQ0NzEsImV4cCI6MTU2NTk4OTI3MSwiaWF0IjoxNTY1Mzg0NDcxfQ.CzkpWqttVPTXymEHnPBmKlE5L-Du-ZNzktdV6qCBzFQ',
              cpf: '447.930.638-29',
              cargo: "Assist. Tec. Seg. Trab.",
              colorBatida: Color(0xff1AC15D),
              idConta: '486A49B3-47D1-4D76-80DF-079EB82D6D8F',
              status: true,
              onTapImage: () {},
              imagemPerfil: new Container(),
              funcao: () {},
              funcaoIconeDois: () {},
              funcaoIconeQuatro: () {},
              funcaoIconeTres: () {},
              funcaoIconeUm: () {},
              iconeDois: new Icon(Icons.arrow_forward_ios),
              iconeQuatro: new Icon(Icons.arrow_forward_ios),
              iconeTres: new Icon(Icons.arrow_forward_ios),
              iconeUm: new Icon(Icons.arrow_forward_ios),
              onTapVoltar: () {},
              textoIconeDois: 'teste',
              textoIconeQuatro: 'teste',
              textoIconeTres: 'teste',
              textoIconeUm: 'teste',
            ),
            new ZExpendableItemTile(
              nome: "Gustavo Ortiz",
              nomeCentroCusto: "Sede - Fernando ltda.",
              tempoPausa: "01:00",
              inicioIntervalo: "11:00",
              voltaIntervalo: "12:00",
              escala: "5x2x6x1",
              horaSaida: "18:00",
              jornada: "12:00",
              horaEntrada: "06:00",
              re: "909.293",
              token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjhhYWQ0YzIzLTExYmQtNDM1MS1hNzE0LWZmNTk5OGZlYWEzYiIsImFjY291bnQiOiJaZWxsYXJUZW5hbnQiLCJpZEFjY291bnQiOiI0ODZhNDliMy00N2QxLTRkNzYtODBkZi0wNzllYjgyZDZkOGYiLCJuYmYiOjE1NjUzODQ0NzEsImV4cCI6MTU2NTk4OTI3MSwiaWF0IjoxNTY1Mzg0NDcxfQ.CzkpWqttVPTXymEHnPBmKlE5L-Du-ZNzktdV6qCBzFQ',
              cpf: '447.930.638-29',
              cargo: "Assist. Tec. Seg. Trab.",
              colorBatida: Color(0xff1AC15D),
              idConta: '486A49B3-47D1-4D76-80DF-079EB82D6D8F',
              status: true,
              onTapImage: () {},
              imagemPerfil: new Container(),
              funcao: () {},
              funcaoIconeDois: () {},
              funcaoIconeQuatro: () {},
              funcaoIconeTres: () {},
              funcaoIconeUm: () {},
              iconeDois: new Icon(Icons.arrow_forward_ios),
              iconeQuatro: new Icon(Icons.arrow_forward_ios),
              iconeTres: new Icon(Icons.arrow_forward_ios),
              iconeUm: new Icon(Icons.arrow_forward_ios),
              onTapVoltar: () {},
              textoIconeDois: 'teste',
              textoIconeQuatro: 'teste',
              textoIconeTres: 'teste',
              textoIconeUm: 'teste',
            ),
            new Container(
              height: 17.0,
            ),
            new ZCargo(
              token:
                  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjZmYWI2Yjk3LTkyMjctNGUyOS05MzVhLTM5ZjNmN2E4Y2E1ZiIsImFjY291bnQiOiJaZWxsYXJUZW5hbnQiLCJpZEFjY291bnQiOiI5YzZlZDk2ZC1iODM1LTQzNGEtOWE0My01NmNhMjFiZDg0YzEiLCJuYmYiOjE1NjQ3Nzc2NDgsImV4cCI6MTU2NTM4MjQ0OCwiaWF0IjoxNTY0Nzc3NjQ4fQ.uDRVATIoSb4FAYjgg5O1OYa7BZxsELvQyRaJFUqK0Pc',
              key: _keyCargo,
            ),
            new Container(
              color: Colors.grey,
              padding: const EdgeInsets.all(16.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new ZSequencia(
                    token:
                        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjZmYWI2Yjk3LTkyMjctNGUyOS05MzVhLTM5ZjNmN2E4Y2E1ZiIsImFjY291bnQiOiJaZWxsYXJUZW5hbnQiLCJpZEFjY291bnQiOiI5YzZlZDk2ZC1iODM1LTQzNGEtOWE0My01NmNhMjFiZDg0YzEiLCJuYmYiOjE1NjQ3Nzc2NDgsImV4cCI6MTU2NTM4MjQ0OCwiaWF0IjoxNTY0Nzc3NjQ4fQ.uDRVATIoSb4FAYjgg5O1OYa7BZxsELvQyRaJFUqK0Pc',
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
            ZBaseLine(
              zTipos: ZTipoBaseline.isCPF,
              cpfFocus: cpfFocus,
              controllerCPF: controllerCPF,
              context: context,
            ),
            new ZNomeReduzido(
              text: "Giuliano Ortiz Goria",
              textStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
            ),
            new ZEscala(
              token:
                  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjZmYWI2Yjk3LTkyMjctNGUyOS05MzVhLTM5ZjNmN2E4Y2E1ZiIsImFjY291bnQiOiJaZWxsYXJUZW5hbnQiLCJpZEFjY291bnQiOiI5YzZlZDk2ZC1iODM1LTQzNGEtOWE0My01NmNhMjFiZDg0YzEiLCJuYmYiOjE1NjQ3Nzc2NDgsImV4cCI6MTU2NTM4MjQ0OCwiaWF0IjoxNTY0Nzc3NjQ4fQ.uDRVATIoSb4FAYjgg5O1OYa7BZxsELvQyRaJFUqK0Pc',
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
            new Row(
              children: <Widget>[
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
              ],
            ),
            new Row(
              children: <Widget>[
                ZLoading(
                  color: Colors.purple,
                ),
                ZLoading(
                  color: Colors.lightBlueAccent,
                ),
                ZLoading(
                  color: Colors.lightGreenAccent,
                ),
                ZLoading(
                  color: Colors.amber,
                ),
              ],
            ),
            new ZHora(
              controllerIntervalo: _controllerIntervalo,
              controllerHoraSaida: _controllerFim,
              controllerHoraEntrada: _controllerHorarioInicio,
            ),
            new Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: new ZPGrafico(),
            ),
            new ZExpendableItemTile(),
            new Container(
              width: 50.0,
              child: new Icon(Icons.search),
            ),
            new ZTile(
              onTap: () {},
              leading: new Text(
                "Parâmetros de usuário",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: new Icon(
                Icons.keyboard_arrow_right,
                color: const Color(0xffC3C3C8),
              ),
            ),
            new Container(
              width: 50.0,
              child: new Icon(Icons.search),
            ),
            new Column(
              children: <Widget>[
                new ZButton(
                  text: "Dialog Normal",
                  onPressed: () {
                    showAlertDialogNewNormal();
                  },
                ),
                new ZButton(
                  text: "Dialog Erro",
                  onPressed: () {
                    showAlertDialogNew();
                  },
                ),
                new ZButton(
                  text: "Dialgo Alert",
                  onPressed: () {
                    showAlertDialogNewAlert();
                  },
                ),
                new ZButton(
                  text: "Dialog Succes",
                  onPressed: () {
                    showAlertDialogNewSuccess();
                  },
                ),
                new ZButton(
                  text: "Dialog Load",
                  onPressed: () {
                    showAlertDialogNewProgress();
                  },
                ),
              ],
            ),
          ],
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
