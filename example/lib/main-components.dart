import 'package:flutter/material.dart';
import 'package:z_components/components/z-perfil-item.dart';
import 'package:z_components/components/informacoes-organizacao/informacoes-organizacao.dart';
import 'package:z_components_example/tela-teste-card.dart';
import 'package:z_components/components/fluxo-admin/usuarios.dart';
import 'package:z_components/components/listagem-contas/listagem-contas.dart';
import 'package:z_components/components/fluxo-admin/modulos.dart';
import 'package:z_components/components/z-user-info/z-user-info.dart';
import 'package:z_components/view-model/buscarinfo-viewmodel.dart';
import 'package:z_components/components/utils/novo_token.dart';
import 'package:z_components/components/z-estrutura-empresa/bloc/z-estrutura-empresa-cubit.dart';
import 'package:z_components/components/z-estrutura-empresa/z-estrutura-empresa.dart';
import 'package:z_components/api/identity-server/identity-server.dart';

class MainComponents extends StatefulWidget {
  @override
  _MainComponentsState createState() => _MainComponentsState();
}

class _MainComponentsState extends State<MainComponents> {
  ZEstruturaEmpresaCubit bloc = new ZEstruturaEmpresaCubit();

  String _clientId = 'ZColaborador';
  String _redirectUrl = 'net.openid.appzcolocalobador:/oauth2redirect';

  List<String> _scopes = [
    'openid',
    'profile',
    'email',
    'offline_access',
    'moltres.acesso.api.full'
  ];

  @override
  void initState() {
    super.initState();

    new IdentityServer(
        clientId: _clientId, redirectUrl: _redirectUrl, scopes: _scopes).login();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("ZAdmin"),
      ),
      body: _buildBody(),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: new Color(0XFF2BBAB4),
        child: new Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new TelaTesteCard()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildBody() {
    return new Container(
      margin: const EdgeInsets.only(
        top: 16,
        left: 8,
        right: 8,
      ),
      child: new ZPerfilItem(
        color: new Color(0XFF2BBAB4),
        numeroQuadrados: 5,
        listaIcones: [Icons.add, Icons.add, Icons.add, Icons.add, Icons.add],
        listaOnTap: [
          () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new InformacoesOrganizacao(
                          themeData: Theme.of(context),
                          editarDados: false,
                          textoFoto: "",
                          idConta: "3f2bdcbb-764f-48c7-0c33-08d7cf63e45b",
                          infoOrganizacaoViewModel: null,
                        )));
          },
          () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new Usuarios(
                          themeData: Theme.of(context),
                        )));
          },
          () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new Modulos(
                          themeData: Theme.of(context),
                        )));
          },
          () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new ListagemContas(
                          themeData: Theme.of(context),
                          token: NovoToken.newToken,
                        )));
          },
          () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new ZUserInfo(
                          userInfo: new BuscarInfo(),
                        )));
          }
        ],
        listaTextos: [
          "Info. de Organizacão",
          "Usuários",
          "Módulos",
          "Contas",
          "Meu Perfil"
        ],
      ),
    );
  }

  Widget _buildEstruturaEmpresa() {
    return new ZEstruturaEmpresa(
      key: null,
      token:
          'eyJhbGciOiJSUzI1NiIsImtpZCI6ImFhNmNiYWFjMmE0NDc3MThhNDg3YjNkOWE5YWU4YWM0IiwidHlwIjoiSldUIn0.eyJuYmYiOjE2MzExMDM3NjIsImV4cCI6MTYzMzY5NTc2MiwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIiLCJhdWQiOlsiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIvcmVzb3VyY2VzIiwibW9sdHJlcy5hY2Vzc28uYXBpIl0sImNsaWVudF9pZCI6IldlYiBaZWxsYXIiLCJzdWIiOiIwMjFmOTE4Mi0zZjQxLTRmMGEtYWFkYy00MDc3NmU2MGQwNGMiLCJhdXRoX3RpbWUiOjE2MzExMDM3NTcsImlkcCI6ImxvY2FsIiwiQXNwTmV0LklkZW50aXR5LlNlY3VyaXR5U3RhbXAiOiIzS0U2RUNEUlRIR0dYQURBTUNXR1pHQUVEWDJEM1lPTCIsImFjY291bnQiOiJ6ZWxsYXIyIiwiaWRBY2NvdW50IjoiZTUzMjdkZjMtNDE3ZS00NzUwLWIxZjktNzkwYjg3YjUwN2NjIiwiaWRDb2xhYm9yYWRvciI6IjE1ODQyQzJFLUM3RDctNERENS04RkE5LUZFMzNDQkQ2NENFQyIsInByZWZlcnJlZF91c2VybmFtZSI6IjQyNi45MTAuMjU4LTYxIiwiZW1haWwiOiJsdWl6Lmx1Y2lhQHplbGxhci5jb20uYnIiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsInBob25lX251bWJlcl92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJMdWl6IEx1Y2lhIE5ldG8iLCJwaG9uZV9udW1iZXIiOiIxMTk0ODQ4NDEyMCIsInNjb3BlIjpbIm9wZW5pZCIsInByb2ZpbGUiLCJyb2xlcyIsIm1vbHRyZXMuYWNlc3NvLmFwaS5mdWxsIl0sImFtciI6WyJwd2QiXX0.B3eFGfhhZ64zFGMrW1G_Ma__4gfTZEDvKVAkv-nXl0N05c2Ch9H8j6-f_SXUChaI4rRiSj_qstRuDkSr_nlnLIDt7nT31qvaRJY61iR8hJ2qy5VGXFLi0Pxsfc-HKe0cjR5v505ieZrIl5tPSp9uv_GOVn4J0xNRIsG6-x2vmAxRvi1FlidO93qRi47an8x_dMq8CWCdRJ4x3q3nFqFXF68qgFkWVZBAm0psPLmvU65gP5Df8iyv2KK3hcQvFaOUccsnqbCJwUHvFf0Eio3wL_ClNqDvLBCK25MJXO7iv01-i04tpKwNoaHQnp0twFologIb01CYIlqWge7vlZhtvA',
      bloc: bloc,
    );
  }
}
