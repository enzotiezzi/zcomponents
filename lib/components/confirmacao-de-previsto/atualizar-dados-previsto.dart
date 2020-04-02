import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-baseline.dart';
import 'package:z_components/components/z-header.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:z_components/config/z-tipos-baseline.dart';
import 'package:z_components/view-model/atualizar-dados-viewmodel.dart';

class AtualizarDadosPrevisto extends StatefulWidget {
  AtualizarDadosViewModel dadosViewModel;
  Function(AtualizarDadosViewModel) finalizarAtualizacao;

  AtualizarDadosPrevisto({this.dadosViewModel, this.finalizarAtualizacao});

  @override
  _AtualizarDadosPrevistoState createState() => _AtualizarDadosPrevistoState();
}

class _AtualizarDadosPrevistoState extends State<AtualizarDadosPrevisto> {
  int _page = 0;
  double _percent = 0.1;
  List _titulos = ["Centro de Custo", "Cargo", "Escala", "Horário"];
  List _textHeader = [
    "Este é o seu centro de custo?",
    "Este é o seu cargo?",
    "Está é sua escala de trabalho?",
    "Este é o seu horário de trabalho?",
  ];
  TextEditingController _controller2;
  TextEditingController _controller3;
  TextEditingController _controller4;
  TextEditingController _controller5;
  TextEditingController _controller6;
  TextEditingController _controller7;

  FocusNode _focusNode = new FocusNode();
  List<TextEditingController> _listController;

  @override
  void initState() {
    _controller2 =
        new TextEditingController(text: widget.dadosViewModel.centroCusto);
    _controller3 = new TextEditingController(text: widget.dadosViewModel.cargo);
    _controller4 =
        new TextEditingController(text: widget.dadosViewModel.escala);
    _controller5 =
        new TextEditingController(text: "${widget.dadosViewModel.horaInicio}");
    _controller6 =
        new TextEditingController(text: "${widget.dadosViewModel.horaTermino}");
    _controller7 = new TextEditingController(
        text: "${widget.dadosViewModel.tempoIntervalo}");

    _listController = [_controller2, _controller3, _controller4, _controller5];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_page == 0) {
      FocusScope.of(context).requestFocus(_focusNode);
    }
    return Scaffold(
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
                  if (_page == 0) {
                    Navigator.of(context).pop();
                  } else {
                    FocusScope.of(context).requestFocus(_focusNode);
                  }
                },
                child: new Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 21.3,
                  width: MediaQuery.of(context).size.width / 3,
                  child: (_page == 0)
                      ? new Text(
                          "CANCELAR",
                          style: TextStyle(color: const Color(0xff707070)),
                        )
                      : new Text(
                          "NÃO",
                          style: TextStyle(color: const Color(0xff707070)),
                        ),
                )),
            new RaisedButton(
              color: const Color(0xff2BBAB4),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              onPressed: () {
                _focusNode.unfocus();
                setState(() {
                  if (_page >= 2) {
                    _percent = 1.0;
                  } else {
                    _percent = _percent + 0.24;
                  }
                  if (_page == 3) {
                    AtualizarDadosViewModel dadosAtualizados =
                        new AtualizarDadosViewModel(
                            statusColaborador:
                                widget.dadosViewModel.statusColaborador,
                            nomeColaborador:
                                widget.dadosViewModel.nomeColaborador,
                            cargo: _controller3.text,
                            centroCusto: _controller2.text,
                            escala: _controller4.text,
                            horaInicio: _controller5.text,
                            horaTermino: _controller6.text,
                            tempoIntervalo: _controller7.text);
                    widget.finalizarAtualizacao(dadosAtualizados);
                  }
                  if (_page < 3) {
                    _page++;
                  }
                });
              },
              child: new Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 21.3,
                width: MediaQuery.of(context).size.width / 3,
                child: new Row(
                  children: <Widget>[
                    new Text(
                      "CONFIRMAR",
                      style: TextStyle(color: Colors.white),
                    ),
                    new Container(
                      padding: EdgeInsets.only(left: 10.0),
                      child: new Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: const Color(0xffEFEFF4),
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
      children: <Widget>[
        ZHeader(
          titulo: _textHeader[_page],
        ),
        _linear(),
        new Container(
            margin: EdgeInsets.only(top: 20.0),
            child: (_page > 4) ? new Container() : _text())
      ],
    );
  }

  Widget _linear() {
    return new Container(
      child: new LinearPercentIndicator(
        lineHeight: 8.0,
        percent: _percent,
        backgroundColor: Colors.white,
        progressColor: const Color(0xff2BBAB4),
      ),
    );
  }

  Widget _text() {
    if (_page >= 3) {
      return new Container(
        child: new Column(
          children: <Widget>[
            new ZBaseLine(
              padraoFocus: _focusNode,
              zTipos: ZTipoBaseline.semTituloText,
              text: "Hora de Entrada",
              controllerPadrao: _controller5,
            ),
            new ZBaseLine(
              zTipos: ZTipoBaseline.semTituloText,
              text: "Hora de Saída",
              controllerPadrao: _controller6,
            ),
            new ZBaseLine(
              zTipos: ZTipoBaseline.semTituloText,
              text: "Tempo de Intervalo",
              controllerPadrao: _controller7,
            )
          ],
        ),
      );
    } else {
      return new ZBaseLine(
        zTipos: ZTipoBaseline.semTituloText,
        text: _titulos[_page],
        hintText: "",
        controllerPadrao: _listController[_page],
      );
    }
  }
}
