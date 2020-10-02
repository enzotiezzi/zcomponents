import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:z_components/api/quadro-pessoal-service.dart';
import 'package:z_components/components/z-sequencia/sequencia.dart';
import 'package:z_components/components/z_loading.dart';

class ZSequencia extends StatefulWidget {
  final String primeiroDiaEscala;
  final String escala;
  final ThemeData themeData;
  final DateTime data;

  ZSequencia(
      {@required this.primeiroDiaEscala,
      @required this.escala,
      @required this.themeData,
      this.data,
      });

  @override
  State<StatefulWidget> createState() => new ZSequenciaState();
}

class ZSequenciaState extends State<ZSequencia> {
  var indexDia = 0;

  Map<String, String> _diasSemana = {
    "Monday": "SEG",
    "Tuesday": "TER",
    "Wednesday": "QUA",
    "Thursday": "QUI",
    "Friday": "SEX",
    "Saturday": "SAB",
    "Sunday": "DOM"
  };

  var _sequencia = new List<String>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    indexDia = -3;

    _montarSequencia();

    return _sequencia.length == 0 ? _buildLoad() : _buildSequencia();
  }

  Widget _buildLoad() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new ZLoading(),
      ],
    );
  }

  Widget _buildSequencia() {
    var seqs = new List<Widget>();

    for (int i = 0; i < _sequencia.length; i++)
      seqs.add(_buildItemSequencia(i));

    return new Material(
      elevation: 2.0,
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
      child: new Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        padding: const EdgeInsets.all(4.0),
        child: new Row(
          children: seqs,
        ),
      ),
    );
  }

  Widget _buildItemSequencia(index) {
    var date = new DateTime.now();

    if (widget.data != null) date = widget.data;

    var backGroundColor = const Color(0xFFFFFFFF);
    var fontColor = widget.themeData.primaryColor;
    var borderColor = widget.themeData.primaryColor;

    var data = date.add(new Duration(days: indexDia));
    var diaSemana = new DateFormat.EEEE().format(data);

    var dia = _diasSemana[diaSemana];

    var formato = new DateFormat("yyyy-MM-dd");

    var dataFormatada = formato.format(data);
    var hojeFormatado = formato.format(new DateTime.now());

    if (dataFormatada == hojeFormatado) {
      dia = "HOJE";
      backGroundColor = widget.themeData.primaryColor;
      fontColor = const Color(0xFFFFFFFF);
    }

    switch (_sequencia[index]) {
      case "F":
        backGroundColor = const Color(0xFFF0F0F0);
        fontColor = const Color(0xFFCCCCCC);
        borderColor = const Color(0xFFF0F0F0);
        break;
    }

    indexDia++;

    return new Container(
      decoration: new BoxDecoration(
          color: backGroundColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      padding: const EdgeInsets.all(2.0),
      margin: const EdgeInsets.all(2.0),
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text(
            "${dia ?? ""}",
            style: new TextStyle(color: fontColor, fontWeight: FontWeight.w500),
          ),
          new Text(
            "${_sequencia[index] ?? ""}",
            style: new TextStyle(color: fontColor, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  List<String> _montarSequencia() {
    var sequencia = new Sequencia(
        escala: widget.escala, primeiroDiaEscala: widget.primeiroDiaEscala);

    var date = new DateTime.now();

    if (widget.data != null) date = widget.data;

    var sequencias = new List<String>();

    var indexDias = -3;

    while (indexDias <= 3) {
      var touf =
          sequencia.calcularSeDiaTouF(date.add(new Duration(days: indexDias)));

      sequencias.add(touf);

      indexDias++;
    }

    if (sequencias.length != 0) {
      if (mounted)
        setState(() {
          _sequencia = sequencias;
        });
    }
  }
}
