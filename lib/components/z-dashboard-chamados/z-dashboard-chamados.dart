import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/historico-view-model.dart';

class Dashboard extends StatefulWidget {
  List<HistoricoViewModel>? listaHistoricoPendentes = [];
  List<HistoricoViewModel>? listaHistoricoAndamento = [];
  void Function(String)? onTap;
   List<HistoricoViewModel>? listaHistoricoAbertosEPendendes = [];
  var refresh;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  State<StatefulWidget> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> with TickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;

  late Animation animationPendentes;
  late AnimationController animationControllerPendentes;

  late Animation animationAndamento;
  late AnimationController animationControllerAndamento;

  final pageController = PageController();
  final pageControllerChamados = PageController();

  bool totalCh = true;
  bool pendentes = false;
  bool andamento = false;

  Color backgroundColorTotalCham = Color(0xff2bbab4);
  Color backgroundColorChPen = Colors.white;
  Color backgroundColorChAnda = Colors.white;

  Color textNumbTotal = Colors.white;
  Color textNumbPend = Colors.black;
  Color textNumbAnd = Colors.black;

  Color textWordTotal = Colors.white;
  Color textWordPend = Color(0xff999999);
  Color textWordAnda = Color(0xff999999);

  Color backgroundHome = Color(0xff2bbab4);
  Color backgroundChamdos = Colors.white;
  Color backgroundOutros = Colors.white;

  String caminhoOnde = "";
  String caminhoOque = "";
  String caminhoPorque = "";

  Color colorHomeIconText = Colors.white;
  Color colorChamadoIconText = Color(0xffC7C7CC);
  Color colorOutrosIconText = Color(0xffC7C7CC);

  bool carregouList = false;
  bool carregouListPend = false;
  bool carregouListAnd = false;

  bool teste = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

    animationControllerPendentes = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

