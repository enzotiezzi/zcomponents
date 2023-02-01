import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:z_components/components/espelho-ponto/espelho-ponto.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/z-progress-dialog.dart';
import 'package:z_components/i-view.dart';

class ZEspelhoDePontoView extends IView<ZEspelhoDePonto> {

  String? tituloNotificacao;
  String? mensagemNotificacao;

  bool showInvalida = false;

  late DialogUtils dialog;

  final keyProgress = GlobalKey<ZProgressDialogState>();
  final keyProgressInicial = GlobalKey<ZProgressDialogState>();

  late SharedPreferences sharedPreferences;

  late ScrollController scrollController;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  int indexDiaAtual = -1;

  DateTime? dataInicioFolha;
  DateTime? dataFimFolha;
  DateTime? dataEspelhoDePonto = DateTime.now();

  String? dataInicioPeriodo = "";
  String? dataFimPeriodo = "";

  ZEspelhoDePontoView(State<ZEspelhoDePonto> state) : super(state);

  @override
  Future initView() async {
    dialog = new DialogUtils(state.context);

    scrollController = new ScrollController();

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

  String montarDiasSemana(String? data) {
    var date = DateTime.parse(data!);

    var diasSemana = {
      DateTime.sunday: "DOM",
      DateTime.monday: "SEG",
      DateTime.tuesday: "TER",
      DateTime.wednesday: "QUA",
      DateTime.thursday: "QUI",
      DateTime.friday: "SEX",
      DateTime.saturday: "SAB",
    };

    return diasSemana[date.weekday]!;
  }

  String converterParaHoraMinutoString(String? data) {
    var date = DateTime.parse(data!);

    return "${date.hour.toString().padLeft(2, "0")}:${date.minute.toString().padLeft(2, "0")}";
  }

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    throw UnimplementedError();
  }

}
