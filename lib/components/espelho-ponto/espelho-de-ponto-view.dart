import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:injector/injector.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:z_components/components/espelho-ponto/espelho-ponto.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/z-progress-dialog.dart';
import 'package:z_components/i-view.dart';

class ZEspelhoDePontoView extends IView<ZEspelhoDePonto> {

  String tituloNotificacao;
  String mensagemNotificacao;

  bool showInvalida = false;

  DialogUtils dialog;

  final keyProgress = GlobalKey<ZProgressDialogState>();
  final keyProgressInicial = GlobalKey<ZProgressDialogState>();

  SharedPreferences sharedPreferences;

  ScrollController scrollController;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  int indexDiaAtual = -1;

  DateTime dataInicioFolha;
  DateTime dataFimFolha;
  DateTime dataEspelhoDePonto = DateTime.now();

  String dataInicioPeriodo = "";
  String dataFimPeriodo = "";

  ZEspelhoDePontoView(State<ZEspelhoDePonto> state) : super(state);

  @override
  Future initView() async {
    dialog = new DialogUtils(state.context);

    scrollController = new ScrollController();

  //  _scrollarParaDiaDeHoje();
  }

  String formatarData(String data) {
    var format;
    String dataFormatada;
    format = data.split("-");
    dataFormatada = "${format[2]}/${format[1]}";

    return dataFormatada;
  }

  bool diaAtual(String text) {
    var dataInicial = DateTime.now();

    return "${dataInicial.year}-${dataInicial.month.toString().padLeft(2, "0")}-${dataInicial.day.toString().padLeft(2, "0")}" ==
        text;
  }

  String montarDiasSemana(String data) {
    var date = DateTime.parse(data);

    var diasSemana = {
      DateTime.sunday: "DOM",
      DateTime.monday: "SEG",
      DateTime.tuesday: "TER",
      DateTime.wednesday: "QUA",
      DateTime.thursday: "QUI",
      DateTime.friday: "SEX",
      DateTime.saturday: "SAB",
    };

    return diasSemana[date.weekday];
  }

  String converterParaHoraMinutoString(String data) {
    var date = DateTime.parse(data);

    return "${date.hour.toString().padLeft(2, "0")}:${date.minute.toString().padLeft(2, "0")}";
  }

  void _scrollarParaDiaDeHoje() {
    double offset = 0.0;

    var deltaDias = dataFimFolha.difference(dataInicioFolha).inDays; // meu 100%
    var deltaAtual = dataFimFolha
        .difference(DateTime.now())
        .inDays; // % de dias que ja passou

    double offsetRelativo = 1000 - ((deltaAtual / deltaDias) * 1000) + 1;

    Future.delayed(new Duration(seconds: 1), () {
      scrollController.animateTo((offsetRelativo / 100.0).round() * 100.0,
          duration: new Duration(milliseconds: 1000), curve: Curves.ease);
    });
  }
}
