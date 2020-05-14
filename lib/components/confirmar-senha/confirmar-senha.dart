import 'package:flutter/material.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/config/z-tipo-senha.dart';

import '../z-pin-senha.dart';

class ConfirmarSenha {
  String cpf;
  Function(bool) finalizarAtualizacao;
  BuildContext context;

  ConfirmarSenha(
      {@required this.cpf,
      @required this.finalizarAtualizacao,
      @required this.context});

  Future<bool> dialogConfirmarSenha() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => ZAlertDialog(
        zDialog: ZDialog.normal,
        child: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    bottom: 10.0,
                  ),
                  width: MediaQuery.of(context).size.width * 0.75,
                  margin: const EdgeInsets.only(top: 16, bottom: 10),
                  child: new Text(
                    "Digite seu pin",
                    textAlign: TextAlign.center,
                    style: new TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            new Container(
              padding: const EdgeInsets.all(8.0),
              child: new ZPinSenha(
                titulo: "Pin",
                onChange: (text) {
                  if (text.length == 4) {
                    Navigator.of(context).pop(true);
                  }
                },
                context: context,
                numeroQuadrados: 4,
                zTipos: ZTipoSenha.isSenha,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
