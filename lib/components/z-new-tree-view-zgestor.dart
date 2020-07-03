import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/view-model/item-busca-viewmodel.dart';
import 'package:z_components/view-model/z-tree-view-viewmodel.dart';

class ZNewTreeViewGestor extends StatefulWidget {
  List<ZTreeViewViewModel> lisTree;
  void Function(ZTreeViewViewModel) onTap;
  Color colorArrow;
  bool todosInicialmenteAbertos;

  ZNewTreeViewGestor({this.lisTree, this.onTap,this.colorArrow: const Color(0xff801F92),this.todosInicialmenteAbertos: false});

  @override
  _ZNewTreeViewGestorState createState() => _ZNewTreeViewGestorState();
}

class _ZNewTreeViewGestorState extends State<ZNewTreeViewGestor> with TickerProviderStateMixin {
  List<ZTreeViewViewModel> treeViewList = new List();
  List<List<GlobalKey>> listaKey = new List<List<GlobalKey>>();
  bool testeAki = false;
  int testeRecursao = 0;
  List<String> listaId = new List();
  List<ItemBuscaViewModel> listaBusca = new List();
  List<ItemBuscaViewModel> listaBuscaFiltrada = new List();
  List<String> listaPossiveisId = new List();
  double size = 0.0;
  bool select = false;
  double sizeEdit = 22.0;
  GlobalKey containerKey = new GlobalKey<_ZNewTreeViewGestorState>();
  int profArvore = 0;
  int auxProfArvore = 0;
  int contadorBuscas = 0;
  bool comecouBusca = false;

