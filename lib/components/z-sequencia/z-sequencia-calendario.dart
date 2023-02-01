import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:z_components/components/z-sequencia/sequencia.dart';
import 'package:z_components/styles/main-style.dart';

class ZSequenciaCalendario extends StatefulWidget {
  final String? primeiroDiaEscala;
  final String? escala;
  final ThemeData? themeData;
  final Function(DateTime)? aoSelecionarData;
  final StartingDayOfWeek? startingDayOfWeek;

  ZSequenciaCalendario(
      {@required this.primeiroDiaEscala,
      @required this.escala,
      @required this.themeData,
      this.startingDayOfWeek,
      this.aoSelecionarData});

  @override
  State<StatefulWidget> createState() => _ZSequenciaCalendarioState();
}

class _ZSequenciaCalendarioState extends State<ZSequenciaCalendario> {
  Sequencia? _sequencia;
  String? primeiroDia;

  //var _calendarController = new CalendarController();

  @override
  void initState() {
    primeiroDia = widget.primeiroDiaEscala;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _sequencia =
        new Sequencia(primeiroDiaEscala: primeiroDia, escala: widget.escala);

    return new Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        new TableCalendar(
          startingDayOfWeek: widget.startingDayOfWeek!,
          headerStyle: new HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true
              //centerHeaderTitle: true,
          ),
          locale: "pt-BR",
          //calendarController: _calendarController,

          headerVisible: true,

          calendarBuilders: new CalendarBuilders(
            //dayBuilder: _buildDay,
            //todayBuilder: _buildDay!,
            //dowBuilder: _buildWeekDay(),
            //dowWeekdayBuilder: _buildWeekDay,
          ),
          onDaySelected: (selectedDay, focusedDay){}, //selecionarDia,
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
        ),
        new Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: new Divider(
            height: 4,
            color: const Color(0xFFCCCCCC),
          ),
        ),
        new Container(
          padding: const EdgeInsets.all(16.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Row(
                    children: [
                      new Container(
                        width: 10,
                        height: 10,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: widget.themeData!.primaryColor, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      new Text(
                        "DIA ATUAL",
                        style: new TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  new Row(
                    children: [
                      new Container(
                        width: 10,
                        height: 10,
                        decoration: new BoxDecoration(
                            color: widget.themeData!.primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      new Text("DIAS T (TRABALHO)",
                          style: new TextStyle(fontSize: 10)),
                    ],
                  )
                ],
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Row(
                    children: [
                      new Container(
                        width: 10,
                        height: 10,
                        decoration: new BoxDecoration(
                          color: widget.themeData!.primaryColor,
                          border: Border.all(
                              color: widget.themeData!.accentColor, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      new Text(
                        "PRIMEIRO DIA DA ESCALA",
                        style: new TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  new Row(
                    children: [
                      new Container(
                        width: 10,
                        height: 10,
                        decoration: new BoxDecoration(
                            color: const Color(0xFFE6E6E6),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      new Text("DIAS F (FOLGA)",
                          style: new TextStyle(fontSize: 10))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDay(
      BuildContext context, DateTime date, List<dynamic> dayBuilder) {
    var touf = _sequencia!.calcularSeDiaTouF(date);

    BoxDecoration boxDecoration;
    Color corDoDia;
    Color corPreenchimento;

    bool diaIgualAHoje = _checarSeDiaIgualAHoje(date);
    bool diaDesseMes = _checarSeDiaDesseMes(date);
    bool primeiroDia = _checarSeHojeEPrimeiroDia(date);

    if (primeiroDia) {
      corDoDia = Colors.white;
      corPreenchimento = widget.themeData!.primaryColor;
      boxDecoration = new BoxDecoration(
          color: corPreenchimento,
          border:
              new Border.all(color: widget.themeData!.accentColor, width: 2));
    } else {
      if (diaIgualAHoje) {
        corDoDia = widget.themeData!.primaryColor;
        corPreenchimento = Colors.white;
        boxDecoration = new BoxDecoration(
            color: corPreenchimento,
            border:
                new Border.all(color: widget.themeData!.primaryColor, width: 2));
      } else {
        corDoDia = _definirCorDoDia(touf);
        corPreenchimento = _definirCorDePreenchimento(touf);
        boxDecoration = new BoxDecoration(
          color: corPreenchimento,
        );
      }
    }

    return new Column(
      children: [
        new Container(
          alignment: Alignment.center,
          width: 30,
          height: 30,
          padding: const EdgeInsets.all(4.0),
          decoration: boxDecoration,
          child: new Text(
            "${date.day}",
            style: new TextStyle(color: corDoDia, fontSize: 14.0),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  Widget? _buildWeekDay(BuildContext context, String weekDay) {
    return new Container(
      padding: const EdgeInsets.all(4.0),
      child: new Text(
        weekDay.toUpperCase(),
        textAlign: TextAlign.center,
        style: widget.themeData?.textTheme.bodyText2!
            .copyWith(color: Color(0xFF707070)),
      ),
    );
  }

  Color _definirCorDoDia(String touf) {
    switch (touf) {
      case "T":
        return Colors.white;
      case "F":
        return const Color(0xFF707070);
      default:
        return Colors.black;
    }
  }

  Color _definirCorDePreenchimento(String touf) {
    switch (touf) {
      case "T":
        return widget.themeData!.primaryColor;
      case "F":
        return const Color(0xFFE6E6E6);
      default:
        return Colors.white;
    }
  }

  bool _checarSeDiaIgualAHoje(DateTime date) {
    return date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day == DateTime.now().day;
  }

  bool _checarSeDiaDesseMes(DateTime date) {
    return date.year == DateTime.now().year &&
        date.month == DateTime.now().month;
  }

  bool _checarSeHojeEPrimeiroDia(DateTime date) {
    var dia = DateTime.parse(primeiroDia!);

    return dia.year == date.year &&
        dia.month == date.month &&
        dia.day == date.day;
  }

  void selecionarDia(DateTime date, _, __) {
    if(widget.aoSelecionarData != null) widget.aoSelecionarData!(date);

    if (mounted) {
      setState(() {
        primeiroDia = date.toIso8601String();
      });
    }
  }
}
