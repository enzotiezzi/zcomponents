import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:z_components/api/quadro-pessoal-service.dart';
import 'package:z_components/components/z_loading.dart';

class ZSequencia extends StatefulWidget {
  final String primeiroDiaEscala;
  final String escala;
  final Color color;
  final DateTime data;

  ZSequencia(
      {@required this.primeiroDiaEscala,
      @required this.escala,
      this.data,
      this.color: const Color(0xff2bbab4)});

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

    if(widget.data != null)
      date = widget.data;

    var backGroundColor = const Color(0xFFFFFFFF);
    var fontColor = widget.color;
    var borderColor = widget.color;

    var data = date.add(new Duration(days: indexDia));
    var diaSemana = new DateFormat.EEEE().format(data);

    var dia = _diasSemana[diaSemana];

    var formato = new DateFormat("yyyy-MM-dd");

    var dataFormatada = formato.format(data);
    var hojeFormatado = formato.format(new DateTime.now());

    if (dataFormatada == hojeFormatado) {
      dia = "HOJE";
      backGroundColor = widget.color;
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
    var date = new DateTime.now();

    if(widget.data != null)
      date = widget.data;

    var sequencia = new List<String>();

    var indexDias = -3;

    while (indexDias <= 3) {
      var touf =
          _calcularSeDiaTouF(date.add(new Duration(days: indexDias)));

      sequencia.add(touf);

      indexDias++;
    }

    if (sequencia.length != 0) {
      if (mounted)
        setState(() {
          _sequencia = sequencia;
        });
    }
  }

  String _calcularSeDiaTouF(DateTime date) {
    var escalaNormalizada = _normalizarEscala(widget.escala);

    var quantidadeDeDiasNaEmpresa =
        _calcularDiasNaEmpresa(widget.primeiroDiaEscala, date);

    var quantidadeDeDiasNaEscala = _calcularDiasNaEscala(escalaNormalizada);

    var diaAtualNaEscala =
        _mod(quantidadeDeDiasNaEmpresa, quantidadeDeDiasNaEscala);

    var vetorTouF = _montarVetorTouF(escalaNormalizada);

    return vetorTouF[diaAtualNaEscala];
  }

  String _normalizarEscala(String escala) {
    var escalaNormalizada = escala;

    if (escalaNormalizada.toLowerCase() == "12x36") escalaNormalizada = "1x1";

    return escalaNormalizada;
  }

  int _calcularDiasNaEmpresa(String primeiroDiaEscala, DateTime date) {
    var dataPrimeiroDiaEscala = DateTime.parse(primeiroDiaEscala);

    return date.difference(dataPrimeiroDiaEscala).inDays;
  }

  int _calcularDiasNaEscala(String escala) {
    if (escala.contains('x')) {
      var diasNaEscala = 0;

      escala.split('x').forEach((x) => diasNaEscala += int.parse(x));

      return diasNaEscala;
    }

    return -1;
  }

  int _mod(int a, int b) {
    return (a - (a / b).floor() * b);
  }

  List<String> _montarVetorTouF(String escala) {
    var vetorTouF = new List<String>();

    var escalaFracionada = escala.split('x');

    for (var i = 0; i < escalaFracionada.length; i++) {
      var quantidadeDias = int.parse(escalaFracionada[i]);

      for (var y = 0; y < quantidadeDias; y++) {
        if (i % 2 == 0) {
          vetorTouF.add("T");
        } else {
          vetorTouF.add("F");
        }
      }
    }

    return vetorTouF;
  }
}
