import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:z_components/api/quadro-pessoal-service.dart';
import 'package:z_components/components/z_loading.dart';

class ZSequencia extends StatefulWidget {
  final String idColaborador;
  final String idConta;
  final String token;

  ZSequencia(
      {@required this.idColaborador,
      @required this.token,
      @required this.idConta});

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

  QuadroPessoalService _quadroPessoalService;

  @override
  void initState() {
    super.initState();

    indexDia = -3;

    _quadroPessoalService =
        new QuadroPessoalService(widget.token, widget.idConta);

    _buscarSequencia();
  }

  @override
  Widget build(BuildContext context) {
    indexDia = -3;

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
    var backGroundColor = const Color(0xFFFFFFFF);
    var fontColor = const Color(0xFF2BBAB4);
    var borderColor = const Color(0xFF2BBAB4);

    var data = new DateTime.now().add(new Duration(days: indexDia));
    var diaSemana = new DateFormat.EEEE().format(data);

    var dia = _diasSemana[diaSemana];

    var formato = new DateFormat("yyyy-MM-dd");

    var dataFormatada = formato.format(data);
    var hojeFormatado = formato.format(DateTime.now());

    if (dataFormatada == hojeFormatado) {
      dia = "HOJE";
      backGroundColor = const Color(0xFF2BBAB4);
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

  Future _buscarSequencia() async {
    var sequencia =
        await _quadroPessoalService.listarTouFColaborador(widget.idColaborador);

    if (sequencia != null) {
      setState(() {
        _sequencia = sequencia;
      });
    }
  }
}
