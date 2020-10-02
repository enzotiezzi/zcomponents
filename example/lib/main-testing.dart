import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/components/z-sequencia/z-sequencia-calendario.dart';
import 'package:z_components/components/z-sequencia/z-sequencia.dart';
import 'package:z_components/api/identity-server/identity-server.dart';
import 'package:z_components/api/identity-server/i-identity-server.dart';
import 'package:z_components/components/utils/theme.dart';

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
        new ZSequencia(
          escala: "5x2",
          primeiroDiaEscala: new DateTime(2020, 4, 6).toIso8601String(),
          themeData: CustomTheme.appTheme,
        )
      ],
    );
  }
}
