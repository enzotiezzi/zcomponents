import 'dart:io';
import 'package:z_components/components/z-inputs/z-input-name.dart';
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
import 'package:z_components/components/z-collection/z-collection.dart';
import 'package:z_components/components/filtro/z-searchbar.dart';
import 'package:z_components/components/filtro/filtro-campo.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/z-response.dart';

import 'package:z_components/components/z-inputs/z-input-data-de-nascimento.dart';

import 'package:z_components/components/z-inputs/z-input-cpf.dart';

class MainTesting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainTestingState();
}

class _MainTestingState extends State<MainTesting> {
  FocusNode nomeFocusNode = new FocusNode();
  TextEditingController nomeController = new TextEditingController();
  FocusNode cpfFocusNode = new FocusNode();
  TextEditingController cpfController = new TextEditingController();
  IIdentityServer identityServer;

  List<ZCollectionItem> lista = [
    ZCollectionItem(
        chave: "MASCULINO", titulo: "MASCULINO", valor: "MASCULINO"),
    ZCollectionItem(chave: "FEMININO", titulo: "FEMININO", valor: "FEMININO"),
    ZCollectionItem(chave: "OUTRO", titulo: "OUTRO", valor: "OUTRO"),
    ZCollectionItem(chave: "OUTRO2", titulo: "OUTRO2", valor: "OUTRO2"),
    ZCollectionItem(chave: "OUTRO3", titulo: "OUTRO3", valor: "OUTRO3"),
  ];
  GlobalKey key = new GlobalKey();

  SearchOptions searchOptions = new SearchOptions();
  PaginationMetaData paginationMetaData = new PaginationMetaData();

  List<GrupoResumo> grupos = [];

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

    teste(searchOptions).then((value) => {
          this.setState(() {
            grupos = value.body;

            this.paginationMetaData = value.paginationMetaData;
            this.searchOptions.pagination.pageNumber++;
          })
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainStyle.get(context)
        .getDefaultScaffold("Componente de teste", _buildBody());
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: new Column(
        children: [
          new ZCardProcessoSeletivo(
            themeData: Theme.of(context),
          ),
        new Divider(
          height: 10.0,
        ),
        new Container(
          child: new ZInputCPF(
            themeData: Theme.of(context),
            cpfFocus: cpfFocusNode,
            controllerCpf: cpfController,
          ),
        ),
        new Divider(
          height: 10.0,
        ),
        new ZSearchBar(
          key: key,
          filtroPrincipal:
              new FiltroCampo(key: "NomeNivel", value: "Nome nivel"),
          onFilter: (filters) async {
            SearchOptions searchOptions = new SearchOptions();

            if (filters[0].value.toString().isNotEmpty) {
              searchOptions.filters = filters;
            }

            var response = await teste(searchOptions);

            searchOptions.pagination.pageNumber++;

            this.searchOptions = searchOptions;
            this.paginationMetaData = response.paginationMetaData;

            setState(() {
              grupos = response.body;
            });
          },
          camposFiltro: [
            new FiltroCampo(key: "NomeNivel", value: "Nome nivel"),
          ],
        ),
        new Expanded(
            child: new ListView.builder(
          itemCount: grupos.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => new Text(grupos[index].nomeNivel),
        ))
      ],
    ));
  }

  Future<ZResponse<GrupoResumo>> teste(SearchOptions searchOptions) async {
    var params = searchOptions.toHttpParams();

    var headers = {
      "Content-type": "application/json",
      "Authorization":
          "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjIwYzNkZjhkOGMwZjVhMmI0MmQ1ZDE0MTc2NGU2Y2U3IiwidHlwIjoiSldUIn0.eyJuYmYiOjE2MTM5OTg2MTAsImV4cCI6MTYxNjU5MDYxMCwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIiLCJhdWQiOlsiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIvcmVzb3VyY2VzIiwibW9sdHJlcy5hY2Vzc28uYXBpIl0sImNsaWVudF9pZCI6IldlYiBaZWxsYXIiLCJzdWIiOiJiYmMwN2RkYS1hMzQ0LTQ3ZWQtOTRkNC1mZDg0NTI2Y2E3ODgiLCJhdXRoX3RpbWUiOjE2MTM5OTg2MTAsImlkcCI6ImxvY2FsIiwiQXNwTmV0LklkZW50aXR5LlNlY3VyaXR5U3RhbXAiOiJPWjRZREFURVFYRUM3RlNHTjRHNFhDTkIyN0c1UFhBUiIsImFjY291bnQiOiJaZWxsYXIyIiwiaWRBY2NvdW50IjoiOGU2ZWI2MzItYjcwNy00MTNmLWExNTItM2NmZmQxZjk4MmI1IiwiaWRDb2xhYm9yYWRvciI6IjE2QTgwNDE1LUQyODItNEFDQS04NDMxLThDN0YwNjkzQjE3QiIsInByZWZlcnJlZF91c2VybmFtZSI6IjQzOC4xOTcuNzE4LTE2IiwiZW1haWwiOiJibGFibGFAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOmZhbHNlLCJuYW1lIjoiRW56byBUaWV6emkiLCJwaG9uZV9udW1iZXIiOiIoMTEpOSA5NzE3LTI1NDQiLCJzY29wZSI6WyJvcGVuaWQiLCJwcm9maWxlIiwicm9sZXMiLCJtb2x0cmVzLmFjZXNzby5hcGkuZnVsbCJdLCJhbXIiOlsicHdkIl19.trr71n6htf2cJnMvfSkZDt1kn21HKMt8LLkwUdJwUrDKF3jawDcbigeVzoXiHmIAc78WRd89BXQr-GETIxQzfMAPILSb9HiPTV4xt4dk-WftYicJ-NjcBnAWopS2g39KOMZVrtY6t4AUxYURAUe3ev8Mzq5SI9NHxujhufMllVJRMe-TTt6gqGpFXNncjjMv6yGA1Q5MOT_SoCoSWtIwQj2ItiuULgmGeJHW-aOY9yoqZNDZ1RJozE4Ef6qn2OutWknTeGntiEAqsUhuLDHBxCcgWtURkwdQ8OMnm4FjoXISGuCVi8YnstY4_NVs1CkqQoZlOS_kDGNac_CbbeTv_A"
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
