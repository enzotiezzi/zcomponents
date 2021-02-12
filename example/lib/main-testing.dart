import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/api/identity-server/identity-server.dart';
import 'package:z_components/api/identity-server/i-identity-server.dart';
import 'package:z_components/components/z-collection/z-collection.dart';

class MainTesting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainTestingState();
}

class _MainTestingState extends State<MainTesting> {
  IIdentityServer identityServer;

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
        new ZCollection(
          titulo: "Teste",
          lista: [],
          themeData: Theme.of(context),
        ),
        new ZCollection(
          titulo: "Teste",
          lista: [],
          themeData: Theme.of(context),
        )
      ],
    );
  }
}
