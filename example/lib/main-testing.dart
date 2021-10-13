import 'dart:io';
import 'package:z_components/components/z-inputs/z-input-name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/api/identity-server/identity-server.dart';
import 'package:z_components/api/identity-server/i-identity-server.dart';
import 'package:z_components/components/z-processo-seletivo/z-card-processo-seletivo.dart';
import 'package:z_components/components/z-collection/z-collection-item.dart';
import 'package:http/http.dart' as http;
import 'package:z_components/components/filtro/paginated-list.dart';
import 'package:z_components/components/filtro/z-searchbar.dart';
import 'package:z_components/components/filtro/filtro-campo.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/z-response.dart';
import 'package:z_components/components/z-collection/z-collection.dart';
import 'package:z_components/components/z-collection/z-collection-bottomsheet.dart';
import 'package:z_components/components/z-inputs/z-input-generic.dart';
import 'package:z_components/components/z-form/presenter/z-form.dart';
import 'package:z_components/components/z-form/view/z-form-viewmodel.dart';
import 'package:z_components/components/z-pin-senha.dart';
import 'package:z_components/config/z-tipo-senha.dart';
import 'package:z_components/components/confirmar-senha/confirmar-senha.dart';
import 'package:z_components/components/z-conta/z-conta.dart';
import 'package:z_components/view-model/conta-view-model.dart';
import 'package:z_components/components/z-user-info/z-user-info.dart';
import 'package:z_components/view-model/buscarinfo-viewmodel.dart';
import 'package:z_components/components/z-item-tile-candidato.dart';
import 'package:z_components/components/z-item-tile-lista-candidato.dart';
import 'package:z_components/v2/input_text_label.dart';
import 'package:z_components/v2/z_text.dart';
import 'package:z_components/v2/z_icon.dart';

class MainTesting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainTestingState();
}

class _MainTestingState extends State<MainTesting> {
  FocusNode nomeFocusNode = new FocusNode();
  TextEditingController nomeController = new TextEditingController();
  FocusNode cpfFocusNode = new FocusNode();
  TextEditingController cpfController = new TextEditingController();
  FocusNode emailFocusNode = new FocusNode();
  TextEditingController emailController = new TextEditingController();
  IIdentityServer identityServer;

  List<ZCollectionItem> lista = [
    ZCollectionItem(
        chave: "MASCULINO", titulo: "MASCULINO", valor: "MASCULINO"),
    ZCollectionItem(chave: "FEMININO", titulo: "FEMININO", valor: "FEMININO"),
    ZCollectionItem(chave: "OUTRO", titulo: "OUTRO", valor: "OUTRO"),
    ZCollectionItem(chave: "OUTRO2", titulo: "OUTRO2", valor: "OUTRO2"),
    ZCollectionItem(chave: "OUTRO3", titulo: "OUTRO3", valor: "OUTRO3"),
  ];
  GlobalKey<ZCollectionState> key = new GlobalKey<ZCollectionState>();

  SearchOptions searchOptions = new SearchOptions();
  PaginationMetaData paginationMetaData = new PaginationMetaData();

  List<ZCollectionItem> grupos = [];