  @override
  void initState() {
    super.initState();
    treeViewList = widget.lisTree;
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new Container(
          key: containerKey,
          child: new Column(
            children: listaNovo(),
          ),
        )
      ],
    );
  }

  List<Widget> listaNovo() {
    if (widget.lisTree.length == 0 || widget.lisTree == null) {
      return new List<Widget>();
    }

    int j = 0;

    List<GlobalKey> lista = new List<GlobalKey>();

    for (int i = 0; i < treeViewList.length; i++) {
      treeViewList[i].index = 0;
      GlobalKey key = new GlobalKey<_ZNewTreeViewGestorState>();
      lista.add(key);
    }
    listaKey.add(lista);

    List<Widget> list = new List();
    treeViewList.forEach((item) {
      item.indexAuxiliar = j;

      list.add(_itemListaNovo(item, j));
      j++;
    });
    testeAki = true;
    return list;
  }

  Widget _itemListaNovo(item, j) {
    if (!listaId.contains(item.idNivel) && listaId.length != 0) {
      return new Container();
    } else if (item.filhos.length == 0) {
      return new GestureDetector(
        onTap: () {
          if (widget.onTap != null) {
            var res = widget.onTap(item);
          }
        },
        child: new Container(
            color: Colors.white,
            child: new ConfigurableExpansionTile(
              animatedWidgetFollowingHeader: (item.filhos.length != 0)
                  ? new Icon(Icons.arrow_drop_down)
                  : new Container(),
              initiallyExpanded: widget.todosInicialmenteAbertos,
              borderColorStart: Colors.grey.withOpacity(0.3),
              borderColorEnd: Colors.grey.withOpacity(0.3),
              bottomBorderOn: true,
              onExpansionChanged: (bool value) {
                for (int i = 0; i < listaKey[0].length; i++) {
                  if (i != item.indexAuxiliar) {
                    listaKey[0][i] = new GlobalKey<_ZNewTreeViewGestorState>();
                  } else {}
                }
                setState(() {
                  for (int i = 0; i < item.filhos.length; i++) {
                    if (item.filhos[i].aberto == true) {
                      item.filhos[i].aberto = false;
                    }
                    limparBoolsFilhosTree(
                        ambienteHierarquicoViewModel: item.filhos[i]);
                  }
                });
              },
              header: new Expanded(
                child: new InkWell(
                  onTap: () {
                    if (widget.onTap != null) {
                      var res = widget.onTap(item);
                    }
                  },
                  child:
                  new Container(
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Container(
                          child: new Row(
                            children: <Widget>[
                              new Container(
                                // margin: EdgeInsets.only(left: _margin),
                                color: Color(0xff707070),
                                width: 1.5,
                                height: 45,
                              ),
                              new Container(
                                width: 145,
                                color: Colors.transparent,
                                padding: EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 10.0,
                                    left: 16.0,
                                    right: 30.0),
                                child: new Text(
                                  "${item.nome}",
                                  style: new TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            new Container(
                              color: Colors.transparent,
                              margin: const EdgeInsets.only(right: 16),
                              padding: const EdgeInsets.only(
                                  bottom: 10.0,
                                  top: 10.0),
                              child: new Icon(
                                Icons.keyboard_arrow_right,
                                color: widget.colorArrow,
                                size: 24,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ),
              children: <Widget>[
                _definirFilho(item, 1.0, 0),
              ],
            )),
      );
    } else {
      return new Container(
          color: Colors.white,
          child: new ConfigurableExpansionTile(
            key: listaKey[0][j],
            initiallyExpanded: widget.todosInicialmenteAbertos,
            animatedWidgetFollowingHeader: (item.filhos.length != 0)
                ? new Container(
              margin: const EdgeInsets.symmetric(horizontal: 14),
              child: new Icon(Icons.arrow_drop_down),
            )
                : new Container(),
            borderColorStart: Colors.grey.withOpacity(0.3),
            borderColorEnd: Colors.grey.withOpacity(0.3),
            bottomBorderOn: true,
            onExpansionChanged: (bool value) {
              for (int i = 0; i < listaKey[0].length; i++) {
                if (i != item.indexAuxiliar) {
                  listaKey[0][i] = new GlobalKey<_ZNewTreeViewGestorState>();
                } else {}
              }
              setState(() {
                for (int i = 0; i < item.filhos.length; i++) {
                  if (item.filhos[i].aberto == true) {
                    item.filhos[i].aberto = false;
                  }
                  limparBoolsFilhosTree(
                      ambienteHierarquicoViewModel: item.filhos[i]);
                }
              });

              if (item.filhos.length == 0) {
                if (widget.onTap != null) {
                  var res = widget.onTap(item);
                }
              }
            },
            header: new Expanded(
              child: new Container(
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Container(
                      child: new Row(
                        children: <Widget>[
                          new Container(
                            // margin: EdgeInsets.only(left: _margin),
                            color: Color(0xff707070),
                            width: 1.5,
                            height: 45,
                          ),
                          new GestureDetector(
                            child: new Container(
                              width: 145,
                              color: Colors.transparent,
                              padding: EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 16.0,
                                  right: 30.0),
                              child: new Text(
                                "${item.nome}",
                                style: new TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            children: <Widget>[
              _definirFilho(item, 1.0, 0),
            ],
          ));
    }
  }

  Color definirCorExpansionTile(item) {
    if (item.filhos.length != 0) {
      return Colors.grey.withOpacity(0.3);
    } else {
      return Colors.grey.withOpacity(0.3);
    }
  }

  IconData definirIconeExpansionTile(item) {
    if (item.filhos.length != 0) {
      if (item.aberto == null || item.aberto == true) {
        return Icons.arrow_drop_down;
      } else {
        return Icons.arrow_drop_up;
      }
    }
  }

  Widget _definirFilho(item, j, index) {
    if (item.filhos.length != 0) {
      return new Container(
          child: new Column(
            children: lista2Novo(
              nivel: item,
              margin: j,
              posicaoAnterior: index,
            ),
          ));
    } else {
      return new Container();
    }
  }

  List<Widget> lista2Novo(
      {ZTreeViewViewModel nivel, double margin, int posicaoAnterior}) {
    int p = 0;
    List<GlobalKey> lista = new List<GlobalKey>();
    int total;

    total = testeRecursao + 1;

    testeRecursao++;

    if (nivel.filhos.length == 0) {
      GlobalKey key = new GlobalKey<_ZNewTreeViewGestorState>();
      lista.add(key);
    }
    for (int i = 0; i < nivel.filhos.length; i++) {
      GlobalKey key = new GlobalKey<_ZNewTreeViewGestorState>();
      lista.add(key);
    }
    listaKey.add(lista);

    var j = margin;
    j++;
    List<Widget> list = new List();
    nivel.filhos.forEach((item) {
      item.indexAuxiliar = p;
      if (testeAki == false) {
        item.index = total;
      }
      list.add(_itemLista(item, margin, p, j));
      p++;
    });
    return list;
  }

  Widget _itemLista(item, margin, p, j) {
    if (!listaId.contains(item.idNivel) && listaId.length != 0) {
      return new Container();
    } else if (item.filhos.length == 0) {
      return new GestureDetector(
        onTap: () {
          if (widget.onTap != null) {
            var res = widget.onTap(item);
          }
        },
        child: new Container(
            color: Colors.white,
            child: new ConfigurableExpansionTile(
              borderColorStart: Colors.grey.withOpacity(0.3),
              borderColorEnd: definirCorExpansionTile(item),
              initiallyExpanded: widget.todosInicialmenteAbertos,
              animatedWidgetFollowingHeader: (item.filhos.length != 0)
                  ? new Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                child: new Icon(Icons.arrow_drop_down),
              )
                  : new Container(),
              bottomBorderOn: true,
              header: new Expanded(
                child: new InkWell(
                  onTap: () {
                    if (widget.onTap != null) {
                      var res = widget.onTap(item);
                    }
                  },
                  child: new Container(
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Container(
                          child: new Row(
                            children: <Widget>[
                              new Container(
                                margin: EdgeInsets.only(left: margin * 16),
                                color: Color(0xff707070),
                                width: 1.5,
                                height: 45,
                              ),
                              new Container(
                                width: 145,
                                color: Colors.transparent,
                                padding: EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 10.0,
                                    left: 6.0,
                                    right: 30.0),
                                child: new Text(
                                  "${item.nome}",
                                  style: new TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.only(right: 16),
                          padding: const EdgeInsets.only(
                              bottom: 10.0,
                              top: 10.0),
                          child: new Icon(
                            Icons.keyboard_arrow_right,
                            color: widget.colorArrow,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ),
              children: <Widget>[
                _definirFilho(item, j, item.index),
              ],
            )),
      );
    } else
      return new Container(
          color: Colors.white,
          child: new ConfigurableExpansionTile(
            key: listaKey[item.index][p],
            initiallyExpanded: widget.todosInicialmenteAbertos,
            animatedWidgetFollowingHeader: (item.filhos.length != 0)
                ? new Container(
              margin: const EdgeInsets.symmetric(horizontal: 14),
              child: new Icon(Icons.arrow_drop_down),
            )
                : new Container(),
            borderColorStart: Colors.grey.withOpacity(0.3),
            borderColorEnd: definirCorExpansionTile(item),
            bottomBorderOn: true,
            onExpansionChanged: (bool value) {
              for (int i = 0; i < listaKey[item.index].length; i++) {
                if (i != item.indexAuxiliar) {
                  listaKey[item.index][i] = new GlobalKey<_ZNewTreeViewGestorState>();
                } else {}
              }
              setState(() {
                if (item.aberto==null||item.aberto == true) {
                  item.aberto = false;
                } else {
                  item.aberto = true;
                }
              });
            },
            header: new Expanded(
              child: new Container(
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Container(
                      child: new Row(
                        children: <Widget>[
                          new Container(
                             margin: EdgeInsets.only(left: margin * 16),
                            color: Color(0xff707070),
                            width: 1.5,
                            height: 45,
                          ),
                          new GestureDetector(
                            child: new Container(
                              width: 145,
                              color: Colors.transparent,
                              padding: EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 6.0,
                                  right: 30.0),
                              child: new Text(
                                "${item.nome}",
                                style: new TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            children: <Widget>[
              _definirFilho(item, j, item.index),
            ],
          ));
  }

  void montarListaPossiveisItens(String text) {
    listaPossiveisId.clear();
    listaId.clear();
    if (text.length == 0) {
      return;
    }
    for (int i = 0; i < listaBusca.length; i++) {
      if (listaBusca[i].nome.toLowerCase().contains(text.toLowerCase())) {
        listaPossiveisId.add(listaBusca[i].idAmbiente);
      }
    }
    containerKey = new GlobalKey<_ZNewTreeViewGestorState>();
    setState(() {});
  }

  void limparBoolsFilhosTree(
      {ZTreeViewViewModel ambienteHierarquicoViewModel}) {
    var item = ambienteHierarquicoViewModel;
    for (int i = 0; i < item.filhos.length; i++) {
      if (item.filhos[i].aberto == true) {
        item.filhos[i].aberto = false;
      }
      limparBoolsFilhos(ambienteHierarquicoViewModel: item.filhos[i]);
    }
    setState(() {});
  }

  void limparBoolsFilhos({ZTreeViewViewModel ambienteHierarquicoViewModel}) {
    var item = ambienteHierarquicoViewModel;
    for (int i = 0; i < item.filhos.length; i++) {
      if (item.filhos[i].select == true) {
        item.filhos[i].select = false;
      }
      limparBoolsFilhos(ambienteHierarquicoViewModel: item.filhos[i]);
    }
    setState(() {});
  }
}
