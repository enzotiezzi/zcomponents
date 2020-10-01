import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:z_components/components/z-sequencia/sequencia.dart';

class ZSequenciaCalendario extends StatefulWidget {
  final String primeiroDiaEscala;
  final String escala;

  ZSequenciaCalendario(
      {@required this.primeiroDiaEscala, @required this.escala});

  @override
  State<StatefulWidget> createState() => _ZSequenciaCalendarioState();
}

class _ZSequenciaCalendarioState extends State<ZSequenciaCalendario> {
  Sequencia _sequencia;

  var _calendarController = new CalendarController();

  @override
  void initState() {
    _sequencia = new Sequencia(
        primeiroDiaEscala: widget.primeiroDiaEscala, escala: widget.escala);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new TableCalendar(
        headerStyle: new HeaderStyle(
            formatButtonVisible: false, centerHeaderTitle: true),
        locale: "pt-BR",
        calendarController: _calendarController,
        builders: new CalendarBuilders(dayBuilder: (context, date, dayBuilder) {
          var touf = _sequencia.calcularSeDiaTouF(date);

          return new Column(
            children: [
              new Container(
                child: new Text(
                  "${date.day}",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
