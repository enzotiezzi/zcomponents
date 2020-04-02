import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:z_components/components/z-header.dart';
import 'package:z_components/components/z-item-tile.dart';
import 'package:z_components/view-model/atualizar-dados-viewmodel.dart';

import 'atualizar-dados-previsto.dart';

class ConfirmarPrevisto extends StatefulWidget {
  AtualizarDadosViewModel dadosViewModel;
  Function(AtualizarDadosViewModel) finalizarAtualizacao;

  ConfirmarPrevisto(
      {@required this.dadosViewModel, @required this.finalizarAtualizacao});

  @override
  _ConfirmarPrevistoState createState() => _ConfirmarPrevistoState();
}

class _ConfirmarPrevistoState extends State<ConfirmarPrevisto> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFEFF4),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: new Container(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new RaisedButton(
                color: Colors.white,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AtualizarDadosPrevisto(
                              dadosViewModel: widget.dadosViewModel,
                              finalizarAtualizacao: widget.finalizarAtualizacao,
                            )),
                  );
                },
                child: new Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 21.3,
                  width: MediaQuery.of(context).size.width / 3.6,
                  child: new Text(
                    "NÃO",
                    style: TextStyle(color: const Color(0xff707070)),
                  ),
                )),
            new RaisedButton(
              color: const Color(0xff2BBAB4),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              onPressed: () {
                widget.finalizarAtualizacao(widget.dadosViewModel);
              },
              child: new Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 21.3,
                width: MediaQuery.of(context).size.width / 3.6,
                child: new Text(
                  "SIM",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
      appBar: CupertinoNavigationBar(
        middle: new Text(
          "CONFIRMAR DADOS",
          style: TextStyle(color: const Color(0xff707070)),
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Column(
          children: <Widget>[
            ZHeader(
              titulo: "Seus dados abaixo estão corretos?",
            ),
            new Material(
              elevation: 4.0,
              child: new Container(
                color: const Color(0xffF0F0F0),
                padding: EdgeInsets.fromLTRB(16.0, 8.0, 16, 8.0),
                child: new ZItemTile(
                    cargo: widget.dadosViewModel.cargo,
                    tempoPausa: widget.dadosViewModel.tempoIntervalo,
                    horaSaida: widget.dadosViewModel.horaTermino,
                    horaEntrada: widget.dadosViewModel.horaInicio,
                    nomeCentroCusto: widget.dadosViewModel.centroCusto,
                    nome: widget.dadosViewModel.nomeColaborador,
                    escala: widget.dadosViewModel.escala,
                    status: widget.dadosViewModel.statusColaborador),
              ),
            )
          ],
        )
      ],
    );
  }
}