  @override
  Future<void> initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainStyle.get(context).getDefaultScaffold(
      "Componente de teste",
      _buildTest(),
    );
  }

  var textController1= new TextEditingController();
  var textController2 = new TextEditingController();

  Widget _buildTest() {
    return ListView(
      shrinkWrap: true,
      children: [
        InputTextLabel(
          textEditingController: textController1,
          label: "Label",
          leadingIcon: ZIcon(Icons.search),
          sufix: ZText("grs.", textAlign: TextAlign.end,),
          prefix: ZText("R\$"),
          trailingIcon: ZIcon(Icons.search),
          assist: "Preencha tudo",
          showMaxLength: true,
          validator: (value) {
            if(value.isEmpty)
              return "Texto não pode estar vázio";

            return null;
          },
        ),
        InputTextLabel(
          textEditingController: textController2,
          label: "Label 2",
          leadingIcon: ZIcon(Icons.search),
          sufix: ZText("grs.", textAlign: TextAlign.end,),
          prefix: ZText("R\$"),
          trailingIcon: ZIcon(Icons.search),
          assist: "Preencha tudo",
          validator: (value) {
            if(value.isEmpty)
              return "Texto não pode estar vázio";

            return null;
          },
        )
      ],
    );
  }

  bool preencheuNome = false;

  bool validar() {
    if (preencheuNome) {
      print("okay");
      return true;
    } else {
      print("não okay");
      return false;
    }
  }

  Function habilitarBotao() {
    if (validar()) {
      return () {};
    } else {
      return null;
    }
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: new Column(
        children: [
          Divider(),
          new ZCollectionBottomSheet(
            themeData: Theme.of(context),
            title: "BottomSheet",
            lista: lista,
          ),
          ZInputGeneric(
            titulo: "Teste",
            themeData: Theme.of(context),
          ),
          ZInputName(
            themeData: Theme.of(context),
            nomeFocus: nomeFocusNode,
            controllerNome: nomeController,
            validacao: (bool) {
              if (bool) {
                setState(() {
                  preencheuNome = true;
                });
              } else {
                setState(() {
                  preencheuNome = false;
                });
              }
            },
          ),
          new RaisedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ZUserInfo()));
            },
            child: new Text("teste"),
          ),
          ZForm(
            onChange: (lista) {
              print(lista);
            },
            viewmodel: [
              ZFormViewModel(
                  nomeCampo: "CPF",
                  obrigatorio: true,
                  tipoValorCampo: "cpf",
                  maxLength: 20),
              ZFormViewModel(
                  nomeCampo: "texto",
                  obrigatorio: false,
                  tipoValorCampo: "text"),
              ZFormViewModel(
                  nomeCampo: "Cel",
                  obrigatorio: true,
                  tipoValorCampo: "celular"),
              ZFormViewModel(
                  nomeCampo: "numero",
                  obrigatorio: false,
                  tipoValorCampo: "number"),
              ZFormViewModel(
                nomeCampo: "Data",
                obrigatorio: true,
                tipoValorCampo: "date",
              ),
              ZFormViewModel(
                  nomeCampo: "Area",
                  obrigatorio: false,
                  tipoValorCampo: "textarea",
                  maxLength: 30),
            ],
          ),
          ZPinSenha(
            titulo: "Senha atual",
            onChange: (text) {},
            context: context,
            numeroQuadrados: 4,
            zTipos: ZTipoSenha.isSenha,
          ),
          ZItemTileCandidato(
            funcao: "Desenvolvedor Flutter",
            email: "luiz.sousa@zellar.com.br",
            telefone: "(11)96147-9207",
            nome: "Luiz Fernando",
          ),
          ZItemTileListaCandidato(
            documentos: "RG, CPF",
            idade: "20",
            nomeDependente: "Teste Teste",
            grauParentesco: "Filho",
            imagemPerfil: Container(
              child: Icon(Icons.error),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 32),
            child: RaisedButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ZUserInfo(
                              userInfo: BuscarInfo(),
                            )));
              },
              color: Theme.of(context).accentColor,
              child: Text("SALVAR"),
            ),
          ),
        ],
      ),
    );
  }

  Future<ZResponse<GrupoResumo>> teste(SearchOptions searchOptions) async {
    var params = searchOptions.toHttpParams();

    var headers = {
      "Content-type": "application/json",
      "Authorization":
          "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6Ijk0MmU4NmQ3NjZkOWM0NTk5ZjI1M2RmZmQ1YjUwNTM2IiwidHlwIjoiSldUIn0.eyJuYmYiOjE2MTUzMTI1ODMsImV4cCI6MTYxNzkwNDU4MywiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIiLCJhdWQiOlsiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIvcmVzb3VyY2VzIiwibW9sdHJlcy5hY2Vzc28uYXBpIl0sImNsaWVudF9pZCI6IldlYiBaZWxsYXIiLCJzdWIiOiJiYmMwN2RkYS1hMzQ0LTQ3ZWQtOTRkNC1mZDg0NTI2Y2E3ODgiLCJhdXRoX3RpbWUiOjE2MTUzMTI1ODIsImlkcCI6ImxvY2FsIiwiQXNwTmV0LklkZW50aXR5LlNlY3VyaXR5U3RhbXAiOiJPWjRZREFURVFYRUM3RlNHTjRHNFhDTkIyN0c1UFhBUiIsImFjY291bnQiOiJaZWxsYXIyIiwiaWRBY2NvdW50IjoiOGU2ZWI2MzItYjcwNy00MTNmLWExNTItM2NmZmQxZjk4MmI1IiwiaWRDb2xhYm9yYWRvciI6IjE2QTgwNDE1LUQyODItNEFDQS04NDMxLThDN0YwNjkzQjE3QiIsInByZWZlcnJlZF91c2VybmFtZSI6IjQzOC4xOTcuNzE4LTE2IiwiZW1haWwiOiJibGFibGFAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOmZhbHNlLCJuYW1lIjoiRW56byBUaWV6emkiLCJwaG9uZV9udW1iZXIiOiIoMTEpOSA5NzE3LTI1NDQiLCJzY29wZSI6WyJvcGVuaWQiLCJwcm9maWxlIiwicm9sZXMiLCJtb2x0cmVzLmFjZXNzby5hcGkuZnVsbCJdLCJhbXIiOlsicHdkIl19.j8Q5HHdcp7gvJ9uJwzmHSArUr9Nt6PVG5SBg2bNkqeIhmEscppCODXO_7yINwMKcr9k_MVbMb8En067a-pyyiugcp9mDwSs7dSaWPHP4MA63eTCqcVmxjEO-QXI40-g6Y-J8ySpwxpAlwj3TKXHwsc_wP5YeTCo2x1bCVcOg27TX2JsS8rjC2qjxgyTJJUF1YFDbjQObALFmraAZXBNd0G6c6NSw7ytffbE7Jm2mtbiFpeTngu9hXQF6qxyns68OnFaRcC8W-RxrqySlCTbDFcdO_XU9XNijNddckePIjF9O5MaUF2vgZRxw2yF7WHtLI1Jp1jwoUj8H5X0byOfMsg"
    };

    var url =
        "https://gateway-dev.zellar.com.br/api/v1/seguranca/grupo-acesso/niveis$params";

    var res = await http.get(url, headers: headers);

    var a = new PaginatedList<GrupoResumo>(
            response: res, deserializer: GrupoResumo.fromJson)
        .mapToPaginatedList();

    return a;
  }

  Future<void> onScroll() async {
    if (this.paginationMetaData.hasNext) {
      var response = await teste(this.searchOptions);

      this.searchOptions.pagination.pageNumber++;
      this.paginationMetaData = response.paginationMetaData;
    }
  }

  List<ZCollectionItem> converterParaZCollection(List<GrupoResumo> lista) {
    List<ZCollectionItem> listaConvertida = [];
    for (int i = 0; i < lista.length; i++) {
      listaConvertida.add(new ZCollectionItem(
          chave: lista[i].nomeNivel,
          titulo: lista[i].nomeNivel,
          valor: lista[i].nomeNivel));
    }
    return listaConvertida;
  }
}

class GrupoResumo {
  String idUsuario;
  String idNivel;
  String nomeNivel;
  int qtdGrupoAcesso;
  int qtdUsuario;

  GrupoResumo(
      {this.idUsuario,
      this.idNivel,
      this.nomeNivel,
      this.qtdUsuario,
      this.qtdGrupoAcesso});

  static GrupoResumo fromJson(Map<String, dynamic> json) {
    return new GrupoResumo(
        idUsuario: json["idUsuario"],
        idNivel: json["idNivel"],
        nomeNivel: json["nomeNivel"],
        qtdUsuario: json["qtdUsuario"],
        qtdGrupoAcesso: json["qtdGrupoAcesso"]);
  }
}
