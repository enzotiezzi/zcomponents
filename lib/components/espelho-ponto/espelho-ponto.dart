import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:z_components/view-model/batida-viewmodel.dart';
import 'package:z_components/view-model/espelhodeponto-viewmodel.dart';
import 'dialog-ocorrencia.dart';
import 'espelho-de-ponto-view.dart';

class ZEspelhoDePonto extends StatefulWidget {
  List<ZEspelhoDePontoViewModel> espelhos;
  var onTapDialogBatida;
  var refresh;

  ZEspelhoDePonto({this.espelhos, this.onTapDialogBatida});

  @override
  _ZEspelhoDePontoState createState() => _ZEspelhoDePontoState();
}

class _ZEspelhoDePontoState extends State<ZEspelhoDePonto> {
  ZEspelhoDePontoView _view;
  GlobalKey _espelhoDePontoKey = new GlobalKey<_ZEspelhoDePontoState>();

  @override
  void initState() {
    super.initState();
    _view = ZEspelhoDePontoView(this);
    _view.initView();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    if (widget.espelhos.length == 0)
      return new Center();
    else {
      if (_view.indexDiaAtual != -1)
        try {
          _view.scrollController.animateTo(
              _view.indexDiaAtual * (MediaQuery.of(context).size.height / 16),
              duration: new Duration(milliseconds: 1000),
              curve: Curves.ease);
        } catch (e) {
          WidgetsBinding.instance.addPostFrameCallback((duration) {
            _view.scrollController.animateTo(
                _view.indexDiaAtual * (MediaQuery.of(context).size.height / 16),
                duration: new Duration(milliseconds: 1000),
                curve: Curves.ease);
          });
        }

      return new Container(
        child: new Column(
          children: <Widget>[
            new Material(
              elevation: 10.0,
              child: new Container(
                color: const Color(0xff707070),
                child: new Row(
                  children: <Widget>[
                    new Container(
                      width: (MediaQuery.of(context).size.width / 6.5) - 1,
                      child: new Container(
                        margin: EdgeInsets.only(right: 14.0),
                        alignment: Alignment.centerRight,
                        child: new Text(
                          "DIA",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    new Container(
                      height: MediaQuery.of(context).size.height / 16,
                      color: Colors.grey,
                      width: 1,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: new Container(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                              child: new Text(
                                "PLANEJADO",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.0),
                              ),
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                new Container(
                                  child: new Icon(
                                    Icons.call_made,
                                    color: Colors.white,
                                  ),
                                ),
                                new Container(
                                  margin:
                                      EdgeInsets.only(left: 3.0, right: 3.0),
                                  child: new Icon(
                                    Icons.call_received,
                                    color: Colors.white,
                                  ),
                                ),
                                new Container(
                                  child: new Icon(
                                    Icons.restaurant_menu,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    new Container(
                      height: MediaQuery.of(context).size.height / 16,
                      color: Colors.grey,
                      width: 2,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      width: (MediaQuery.of(context).size.width / 1.8) - 2,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new Container(
                            margin: EdgeInsets.only(right: 2.0),
                            child: new Icon(
                              Icons.warning,
                              color: Colors.white,
                              size: 16.0,
                            ),
                          ),
                          new Container(
                            margin: EdgeInsets.only(left: 4.0, right: 4.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                  child: new Text(
                                    "REGISTRO DE PONTO",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              setState(() {
                                _view.showInvalida = !_view.showInvalida;
                              });
                            },
                            child: new Container(
                              margin: EdgeInsets.only(left: 10.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6.0)),
                              padding: EdgeInsets.all(1.0),
                              child: (_view.showInvalida == true)
                                  ? new Icon(
                                      Icons.alarm_off,
                                      color: const Color(0xff2BBAB4),
                                    )
                                  : new Icon(
                                      Icons.alarm_on,
                                      color: const Color(0xff2BBAB4),
                                    ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Expanded(
                child: SmartRefresher(
                    enablePullDown: true,
                    controller: _view.refreshController,
                    onRefresh: widget.refresh,
                    header: ClassicHeader(
                      idleText: "Puxe para atualizar",
                      releaseText: "Solte para atualizar",
                      refreshingText: "Atualizando",
                      completeText: "Sua lista está atualizada!",
                      iconPos: IconPosition.right,
                    ),
                    child: new ListView.builder(
                        key: _espelhoDePontoKey,
                        controller: _view.scrollController,
                        itemCount: widget.espelhos.length,
                        itemBuilder: (context, index) => _listPonto(index))))
          ],
        ),
      );
    }
  }

  Widget _listPonto(index) {
    var item = widget.espelhos[index];

    if (_view.diaAtual(item.data)) _view.indexDiaAtual = index;

    var corTouf = const Color(0xff707070);

    if (item.tOuF == "F") corTouf = const Color(0xFFC7C7CC);

    var entrada =
        item.horaEntradaPrevisto == "" ? "00:00" : item.horaEntradaPrevisto;
    if (entrada == null) entrada = "00:00";

    var saida =
        item?.horaSaidaPrevisto == "" ? "00:00" : item.horaSaidaPrevisto;
    if (saida == null) saida = "00:00";

    var intervalo = item?.horaIntervaloPrevisto == ""
        ? "00:00"
        : item.horaIntervaloPrevisto;
    if (intervalo == null) intervalo = "00:00";

    return (index == 30)
        ? new Container(
            margin: EdgeInsets.only(bottom: 30.0),
            child: new Column(
              children: <Widget>[
                new Container(
                  decoration: (_view.diaAtual(item.data) == true)
                      ? BoxDecoration(
                          border: Border.all(
                              width: 2.0, color: const Color(0xff2BBAB4)))
                      : BoxDecoration(),
                  child: new Row(
                    children: <Widget>[
                      (item.tOuF == "F")
                          ? new Container(
                              color: const Color(0xffF7F7F7),
                              width: (_view.diaAtual(item.data) == true)
                                  ? ((MediaQuery.of(context).size.width / 6.5) -
                                      3)
                                  : ((MediaQuery.of(context).size.width / 6.5) -
                                      1),
                              child: new Row(
                                children: <Widget>[
                                  new Container(
                                    width: (_view.diaAtual(item.data) == true)
                                        ? (MediaQuery.of(context).size.width /
                                                30) -
                                            2
                                        : MediaQuery.of(context).size.width /
                                            30,
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.only(left: 2.0, right: 2.0),
                                    height:
                                        MediaQuery.of(context).size.height / 16,
                                    color: corTouf,
                                    child: (item.tOuF != null)
                                        ? new Text(item.tOuF)
                                        : new Text(""),
                                  ),
                                  new Expanded(
                                      child: new Container(
                                    height:
                                        MediaQuery.of(context).size.height / 16,
                                    child: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Container(
                                          child: new Text(
                                            "${_view.formatarData(item.data) ?? ""}",
                                            style: TextStyle(
                                                color: const Color(0xff707070)),
                                          ),
                                        ),
                                        new Container(
                                          child: (item.data == null)
                                              ? new Text("")
                                              : new Text(
                                                  _view.montarDiasSemana(
                                                      item.data),
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xff707070),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            )
                          : new Container(
                              color: const Color(0xffE6E6E6),
                              width: (_view.diaAtual(item.data) == true)
                                  ? ((MediaQuery.of(context).size.width / 6.5) -
                                      3)
                                  : ((MediaQuery.of(context).size.width / 6.5) -
                                      1),
                              child: new Row(
                                children: <Widget>[
                                  new Container(
                                    width: (_view.diaAtual(item.data) == true)
                                        ? (MediaQuery.of(context).size.width /
                                                30) -
                                            2
                                        : MediaQuery.of(context).size.width /
                                            30,
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.only(left: 2.0, right: 2.0),
                                    height:
                                        MediaQuery.of(context).size.height / 16,
                                    color: corTouf,
                                    child: (item.tOuF != null)
                                        ? new Text(
                                            item.tOuF,
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        : new Text(""),
                                  ),
                                  new Expanded(
                                      child: new Container(
                                    height:
                                        MediaQuery.of(context).size.height / 16,
                                    child: new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Container(
                                          child: new Text(
                                            "${_view.formatarData(item.data) ?? ""}",
                                            style: TextStyle(
                                                color: const Color(0xff707070)),
                                          ),
                                        ),
                                        new Container(
                                          child: (item.data == null)
                                              ? new Text("")
                                              : new Text(
                                                  _view.montarDiasSemana(
                                                      item.data),
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xff707070),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
                      new Container(
                        height: MediaQuery.of(context).size.height / 16,
                        color: Colors.grey,
                        width: 1,
                      ),
                      (item.tOuF == "F")
                          ? new Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height / 16,
                              width: MediaQuery.of(context).size.width / 3.5,
                              color: const Color(0xffF7F7F7),
                              child: new Text(
                                "FOLGA",
                                style: TextStyle(
                                    color: const Color(0xff707070),
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          : Container(
                              color: const Color(0xffE6E6E6),
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  new Container(
                                    alignment: Alignment.center,
                                    height:
                                        MediaQuery.of(context).size.height / 16,
                                    child: new Text(
                                      "${entrada}",
                                      style: (entrada == null ||
                                              entrada == "00:00")
                                          ? TextStyle(
                                              color: Colors.transparent,
                                              fontSize: 12.0)
                                          : TextStyle(
                                              fontSize: 12.0,
                                              color: const Color(0xff707070),
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  new Container(
                                    color: Colors.grey,
                                    width: 1,
                                    height:
                                        MediaQuery.of(context).size.height / 50,
                                  ),
                                  new Container(
                                    alignment: Alignment.center,
                                    height:
                                        MediaQuery.of(context).size.height / 16,
                                    child: new Text(
                                      "${saida}",
                                      style: (saida == null || saida == "00:00")
                                          ? TextStyle(
                                              color: Colors.transparent,
                                              fontSize: 12.0)
                                          : TextStyle(
                                              fontSize: 12.0,
                                              color: const Color(0xff707070),
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  new Container(
                                    color: Colors.grey,
                                    width: 1,
                                    height:
                                        MediaQuery.of(context).size.height / 50,
                                  ),
                                  new Container(
                                    alignment: Alignment.center,
                                    height:
                                        MediaQuery.of(context).size.height / 16,
                                    child: new Text(
                                      "${intervalo}",
                                      style: (intervalo == null ||
                                              intervalo == "00:00")
                                          ? TextStyle(
                                              color: Colors.transparent,
                                              fontSize: 12.0)
                                          : TextStyle(
                                              fontSize: 12.0,
                                              color: const Color(0xff707070)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                      new Container(
                        height: MediaQuery.of(context).size.height / 16,
                        color: Colors.grey,
                        width: 2,
                      ),
                      Container(
                        color: const Color(0xffF7F7F7),
                        width: (MediaQuery.of(context).size.width / 1.9),
                        child: new Row(
                          children: <Widget>[
                            new GestureDetector(
                              onTap: (item.listaOcorrencias.length == 0)
                                  ? () {}
                                  : () {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              DialogOcorrencia(
                                                listaOcorrenciaViewModel:
                                                    item.listaOcorrencias,
                                              ));
                                    },
                              child: new Container(
                                padding: EdgeInsets.only(left: 2.0, right: 2.0),
                                child: (item.listaOcorrencias.length == 0)
                                    ? new Icon(
                                        Icons.brightness_1,
                                        color: Colors.transparent,
                                        size: 12.0,
                                      )
                                    : new Icon(
                                        Icons.brightness_1,
                                        color: const Color(0xffFFB520),
                                        size: 12.0,
                                      ),
                              ),
                            ),
                            new Container(
                              width: (MediaQuery.of(context).size.width / 2.1),
                              height: MediaQuery.of(context).size.height / 16,
                              child: new ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: (item.listaBatidas == null)
                                      ? 0
                                      : item.listaBatidas.length,
                                  itemBuilder: (context, index) => new Row(
                                        children: <Widget>[
                                          (item.listaBatidas[index].valida ==
                                                  false)
                                              ? (_view.showInvalida == false)
                                                  ? new Container()
                                                  : new Row(
                                                      children: <Widget>[
                                                        _textInvalida(
                                                            index,
                                                            item.listaBatidas[
                                                                index]),
                                                        new Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 3.0),
                                                          color: Colors.grey,
                                                          width: 1.0,
                                                          height: 15.0,
                                                        ),
                                                      ],
                                                    )
                                              : new Row(
                                                  children: <Widget>[
                                                    _text(
                                                        index,
                                                        item.listaBatidas[
                                                            index]),
                                                    new Container(
                                                      margin: EdgeInsets.only(
                                                          left: 3.0),
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                      height: 15.0,
                                                    ),
                                                  ],
                                                )
                                        ],
                                      )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ))
        : new Container(
            child: new Column(children: <Widget>[
            new Container(
              decoration: (_view.diaAtual(item.data) == true)
                  ? BoxDecoration(
                      border: Border.all(
                          width: 2.0, color: const Color(0xff2BBAB4)))
                  : BoxDecoration(),
              child: new Row(
                children: <Widget>[
                  (item.tOuF == "F")
                      ? new Container(
                          color: const Color(0xffF7F7F7),
                          width: (_view.diaAtual(item.data) == true)
                              ? ((MediaQuery.of(context).size.width / 6.5) - 3)
                              : ((MediaQuery.of(context).size.width / 6.5) - 1),
                          child: new Row(
                            children: <Widget>[
                              new Container(
                                width: (_view.diaAtual(item.data) == true)
                                    ? (MediaQuery.of(context).size.width / 30) -
                                        2
                                    : MediaQuery.of(context).size.width / 30,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(left: 2.0, right: 2.0),
                                height: MediaQuery.of(context).size.height / 16,
                                color: corTouf,
                                child: (item.tOuF != null)
                                    ? new Text(item.tOuF)
                                    : new Text(""),
                              ),
                              new Expanded(
                                  child: new Container(
                                height: MediaQuery.of(context).size.height / 16,
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Container(
                                      child: new Text(
                                        "${_view.formatarData(item.data) ?? ""}",
                                        style: TextStyle(
                                            color: const Color(0xff707070)),
                                      ),
                                    ),
                                    new Container(
                                      child: (item.data == null)
                                          ? new Text("")
                                          : new Text(
                                              _view.montarDiasSemana(item.data),
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xff707070),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                        )
                      : new Container(
                          color: const Color(0xffE6E6E6),
                          width: (_view.diaAtual(item.data) == true)
                              ? ((MediaQuery.of(context).size.width / 6.5) - 3)
                              : ((MediaQuery.of(context).size.width / 6.5) - 1),
                          child: new Row(
                            children: <Widget>[
                              new Container(
                                width: (_view.diaAtual(item.data) == true)
                                    ? (MediaQuery.of(context).size.width / 30) -
                                        2
                                    : MediaQuery.of(context).size.width / 30,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(left: 2.0, right: 2.0),
                                height: MediaQuery.of(context).size.height / 16,
                                color: corTouf,
                                child: (item.tOuF != null)
                                    ? new Text(
                                        item.tOuF,
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : new Text(""),
                              ),
                              new Expanded(
                                  child: new Container(
                                height: MediaQuery.of(context).size.height / 16,
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Container(
                                      child: new Text(
                                        "${_view.formatarData(item.data) ?? ""}",
                                        style: TextStyle(
                                            color: const Color(0xff707070)),
                                      ),
                                    ),
                                    new Container(
                                      child: (item.data == null)
                                          ? new Text("")
                                          : new Text(
                                              _view.montarDiasSemana(item.data),
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xff707070),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                  new Container(
                    height: MediaQuery.of(context).size.height / 16,
                    color: Colors.grey,
                    width: 1,
                  ),
                  (item.tOuF == "F")
                      ? new Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height / 16,
                          width: MediaQuery.of(context).size.width / 3.5,
                          color: const Color(0xffF7F7F7),
                          child: new Text(
                            "FOLGA",
                            style: TextStyle(
                                color: const Color(0xff707070),
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      : Container(
                          color: const Color(0xffE6E6E6),
                          width: MediaQuery.of(context).size.width / 3.5,
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              new Container(
                                alignment: Alignment.center,
                                height: MediaQuery.of(context).size.height / 16,
                                child: new Text(
                                  "${entrada}",
                                  style: (entrada == null || entrada == "00:00")
                                      ? TextStyle(
                                          color: Colors.transparent,
                                          fontSize: 12.0)
                                      : TextStyle(
                                          fontSize: 12.0,
                                          color: const Color(0xff707070),
                                          fontWeight: FontWeight.w600),
                                ),
                              ),
                              new Container(
                                color: Colors.grey,
                                width: 1,
                                height: MediaQuery.of(context).size.height / 50,
                              ),
                              new Container(
                                alignment: Alignment.center,
                                height: MediaQuery.of(context).size.height / 16,
                                child: new Text(
                                  "${saida}",
                                  style: (saida == null || saida == "00:00")
                                      ? TextStyle(
                                          color: Colors.transparent,
                                          fontSize: 12.0)
                                      : TextStyle(
                                          fontSize: 12.0,
                                          color: const Color(0xff707070),
                                          fontWeight: FontWeight.w600),
                                ),
                              ),
                              new Container(
                                alignment: Alignment.center,
                                height: MediaQuery.of(context).size.height / 16,
                                child: new Text(
                                  "(${intervalo})",
                                  style: (intervalo == null ||
                                          intervalo == "00:00")
                                      ? TextStyle(
                                          color: Colors.transparent,
                                          fontSize: 10.0)
                                      : TextStyle(
                                          fontSize: 10.0,
                                          color: const Color(0xff707070)),
                                ),
                              )
                            ],
                          ),
                        ),
                  new Container(
                    height: MediaQuery.of(context).size.height / 16,
                    color: Colors.grey,
                    width: 2,
                  ),
                  Container(
                    color: const Color(0xffF7F7F7),
                    width: (MediaQuery.of(context).size.width / 1.9),
                    child: new Row(
                      children: <Widget>[
                        new GestureDetector(
                          onTap: (item.listaOcorrencias.length == 0)
                              ? () {}
                              : () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => DialogOcorrencia(
                                            listaOcorrenciaViewModel:
                                                item.listaOcorrencias,
                                          ));
                                },
                          child: new Container(
                            padding: EdgeInsets.only(left: 2.0, right: 2.0),
                            child: (item.listaOcorrencias.length == 0)
                                ? new Icon(
                                    Icons.brightness_1,
                                    color: Colors.transparent,
                                    size: 12.0,
                                  )
                                : new Icon(
                                    Icons.brightness_1,
                                    color: const Color(0xffFFB520),
                                    size: 12.0,
                                  ),
                          ),
                        ),
                        new Container(
                            width: (MediaQuery.of(context).size.width / 2.1),
                            height: MediaQuery.of(context).size.height / 16,
                            child: new ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: (item.listaBatidas == null)
                                    ? 0
                                    : item.listaBatidas.length,
                                itemBuilder: (context, index) => new Row(
                                      children: <Widget>[
                                        (item.listaBatidas[index].valida ==
                                                false)
                                            ? (_view.showInvalida == false)
                                                ? new Container()
                                                : new Row(
                                                    children: <Widget>[
                                                      _textInvalida(
                                                          index,
                                                          item.listaBatidas[
                                                              index]),
                                                      new Container(
                                                        margin: EdgeInsets.only(
                                                            left: 3.0),
                                                        color: Colors.grey,
                                                        width: 1.0,
                                                        height: 15.0,
                                                      ),
                                                    ],
                                                  )
                                            : new Row(
                                                children: <Widget>[
                                                  _text(index,
                                                      item.listaBatidas[index]),
                                                  new Container(
                                                    margin: EdgeInsets.only(
                                                        left: 3.0),
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                    height: 15.0,
                                                  ),
                                                ],
                                              )
                                      ],
                                    )))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]));
  }

  Widget _text(int index, ZBatidaViewModel batida) {
    var hora = _view.converterParaHoraMinutoString(batida?.dataEnvio);

    return new GestureDetector(
      onTap: widget.onTapDialogBatida,
      child: new Container(
        margin: EdgeInsets.only(left: 3.0),
        child: new Row(
          children: <Widget>[
            new Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: new Text(
                "${hora}",
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textInvalida(int index, ZBatidaViewModel batida) {
    var hora = _view.converterParaHoraMinutoString(batida?.dataEnvio);

    return new GestureDetector(
      onTap: widget.onTapDialogBatida,
      child: new Container(
        margin: EdgeInsets.only(left: 3.0),
        child: new Row(
          children: <Widget>[
            new Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: new Text(
                "${hora}",
                style: TextStyle(
                    fontSize: 12.0,
                    decoration: TextDecoration.lineThrough,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
