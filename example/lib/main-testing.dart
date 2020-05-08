import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/components/z-sequencia/z-sequencia.dart';

class MainTesting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainTestingState();
}

class _MainTestingState extends State<MainTesting> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainStyle.get(context)
        .getDefaultScaffold("Componente de teste", _buildBody());
  }

  Widget _buildBody() {
    return new Container(
      padding: const EdgeInsets.all(16.0),
      child: new ZSequencia(
        escala: "5x2",
        primeiroDiaEscala: new DateTime(2020, 4, 6).toIso8601String(),
      ),
    );
  }
}