    animationControllerAndamento = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xffEFEFF4),
      body: _buildbody(),
    );
  }

  Widget _buildbody() {
    return new PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: pageController,
      children: <Widget>[
        _buildCorpo(),
      ],
    );
  }

  Widget _buildCorpo() {
    return new Column(
      children: <Widget>[_buildDash(), escolherTipoChamado()],
    );
  }

  Widget escolherTipoChamado() {
    if (totalCh == true && pendentes == false && andamento == false) {
      return _buildListaChamados();
    } else if (totalCh == false && pendentes == true && andamento == false) {
      return _buildListaChamadosPendentes();
    } else {
      return _buildListaChamadosAndamento();
    }
  }

  Widget _buildDash() {
    return new Material(
        elevation: 6,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.only(
                bottomLeft: const Radius.circular(30.0),
                bottomRight: const Radius.circular(30.0))),
        color: Color(0xff2BBAB4),
        child: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.only(top: 40, bottom: 10),
                  child: new Text(
                    "DASHBOARD",
                    style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                )
              ],
            ),
            new Container(
              margin: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
              height: 0.5,
              width: double.infinity,
              color: Colors.white,
            ),
            _buildTabDash()
          ],
        ));
  }

  Widget _buildListaChamados() {
    if (teste == true) {
      if (widget.listaHistoricoAbertosEPendendes!.length != 0) {
        return new Expanded(
            child: SmartRefresher(
          enablePullDown: true,
          controller: widget.refreshController,
          onRefresh: () async {
            await pullToRefresh();
          },
          header: ClassicHeader(
            idleText: "Puxe para atualizar",
            releaseText: "Solte para atualizar",
            refreshingText: "Atualizando",
            completeText: "Sua lista está atualizada!",
            iconPos: IconPosition.right,
          ),
          child: new ListView.builder(
              itemCount: widget.listaHistoricoAbertosEPendendes!.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 60),
              itemBuilder: (context, index) {
                List<String> onde = [];
                List<String> oque = [];
                List<String> porque = [];
                montarCaminho(
                    widget
                        .listaHistoricoAbertosEPendendes![index].caminhoAmbiente,
                    widget.listaHistoricoAbertosEPendendes![index]
                        .caminhoTipoEquipamento,
                    widget.listaHistoricoAbertosEPendendes![index]
                        .caminhoTipoProblema,
                    onde,
                    oque,
                    porque);
                return new Stack(
                  children: <Widget>[
                    new Card(
                      elevation: 1.5,
                      margin:
                          const EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: new Container(
                          margin: const EdgeInsets.only(),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: new Container(
                            margin: const EdgeInsets.only(left: 8),
                            child: new ListTile(
                              dense: true,
                              contentPadding: const EdgeInsets.all(0),
                              trailing: Icon(Icons.keyboard_arrow_right,
                                  size: MainStyle.get(context).iconSizePadrao),
                              title: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Container(
                                        height: 24.0,
                                        width: 24.0,
                                        decoration: new BoxDecoration(
                                          image: DecorationImage(
                                            image: new AssetImage(
                                                'assets/calendario.png'),
                                            fit: BoxFit.fill,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      new Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.only(left: 8),
                                        child: new Text(
                                          "${widget.listaHistoricoAbertosEPendendes![index].dataAbertura!.split("-")[2].substring(0, 2)}/${widget.listaHistoricoAbertosEPendendes![index].dataAbertura!.split("-")[1]}/${widget.listaHistoricoAbertosEPendendes![index].dataAbertura!.split("-")[0]}",
                                          style: new TextStyle(
                                              color: Color(0xff707070),
                                              //fontWeight: FontWeight.w500,fontSize: 10
                                              fontWeight: FontWeight.w500,
                                              fontSize: MainStyle.get(context)
                                                  .fontSizePadrao),
                                        ),
                                      ),
                                      new Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.only(left: 8),
                                        child: new Text(
                                          "-",
                                          style: new TextStyle(
                                              color: Color(0xff707070),
                                              //fontWeight: FontWeight.w500,fontSize: 10
                                              fontWeight: FontWeight.w500,
                                              fontSize: MainStyle.get(context)
                                                  .fontSizePadrao),
                                        ),
                                      ),
                                      new Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.only(left: 8),
                                        child: new Text(
                                          "${widget.listaHistoricoAbertosEPendendes![index].dataAbertura!.split("T")[1].substring(0, 5)}",
                                          style: new TextStyle(
                                              color: Color(0xff707070),
                                              //fontWeight: FontWeight.w500,fontSize: 10
                                              fontWeight: FontWeight.w500,
                                              fontSize: MainStyle.get(context)
                                                  .fontSizePadrao),
                                        ),
                                      )
                                    ],
                                  ),
                                  new Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Container(
                                        margin: const EdgeInsets.only(left: 8),
                                        alignment: Alignment.center,
                                        child: new Icon(
                                          Icons.brightness_1,
                                          color: (widget
                                                      .listaHistoricoAbertosEPendendes![
                                                          index]
                                                      .status ==
                                                  "Em Andamento")
                                              ? Color(0xff1AC15D)
                                              : Color(0xffFFB520),
                                          size: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              subtitle: new Row(
                                children: <Widget>[
                                  new Expanded(
                                      flex: 8,
                                      child: new Icon(
                                        Icons.label,
                                        color: Colors.grey.withOpacity(0.7),
                                      )),
                                  new Expanded(
                                    flex: 92,
                                    child: SizedBox(
                                        height: 22.0,
                                        child: new ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: <Widget>[
                                            (caminhoOnde != null)
                                                ? new Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 8),
                                                    child: new Material(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      color: Color(0xff999999),
                                                      child: new Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            left: 8,
                                                            right: 8,
                                                            top: 4,
                                                            bottom: 4),
                                                        child: new Text(
                                                          caminhoOnde,
                                                          style: new TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: MainStyle
                                                                      .get(
                                                                          context)
                                                                  .subTitleFontSize),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : new Container(),
                                            (caminhoOque != null)
                                                ? new Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 8),
                                                    child: new Material(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      color: Color(0xff999999),
                                                      child: new Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            left: 8,
                                                            right: 8,
                                                            top: 4,
                                                            bottom: 4),
                                                        child: new Text(
                                                          caminhoOque,
                                                          style: new TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: MainStyle
                                                                      .get(
                                                                          context)
                                                                  .subTitleFontSize),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : new Container(),
                                            (caminhoPorque != null)
                                                ? new Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 8),
                                                    child: new Material(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      color: Color(0xff999999),
                                                      child: new Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            left: 8,
                                                            right: 8,
                                                            top: 4,
                                                            bottom: 4),
                                                        child: new Text(
                                                          caminhoPorque,
                                                          style: new TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: MainStyle
                                                                      .get(
                                                                          context)
                                                                  .subTitleFontSize),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : new Container()
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                              //subtitle: new Container(),
                            ),
                          )),
                    ),
                    new Positioned.fill(
                        child: new Container(
                      margin:
                          const EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: new Material(
                          color: Colors.transparent,
                          child: new InkWell(
                            borderRadius:
                                new BorderRadius.all(Radius.circular(5)),
                            onTap: () {
                              Future.delayed(new Duration(milliseconds: 200),
                                  () {
                                widget.onTap!(widget
                                    .listaHistoricoAbertosEPendendes![index]
                                    .idSolicitacao!);
                              });
                            },
                          )),
                    ))
                  ],
                );
              }),
        ));
      } else {
        return new Container(
          margin: const EdgeInsets.only(top: 26, left: 16, right: 16),
          child: new Card(
              child: new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: new Text(
                      "Você não possui nenhum ",
                      style: new TextStyle(
                          color: Color(0xff999999),
                          fontSize: (MediaQuery.of(context).size.width <= 359)
                              ? 12
                              : 14),
                    ),
                  ),
                  new Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: new Text(
                        "chamado em aberto.",
                        style: new TextStyle(
                            color: Color(0xff999999),
                            fontWeight: FontWeight.w500,
                            fontSize: (MediaQuery.of(context).size.width <= 359)
                                ? 12
                                : 14),
                      ))
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.only(top: 4, bottom: 10),
                    child: new Text(
                      "Clique no botão abaixo para abrir um novo chamado.",
                      style: new TextStyle(
                          color: Color(0xff999999),
                          fontSize: (MediaQuery.of(context).size.width <= 359)
                              ? 10
                              : 12),
                    ),
                  )
                ],
              )
            ],
          )),
        );
      }
    } else {
      return new Expanded(
          child: SmartRefresher(
        enablePullDown: true,
        controller: widget.refreshController,
        onRefresh: () async {
          await pullToRefresh();
        },
        header: ClassicHeader(
          idleText: "Puxe para atualizar",
          releaseText: "Solte para atualizar",
          refreshingText: "Atualizando",
          completeText: "Sua lista está atualizada!",
          iconPos: IconPosition.right,
        ),
        child: new ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return new Card(
                elevation: 1.5,
                margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
                child: new Container(
                    margin: const EdgeInsets.only(),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: new Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: new ListTile(
                        dense: true,
                        onTap: () {},
                        contentPadding: const EdgeInsets.all(0),
                        trailing: Icon(Icons.keyboard_arrow_right,
                            size: MainStyle.get(context).iconSizePadrao),
                        title: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                  height: 24.0,
                                  width: 24.0,
                                  decoration: new BoxDecoration(
                                    image: DecorationImage(
                                      image: new AssetImage(
                                          'assets/calendario.png'),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                new Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(left: 8),
                                    child: SizedBox(
                                      child: Shimmer.fromColors(
                                        baseColor: Color(0xffe6e6e6),
                                        highlightColor: Colors.white,
                                        child: new Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffe6e6e6),
                                            border: new Border.all(
                                                color: Colors.white, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                          ),
                                          //margin: EdgeInsets.only(left: 16, bottom: 16),
                                          height: 20,
                                          width: 120,
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    margin: const EdgeInsets.only(left: 8),
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      child: Shimmer.fromColors(
                                        baseColor: Color(0xffe6e6e6),
                                        highlightColor: Colors.white,
                                        child: new Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffe6e6e6),
                                            border: new Border.all(
                                                color: Colors.white, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                          ),
                                          // margin: EdgeInsets.only(left: 16, bottom: 16),
                                          height: 14,
                                          width: 14,
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                        subtitle: new Row(
                          children: <Widget>[
                            new Expanded(
                                flex: 1,
                                child: new Icon(
                                  Icons.label,
                                  color: Colors.grey.withOpacity(0.7),
                                )),
                            new Expanded(
                                flex: 9,
                                child: SizedBox(
                                  child: Shimmer.fromColors(
                                    baseColor: Color(0xffe6e6e6),
                                    highlightColor: Colors.white,
                                    child: new Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffe6e6e6),
                                        border: new Border.all(
                                            color: Colors.white, width: 2),
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      // margin: EdgeInsets.only(left: 16, bottom: 16),
                                      height: 20,
                                      width: 120,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        //subtitle: new Container(),
                      ),
                    )),
              );
            }),
      ));
    }
  }

  Widget _buildTabDash() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(const Radius.circular(6)),
          ),
          child: new Row(
            children: <Widget>[
              _buildTotalChamadosDash(),
              _buildChamadosPendentesDash(),
              _buildChamadosAndamentoDash()
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTotalChamadosDash() {
    return new InkWell(
      onTap: () {
        totalDeCham();
      },
      child: new AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: 90,
        height: 90,
        decoration: new BoxDecoration(
          color: backgroundColorTotalCham,
          borderRadius: BorderRadius.all(const Radius.circular(6)),
        ),
        margin: const EdgeInsets.only(left: 4, bottom: 4, top: 4),
        child: new Column(
          children: <Widget>[
            new Stack(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedBuilder(
                        animation: animationController,
                        builder: (BuildContext context,  child) {
                          return new Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: (carregouList != false)
                                  ? new Text(
                                      animation.value.toString(),
                                      style: new TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: textNumbTotal),
                                    )
                                  : new Text(
                                      "0",
                                      style: new TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: textNumbTotal),
                                    ));
                        }),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Container(
                        margin: const EdgeInsets.all(4),
                        width: 18,
                        height: 18,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: new Container(
                          margin: const EdgeInsets.all(2),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ))
                  ],
                )
              ],
            ),
            new Container(
              padding:
                  const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
              child: new Text(
                "TOTAL DE\nCHAMADOS",
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize: 10, color: textWordTotal),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChamadosPendentesDash() {
    return new InkWell(
      onTap: () {
        chamPend();
      },
      child: new AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: 90,
        height: 90,
        decoration: new BoxDecoration(
          color: backgroundColorChPen,
          borderRadius: BorderRadius.all(const Radius.circular(6)),
        ),
        margin: const EdgeInsets.only(left: 4, bottom: 4, top: 4, right: 4),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Stack(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedBuilder(
                        animation: animationControllerPendentes,
                        builder: (BuildContext context,  child) {
                          return new Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: (carregouListPend != false)
                                  ? new Text(
                                      animationPendentes.value.toString(),
                                      style: new TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: textNumbPend),
                                    )
                                  : new Text(
                                      "0",
                                      style: new TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: textNumbPend),
                                    ));
                        }),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Container(
                        margin: const EdgeInsets.all(4),
                        width: 18,
                        height: 18,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: new Container(
                          margin: const EdgeInsets.all(2),
                          decoration: new BoxDecoration(
                            color: Color(0xffFFB520),
                            shape: BoxShape.circle,
                          ),
                        ))
                  ],
                )
              ],
            ),
            new Container(
              padding:
                  const EdgeInsets.only(left: 6, right: 6, top: 8, bottom: 8),
              child: new Text(
                "CHAMADOS\nPENDENTES",
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize: 10, color: textWordPend),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChamadosAndamentoDash() {
    return new InkWell(
      onTap: () {
        chamAtendimento();
      },
      child: new AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: 90,
        height: 90,
        decoration: new BoxDecoration(
          color: backgroundColorChAnda,
          borderRadius: BorderRadius.all(const Radius.circular(6)),
        ),
        margin: const EdgeInsets.only(bottom: 4, top: 4, right: 4),
        child: new Column(
          children: <Widget>[
            new Stack(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedBuilder(
                        animation: animationControllerAndamento,
                        builder: (BuildContext context,  child) {
                          return new Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: (carregouListAnd != false)
                                  ? new Text(
                                      animationAndamento.value.toString(),
                                      style: new TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: textNumbAnd),
                                    )
                                  : new Text(
                                      "0",
                                      style: new TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: textNumbAnd),
                                    ));
                        }),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Container(
                        margin: const EdgeInsets.all(4),
                        width: 18,
                        height: 18,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: new Container(
                          margin: const EdgeInsets.all(2),
                          decoration: new BoxDecoration(
                            color: Color(0xff1AC15D),
                            shape: BoxShape.circle,
                          ),
                        ))
                  ],
                )
              ],
            ),
            new Container(
              padding:
                  const EdgeInsets.only(left: 6, right: 6, top: 8, bottom: 8),
              child: new Text(
                "CHAMADOS EM\nANDAMENTO",
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize: 10, color: textWordAnda),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListaChamadosPendentes() {
    if (teste == true) {
      if (widget.listaHistoricoPendentes!.length > 0) {
        return new Expanded(
          child: SmartRefresher(
              enablePullDown: true,
              controller: widget.refreshController,
              onRefresh: () async {
                await pullToRefresh();
              },
              header: ClassicHeader(
                idleText: "Puxe para atualizar",
                releaseText: "Solte para atualizar",
                refreshingText: "Atualizando",
                completeText: "Sua lista está atualizada!",
                iconPos: IconPosition.right,
              ),
              child: new ListView.builder(
                  itemCount: widget.listaHistoricoPendentes!.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 60),
                  itemBuilder: (context, index) {
                    List<String> onde = [];
                    List<String> oque = [];
                    List<String> porque = [];
                    montarCaminho(
                        widget.listaHistoricoPendentes![index].caminhoAmbiente,
                        widget.listaHistoricoPendentes![index]
                            .caminhoTipoEquipamento,
                        widget
                            .listaHistoricoPendentes![index].caminhoTipoProblema,
                        onde,
                        oque,
                        porque);
                    return new Stack(
                      children: <Widget>[
                        new Card(
                          elevation: 1.5,
                          margin: const EdgeInsets.only(
                              left: 16, right: 16, top: 8),
                          child: new Container(
                              margin: const EdgeInsets.only(),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: new Container(
                                margin: const EdgeInsets.only(left: 8),
                                child: new ListTile(
                                  dense: true,
                                  contentPadding: const EdgeInsets.all(0),
                                  trailing: Icon(Icons.keyboard_arrow_right,
                                      size: MainStyle.get(context)
                                          .iconSizePadrao),
                                  title: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          new Container(
                                            height: 24.0,
                                            width: 24.0,
                                            decoration: new BoxDecoration(
                                              image: DecorationImage(
                                                image: new AssetImage(
                                                    'assets/calendario.png'),
                                                fit: BoxFit.fill,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          new Container(
                                            alignment: Alignment.center,
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: new Text(
                                              "${widget.listaHistoricoPendentes![index].dataAbertura!.split("-")[2].substring(0, 2)}/${widget.listaHistoricoPendentes![index].dataAbertura!.split("-")[1]}/${widget.listaHistoricoPendentes![index].dataAbertura!.split("-")[0]}",
                                              style: new TextStyle(
                                                  color: Color(0xff707070),
                                                  //fontWeight: FontWeight.w500,fontSize: 10
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      MainStyle.get(context)
                                                          .fontSizePadrao),
                                            ),
                                          ),
                                          new Container(
                                            alignment: Alignment.center,
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: new Text(
                                              "-",
                                              style: new TextStyle(
                                                  color: Color(0xff707070),
                                                  //fontWeight: FontWeight.w500,fontSize: 10
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      MainStyle.get(context)
                                                          .fontSizePadrao),
                                            ),
                                          ),
                                          new Container(
                                            alignment: Alignment.center,
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: new Text(
                                              "${widget.listaHistoricoPendentes![index].dataAbertura!.split("T")[1].substring(0, 5)}",
                                              style: new TextStyle(
                                                  color: Color(0xff707070),
                                                  //fontWeight: FontWeight.w500,fontSize: 10
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      MainStyle.get(context)
                                                          .fontSizePadrao),
                                            ),
                                          ),
                                        ],
                                      ),
                                      new Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          new Container(
                                            margin:
                                                const EdgeInsets.only(left: 8),
                                            alignment: Alignment.center,
                                            child: new Icon(
                                              Icons.brightness_1,
                                              color: (widget
                                                          .listaHistoricoPendentes![
                                                              index]
                                                          .status ==
                                                      "Em Andamento")
                                                  ? Color(0xff1AC15D)
                                                  : Color(0xffFFB520),
                                              size: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  subtitle: new Row(
                                    children: <Widget>[
                                      new Expanded(
                                          flex: 8,
                                          child: new Icon(
                                            Icons.label,
                                            color: Colors.grey.withOpacity(0.7),
                                          )),
                                      new Expanded(
                                        flex: 92,
                                        child: SizedBox(
                                            height: 22.0,
                                            child: new ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: <Widget>[
                                                (caminhoOnde != null)
                                                    ? new Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 8),
                                                        child: new Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          color:
                                                              Color(0xff999999),
                                                          child: new Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8,
                                                                    right: 8,
                                                                    top: 4,
                                                                    bottom: 4),
                                                            child: new Text(
                                                              caminhoOnde,
                                                              style: new TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: MainStyle
                                                                          .get(
                                                                              context)
                                                                      .subTitleFontSize),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : new Container(),
                                                (caminhoOque != null)
                                                    ? new Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 8),
                                                        child: new Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          color:
                                                              Color(0xff999999),
                                                          child: new Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8,
                                                                    right: 8,
                                                                    top: 4,
                                                                    bottom: 4),
                                                            child: new Text(
                                                              caminhoOque,
                                                              style: new TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: MainStyle
                                                                          .get(
                                                                              context)
                                                                      .subTitleFontSize),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : new Container(),
                                                (caminhoPorque != null)
                                                    ? new Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 8),
                                                        child: new Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          color:
                                                              Color(0xff999999),
                                                          child: new Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8,
                                                                    right: 8,
                                                                    top: 4,
                                                                    bottom: 4),
                                                            child: new Text(
                                                              caminhoPorque,
                                                              style: new TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: MainStyle
                                                                          .get(
                                                                              context)
                                                                      .subTitleFontSize),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : new Container()
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                  //subtitle: new Container(),
                                ),
                              )),
                        ),
                        new Positioned.fill(
                            child: new Container(
                          margin: const EdgeInsets.only(
                              left: 16, right: 16, top: 8),
                          child: new Material(
                              color: Colors.transparent,
                              child: new InkWell(
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(5)),
                                onTap: () {
                                  Future.delayed(
                                      new Duration(milliseconds: 200), () {
                                    widget.onTap!(widget
                                        .listaHistoricoAbertosEPendendes![index]
                                        .idSolicitacao!);
                                  });
                                },
                              )),
                        ))
                      ],
                    );
                  })),
        );
      } else {
        return new Container(
          margin:
              const EdgeInsets.only(top: 26, left: 16, right: 16, bottom: 26),
          child: new Card(
              child: new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: new Text(
                      "Você não possui nenhum ",
                      style: new TextStyle(
                          color: Color(0xff999999),
                          fontSize: (MediaQuery.of(context).size.width <= 359)
                              ? 12
                              : 14),
                    ),
                  ),
                  new Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: new Text(
                        "chamado pendente.",
                        style: new TextStyle(
                            color: Color(0xff999999),
                            fontWeight: FontWeight.w500,
                            fontSize: (MediaQuery.of(context).size.width <= 359)
                                ? 12
                                : 14),
                      ))
                ],
              ),
            ],
          )),
        );
      }
    } else {
      return new Expanded(
          child: SmartRefresher(
        enablePullDown: true,
        controller: widget.refreshController,
        onRefresh: () async {
          await pullToRefresh();
        },
        header: ClassicHeader(
          idleText: "Puxe para atualizar",
          releaseText: "Solte para atualizar",
          refreshingText: "Atualizando",
          completeText: "Sua lista está atualizada!",
          iconPos: IconPosition.right,
        ),
        child: new ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return new Card(
                elevation: 1.5,
                margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
                child: new Container(
                    margin: const EdgeInsets.only(),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: new Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: new ListTile(
                        dense: true,
                        onTap: () {},
                        contentPadding: const EdgeInsets.all(0),
                        trailing: Icon(Icons.keyboard_arrow_right,
                            size: MainStyle.get(context).iconSizePadrao),
                        title: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                  height: 24.0,
                                  width: 24.0,
                                  decoration: new BoxDecoration(
                                    image: DecorationImage(
                                      image: new AssetImage(
                                          'assets/calendario.png'),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                new Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(left: 8),
                                    child: SizedBox(
                                      child: Shimmer.fromColors(
                                        baseColor: Color(0xffe6e6e6),
                                        highlightColor: Colors.white,
                                        child: new Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffe6e6e6),
                                            border: new Border.all(
                                                color: Colors.white, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                          ),
                                          //margin: EdgeInsets.only(left: 16, bottom: 16),
                                          height: 20,
                                          width: 120,
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    margin: const EdgeInsets.only(left: 8),
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      child: Shimmer.fromColors(
                                        baseColor: Color(0xffe6e6e6),
                                        highlightColor: Colors.white,
                                        child: new Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffe6e6e6),
                                            border: new Border.all(
                                                color: Colors.white, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                          ),
                                          // margin: EdgeInsets.only(left: 16, bottom: 16),
                                          height: 14,
                                          width: 14,
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                        subtitle: new Row(
                          children: <Widget>[
                            new Expanded(
                                flex: 1,
                                child: new Icon(
                                  Icons.label,
                                  color: Colors.grey.withOpacity(0.7),
                                )),
                            new Expanded(
                                flex: 9,
                                child: SizedBox(
                                  child: Shimmer.fromColors(
                                    baseColor: Color(0xffe6e6e6),
                                    highlightColor: Colors.white,
                                    child: new Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffe6e6e6),
                                        border: new Border.all(
                                            color: Colors.white, width: 2),
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      // margin: EdgeInsets.only(left: 16, bottom: 16),
                                      height: 20,
                                      width: 120,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        //subtitle: new Container(),
                      ),
                    )),
              );
            }),
      ));
    }
  }

  Widget _buildListaChamadosAndamento() {
    if (teste == true) {
      if (widget.listaHistoricoAndamento!.length > 0) {
        return new Expanded(
            child: SmartRefresher(
                enablePullDown: true,
                controller: widget.refreshController,
                onRefresh: () async {
                  await pullToRefresh();
                },
                header: ClassicHeader(
                  idleText: "Puxe para atualizar",
                  releaseText: "Solte para atualizar",
                  refreshingText: "Atualizando",
                  completeText: "Sua lista está atualizada!",
                  iconPos: IconPosition.right,
                ),
                child: new ListView.builder(
                  itemCount: widget.listaHistoricoAndamento!.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 60),
                  itemBuilder: (context, index) {
                    List<String> onde = [];
                    List<String> oque = [];
                    List<String> porque = [];
                    montarCaminho(
                        widget.listaHistoricoAndamento![index].caminhoAmbiente,
                        widget.listaHistoricoAndamento![index]
                            .caminhoTipoEquipamento,
                        widget
                            .listaHistoricoAndamento![index].caminhoTipoProblema,
                        onde,
                        oque,
                        porque);
                    return new Stack(
                      children: <Widget>[
                        new Card(
                          elevation: 1.5,
                          margin: const EdgeInsets.only(
                              left: 16, right: 16, top: 8),
                          child: new Container(
                              margin: const EdgeInsets.only(),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: new Container(
                                margin: const EdgeInsets.only(left: 8),
                                child: new ListTile(
                                  dense: true,
                                  contentPadding: const EdgeInsets.all(0),
                                  trailing: Icon(Icons.keyboard_arrow_right,
                                      size: MainStyle.get(context)
                                          .iconSizePadrao),
                                  title: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          new Container(
                                            height: 24.0,
                                            width: 24.0,
                                            decoration: new BoxDecoration(
                                              image: DecorationImage(
                                                image: new AssetImage(
                                                    'assets/calendario.png'),
                                                fit: BoxFit.fill,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          new Container(
                                            alignment: Alignment.center,
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: new Text(
                                              "${widget.listaHistoricoAndamento![index].dataAbertura!.split("-")[2].substring(0, 2)}/${widget.listaHistoricoAndamento![index].dataAbertura!.split("-")[1]}/${widget.listaHistoricoAndamento![index].dataAbertura!.split("-")[0]}",
                                              style: new TextStyle(
                                                  color: Color(0xff707070),
                                                  //fontWeight: FontWeight.w500,fontSize: 10
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      MainStyle.get(context)
                                                          .fontSizePadrao),
                                            ),
                                          ),
                                          new Container(
                                            alignment: Alignment.center,
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: new Text(
                                              "-",
                                              style: new TextStyle(
                                                  color: Color(0xff707070),
                                                  //fontWeight: FontWeight.w500,fontSize: 10
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      MainStyle.get(context)
                                                          .fontSizePadrao),
                                            ),
                                          ),
                                          new Container(
                                            alignment: Alignment.center,
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: new Text(
                                              "${widget.listaHistoricoAndamento![index].dataAbertura!.split("T")[1].substring(0, 5)}",
                                              style: new TextStyle(
                                                  color: Color(0xff707070),
                                                  //fontWeight: FontWeight.w500,fontSize: 10
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      MainStyle.get(context)
                                                          .fontSizePadrao),
                                            ),
                                          ),
                                        ],
                                      ),
                                      new Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          new Container(
                                            margin:
                                                const EdgeInsets.only(left: 8),
                                            alignment: Alignment.center,
                                            child: new Icon(
                                              Icons.brightness_1,
                                              color: (widget
                                                          .listaHistoricoAndamento![
                                                              index]
                                                          .status ==
                                                      "Em Andamento")
                                                  ? Color(0xff1AC15D)
                                                  : Color(0xffFFB520),
                                              size: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  subtitle: new Row(
                                    children: <Widget>[
                                      new Expanded(
                                          flex: 8,
                                          child: new Icon(
                                            Icons.label,
                                            color: Colors.grey.withOpacity(0.7),
                                          )),
                                      new Expanded(
                                        flex: 92,
                                        child: SizedBox(
                                            height: 22.0,
                                            child: new ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: <Widget>[
                                                (caminhoOnde != null)
                                                    ? new Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 8),
                                                        child: new Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          color:
                                                              Color(0xff999999),
                                                          child: new Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8,
                                                                    right: 8,
                                                                    top: 4,
                                                                    bottom: 4),
                                                            child: new Text(
                                                              caminhoOnde,
                                                              style: new TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: MainStyle
                                                                          .get(
                                                                              context)
                                                                      .subTitleFontSize),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : new Container(),
                                                (caminhoOque != null)
                                                    ? new Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 8),
                                                        child: new Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          color:
                                                              Color(0xff999999),
                                                          child: new Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8,
                                                                    right: 8,
                                                                    top: 4,
                                                                    bottom: 4),
                                                            child: new Text(
                                                              caminhoOque,
                                                              style: new TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: MainStyle
                                                                          .get(
                                                                              context)
                                                                      .subTitleFontSize),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : new Container(),
                                                (caminhoPorque != null)
                                                    ? new Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 8),
                                                        child: new Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          color:
                                                              Color(0xff999999),
                                                          child: new Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8,
                                                                    right: 8,
                                                                    top: 4,
                                                                    bottom: 4),
                                                            child: new Text(
                                                              caminhoPorque,
                                                              style: new TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: MainStyle
                                                                          .get(
                                                                              context)
                                                                      .subTitleFontSize),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : new Container()
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                  //subtitle: new Container(),
                                ),
                              )),
                        ),
                        new Positioned.fill(
                            child: new Container(
                          margin: const EdgeInsets.only(
                              left: 16, right: 16, top: 8),
                          child: new Material(
                              color: Colors.transparent,
                              child: new InkWell(
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(5)),
                                onTap: () {
                                  Future.delayed(
                                      new Duration(milliseconds: 200), () {
                                    widget.onTap!(widget
                                        .listaHistoricoAbertosEPendendes![index]
                                        .idSolicitacao!);
                                  });
                                },
                              )),
                        ))
                      ],
                    );
                  },
                )));
      } else {
        return new Container(
          margin: const EdgeInsets.only(top: 26, left: 16, right: 16),
          child: new Card(
              child: new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: new Text(
                      "Você não possui nenhum ",
                      style: new TextStyle(
                          color: Color(0xff999999),
                          fontSize: (MediaQuery.of(context).size.width <= 359)
                              ? 11
                              : 13),
                    ),
                  ),
                  new Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: new Text(
                        "chamado em andamento.",
                        style: new TextStyle(
                            color: Color(0xff999999),
                            fontWeight: FontWeight.w500,
                            fontSize: (MediaQuery.of(context).size.width <= 359)
                                ? 11
                                : 13),
                      ))
                ],
              ),
            ],
          )),
        );
      }
    } else {
      return new Expanded(
          child: SmartRefresher(
        enablePullDown: true,
        controller: widget.refreshController,
        onRefresh: () async {
          await pullToRefresh();
        },
        header: ClassicHeader(
          idleText: "Puxe para atualizar",
          releaseText: "Solte para atualizar",
          refreshingText: "Atualizando",
          completeText: "Sua lista está atualizada!",
          iconPos: IconPosition.right,
        ),
        child: new ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return new Card(
                elevation: 1.5,
                margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
                child: new Container(
                    margin: const EdgeInsets.only(),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: new Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: new ListTile(
                        dense: true,
                        onTap: () {},
                        contentPadding: const EdgeInsets.all(0),
                        trailing: Icon(Icons.keyboard_arrow_right,
                            size: MainStyle.get(context).iconSizePadrao),
                        title: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                  height: 24.0,
                                  width: 24.0,
                                  decoration: new BoxDecoration(
                                    image: DecorationImage(
                                      image: new AssetImage(
                                          'assets/calendario.png'),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                new Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(left: 8),
                                    child: SizedBox(
                                      child: Shimmer.fromColors(
                                        baseColor: Color(0xffe6e6e6),
                                        highlightColor: Colors.white,
                                        child: new Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffe6e6e6),
                                            border: new Border.all(
                                                color: Colors.white, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                          ),
                                          //margin: EdgeInsets.only(left: 16, bottom: 16),
                                          height: 20,
                                          width: 120,
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    margin: const EdgeInsets.only(left: 8),
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      child: Shimmer.fromColors(
                                        baseColor: Color(0xffe6e6e6),
                                        highlightColor: Colors.white,
                                        child: new Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffe6e6e6),
                                            border: new Border.all(
                                                color: Colors.white, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                          ),
                                          // margin: EdgeInsets.only(left: 16, bottom: 16),
                                          height: 14,
                                          width: 14,
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                        subtitle: new Row(
                          children: <Widget>[
                            new Expanded(
                                flex: 1,
                                child: new Icon(
                                  Icons.label,
                                  color: Colors.grey.withOpacity(0.7),
                                )),
                            new Expanded(
                                flex: 9,
                                child: SizedBox(
                                  child: Shimmer.fromColors(
                                    baseColor: Color(0xffe6e6e6),
                                    highlightColor: Colors.white,
                                    child: new Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffe6e6e6),
                                        border: new Border.all(
                                            color: Colors.white, width: 2),
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      // margin: EdgeInsets.only(left: 16, bottom: 16),
                                      height: 20,
                                      width: 120,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        //subtitle: new Container(),
                      ),
                    )),
              );
            }),
      ));
    }
  }

  void montarCaminho(
      String? onde,
      String? oque,
      String? porque,
      List<String>? listaOnde,
      List<String>? listaOque,
      List<String>? listaPorque) {
    int tamanhoOnde = 0;
    int tamanhoOque = 0;
    int tamanhoPorque = 0;
    if (onde != null && onde.contains("|")) {
      tamanhoOnde = onde.split("|").length;
      for (int i = 0; i < tamanhoOnde; i++) {
        listaOnde!.add(onde.split("|")[i]);
      }
      caminhoOnde = listaOnde!.first;
    } else {
      caminhoOnde = onde!;
    }
    if (oque != null && oque.contains("|")) {
      tamanhoOque = oque.split("|").length;
      for (int i = 0; i < tamanhoOque; i++) {
        listaOque!.add(oque.split("|")[i]);
      }
      caminhoOque = listaOque!.first;
    } else {
      caminhoOque = oque!;
    }
    if (porque != null && porque.contains("|")) {
      tamanhoPorque = porque.split("|").length;
      for (int i = 0; i < tamanhoPorque; i++) {
        listaPorque!.add(porque.split("|")[i]);
      }
      caminhoPorque = listaPorque!.first;
    } else {
      caminhoPorque = porque!;
    }
  }

  void totalDeCham() {
    setState(() {
      backgroundColorTotalCham = Color(0xff2bbab4);
      backgroundColorChPen = Colors.white;
      backgroundColorChAnda = Colors.white;
      textNumbTotal = Colors.white;
      textNumbPend = Colors.black;
      textNumbAnd = Colors.black;
      textWordTotal = Colors.white;
      textWordPend = Color(0xff999999);
      textWordAnda = Color(0xff999999);
      pendentes = false;
      totalCh = true;
      andamento = false;
    });
  }

  void chamPend() {
    setState(() {
      backgroundColorTotalCham = Colors.white;
      backgroundColorChPen = Color(0xff2bbab4);
      backgroundColorChAnda = Colors.white;
      textNumbTotal = Colors.black;
      textNumbPend = Colors.white;
      textNumbAnd = Colors.black;
      textWordTotal = Color(0xff999999);
      textWordPend = Colors.white;
      textWordAnda = Color(0xff999999);
      pendentes = true;
      totalCh = false;
      andamento = false;
    });
  }

  void chamAtendimento() {
    setState(() {
      backgroundColorTotalCham = Colors.white;
      backgroundColorChPen = Colors.white;
      backgroundColorChAnda = Color(0xff2bbab4);
      textNumbTotal = Colors.black;
      textNumbPend = Colors.black;
      textNumbAnd = Colors.white;
      textWordTotal = Color(0xff999999);
      textWordPend = Color(0xff999999);
      textWordAnda = Colors.white;
      pendentes = false;
      totalCh = false;
      andamento = true;
    });
  }

  Future pullToRefresh() async {
    limparAnimacoesEListas();
    await widget.refresh;
  }

  void limparAnimacoesEListas() {
    animationController.reset();
    animationControllerPendentes.reset();
    animationControllerAndamento.reset();
    widget.listaHistoricoAbertosEPendendes!.clear();
    widget.listaHistoricoPendentes?.clear();
    widget.listaHistoricoAndamento?.clear();
  }
}
