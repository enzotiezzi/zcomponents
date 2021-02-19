import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/api/identity-server/identity-server.dart';
import 'package:z_components/api/identity-server/i-identity-server.dart';
import 'package:z_components/components/z-processo-seletivo/z-card-processo-seletivo.dart';
import 'package:z_components/components/z-collection/z-collection-bottomsheet.dart';
import 'package:z_components/components/z-collection/z-collection-item.dart';
import 'package:http/http.dart' as http;
import 'package:z_components/components/filtro/paginated-list.dart';

class MainTesting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainTestingState();
}

class _MainTestingState extends State<MainTesting> {
  IIdentityServer identityServer;

  List<ZCollectionItem> lista = [
    ZCollectionItem(chave: "MASCULINO", titulo: "MASCULINO", valor: "MASCULINO"),
    ZCollectionItem(chave: "FEMININO", titulo: "FEMININO", valor: "FEMININO"),
    ZCollectionItem(chave: "OUTRO", titulo: "OUTRO", valor: "OUTRO"),
    ZCollectionItem(chave: "OUTRO2", titulo: "OUTRO2", valor: "OUTRO2"),
    ZCollectionItem(chave: "OUTRO3", titulo: "OUTRO3", valor: "OUTRO3"),
  ];

  @override
  void initState() {
    identityServer = new IdentityServer(
        clientId: "ZTotem",
        redirectUrl: "net.openid.appauthztotem:/oauth2redirect",
        scopes: [
          'openid',
          'profile',
          'email',
          'offline_access',
          'moltres.acesso.api.full'
        ]);

    teste();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainStyle.get(context)
        .getDefaultScaffold("Componente de teste", _buildBody());
  }

  Widget _buildBody() {
    return new Column(
      children: [
        new ZCardProcessoSeletivo(
          themeData: Theme.of(context),
        ),
        new Divider(),
        new ZCollectionBottomSheet(
            title: "SEXO",
            themeData: Theme.of(context),
            lista: lista,
            onChange: (teste) {
              var valor = teste.valor;
              print(valor);
            }),
      ],
    );
  }

  teste() async {
    var headers = {
      "Content-type": "application/json",
      "Authorization":
          "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjFhZDEzYjE5ZTA2ODEwYjU0MzY0YmE5ZjRmYWFlNDU2IiwidHlwIjoiSldUIn0.eyJuYmYiOjE2MTM2NTE3NjUsImV4cCI6MTYxNjI0Mzc2NSwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIiLCJhdWQiOlsiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIvcmVzb3VyY2VzIiwibW9sdHJlcy5hY2Vzc28uYXBpIl0sImNsaWVudF9pZCI6IldlYiBaZWxsYXIiLCJzdWIiOiJiYmMwN2RkYS1hMzQ0LTQ3ZWQtOTRkNC1mZDg0NTI2Y2E3ODgiLCJhdXRoX3RpbWUiOjE2MTM2NTE3NjQsImlkcCI6ImxvY2FsIiwiQXNwTmV0LklkZW50aXR5LlNlY3VyaXR5U3RhbXAiOiJPWjRZREFURVFYRUM3RlNHTjRHNFhDTkIyN0c1UFhBUiIsImFjY291bnQiOiJaZWxsYXIyIiwiaWRBY2NvdW50IjoiOGU2ZWI2MzItYjcwNy00MTNmLWExNTItM2NmZmQxZjk4MmI1IiwiaWRDb2xhYm9yYWRvciI6IjE2QTgwNDE1LUQyODItNEFDQS04NDMxLThDN0YwNjkzQjE3QiIsInByZWZlcnJlZF91c2VybmFtZSI6IjQzOC4xOTcuNzE4LTE2IiwiZW1haWwiOiJibGFibGFAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOmZhbHNlLCJuYW1lIjoiRW56byBUaWV6emkiLCJwaG9uZV9udW1iZXIiOiIoMTEpOSA5NzE3LTI1NDQiLCJzY29wZSI6WyJvcGVuaWQiLCJwcm9maWxlIiwicm9sZXMiLCJtb2x0cmVzLmFjZXNzby5hcGkuZnVsbCJdLCJhbXIiOlsicHdkIl19.1Zdyi5bGQnO9nPideKfhPXiPVWqUupKfT6n5wc-BMEo78ZOft_0fgOEt7dq1-W-N9Ph1_HiLye-F7N-5kYD4Q_dsyasv4oqYCv-1r3pI1MhqJJe35ssPPjssKRY61dA06iP5YBR13st1bJWM363nLVt9z4GJRSL53Kz5zkqX19xGkX1K78R_J40Xlsp7EwhKf5i2g9sDnLpkilZvjhmnz5hjWQ0ADR62E0IMTUU3VSszw2DRNM9v7lMIZmakatMJ7EWhu7luiev-jQwanXjU59V3coqLT_ix73UH15fE8oUOOp2yea81gwTe4OrYqXirdLR2ZYWftPIEtgglJLUHOg"
    };

    var res = await http.get(
        "https://gateway-dev.zellar.com.br/api/v1/seguranca/grupo-acesso/niveis?Pagination.PageNumber=1&Pagination.PageSize=20",
        headers: headers);

    var a = new PaginatedList<GrupoResumo>(
            response: res, deserializer: GrupoResumo.fromJson)
        .mapToPaginatedList();

    print(a);
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
