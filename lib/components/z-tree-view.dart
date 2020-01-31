import 'package:circular_check_box/circular_check_box.dart';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/view-model/item-busca-viewmodel.dart';
import 'package:z_components/view-model/z-tree-view-viewmodel.dart';

class ZTreeView extends StatefulWidget {
  List<ZTreeViewViewModel> lisTree;
  String Function(String) teste;

  ZTreeView({this.lisTree, this.teste});

  @override
  _ZTreeViewState createState() => _ZTreeViewState();
}

class _ZTreeViewState extends State<ZTreeView> with TickerProviderStateMixin {
  List<ZTreeViewViewModel> listTreeOriginal;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Column(
        children: listaNovo(),
      ),
    );
  }

  List<Widget> listaNovo() {
    if (widget.lisTree.length == 0 || widget.lisTree == null) {
      return new List<Widget>();
    }

    int j = 0;
    if (testeAki == false) {
      List<GlobalKey> lista = new List<GlobalKey>();

      for (int i = 0; i < widget.lisTree.length; i++) {
        widget.lisTree[i].index = 0;
        GlobalKey key = new GlobalKey<_ZTreeViewState>();
        lista.add(key);
      }
      listaKey.add(lista);
    }

    List<Widget> list = new List();
    widget.lisTree.forEach((item) {
      item.indexAuxiliar = j;

      list.add((!listaId.contains(item.nome) && listaId.length != 0)
          ? new Container()
          : (item.filhos.length == 0)
              ? new GestureDetector(
                  onTap: () {
                    if (widget.teste != null) {
                      var res = widget.teste(item.idNivel);
                    }
                  },
                  child: new Container(
                      color: Colors.white,
                      child: new ConfigurableExpansionTile(
                        key: listaKey[0][j],
                        animatedWidgetPrecedingHeader: (item.filhos.length != 0)
                            ? new Icon(Icons.arrow_drop_down)
                            : new Icon(
                                Icons.arrow_drop_down,
                                color: Colors.transparent,
                              ),
                        borderColorStart: Colors.grey.withOpacity(0.3),
                        borderColorEnd: Colors.grey.withOpacity(0.3),
                        bottomBorderOn: true,
                        onExpansionChanged: (bool value) {
                          for (int i = 0; i < listaKey[0].length; i++) {
                            if (i != item.indexAuxiliar) {
                              listaKey[0][i] = new GlobalKey<_ZTreeViewState>();
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
                                        color: Colors.grey.withOpacity(0.5),
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
                                AnimatedSize(
                                    vsync: this,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.fastOutSlowIn,
                                    reverseDuration:
                                        Duration(milliseconds: 500),
                                    child: new GestureDetector(
                                      onTap: () {
                                        if (widget.teste != null) {
                                          var res = widget.teste(item.idNivel);
                                        }
                                      },
                                      child: new Container(
                                        color: Colors.transparent,
                                        padding: const EdgeInsets.only(
                                            right: 16,
                                            left: 40.0,
                                            bottom: 10.0,
                                            top: 10.0),
                                        child: new Icon(
                                          Icons.keyboard_arrow_right,
                                          color: Color(0xff999999),
                                          size: 16,
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        children: <Widget>[
                          (widget.lisTree.length != 0)
                              ? new Container(
                                  child: new Column(
                                  children: lista2Novo(
                                      nivel: item,
                                      margin: 1.0,
                                      posicaoAnterior: 0),
                                ))
                              : new Container()
                        ],
                      )),
                )
              : new Container(
                  color: Colors.white,
                  child: new ConfigurableExpansionTile(
                    key: listaKey[0][j],
                    animatedWidgetPrecedingHeader: (item.filhos.length != 0)
                        ? new Icon(Icons.arrow_drop_down)
                        : new Icon(
                            Icons.arrow_drop_down,
                            color: Colors.transparent,
                          ),
                    borderColorStart: Colors.grey.withOpacity(0.3),
                    borderColorEnd: Colors.grey.withOpacity(0.3),
                    bottomBorderOn: true,
                    onExpansionChanged: (bool value) {
                      for (int i = 0; i < listaKey[0].length; i++) {
                        if (i != item.indexAuxiliar) {
                          listaKey[0][i] = new GlobalKey<_ZTreeViewState>();
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
                        if (widget.teste != null) {
                          var res = widget.teste(item.idNivel);
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
                                    color: Colors.grey.withOpacity(0.5),
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
                            AnimatedSize(
                                vsync: this,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn,
                                reverseDuration: Duration(milliseconds: 500),
                                child: new GestureDetector(
                                  onTap: () {
                                    if (widget.teste != null) {
                                      var res = widget.teste(item.idNivel);
                                    }
                                  },
                                  child: new Container(
                                    color: Colors.transparent,
                                    padding: const EdgeInsets.only(
                                        right: 16,
                                        left: 40.0,
                                        bottom: 10.0,
                                        top: 10.0),
                                    child: new Icon(
                                      Icons.keyboard_arrow_right,
                                      color: Color(0xff999999),
                                      size: 16,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    children: <Widget>[
                      (widget.lisTree.length != 0)
                          ? new Container(
                              child: new Column(
                              children: lista2Novo(
                                  nivel: item, margin: 1.0, posicaoAnterior: 0),
                            ))
                          : new Container()
                    ],
                  )));
      j++;
    });
    testeAki = true;
    return list;
  }

  List<Widget> lista2Novo(
      {ZTreeViewViewModel nivel, double margin, int posicaoAnterior}) {
    int p = 0;
    List<GlobalKey> lista = new List<GlobalKey>();
    int posAnterior = posicaoAnterior;
    int total;
    if (testeAki == false) {
      total = testeRecursao + 1;

      testeRecursao++;
    }
    if (testeAki == false) {
      if (nivel.filhos.length == 0) {
        GlobalKey key = new GlobalKey<_ZTreeViewState>();
        lista.add(key);
      }
      for (int i = 0; i < nivel.filhos.length; i++) {
        GlobalKey key = new GlobalKey<_ZTreeViewState>();
        lista.add(key);
      }
      listaKey.add(lista);
    }
    var j = margin;
    j++;
    List<Widget> list = new List();
    nivel.filhos.forEach((item) {
      item.indexAuxiliar = p;
      if (testeAki == false) {
        item.index = total;
      }
      list.add((!listaId.contains(item.idNivel) && listaId.length != 0)
          ? new Container()
          : (item.filhos.length == 0)
              ? new GestureDetector(
                  onTap: () {
                    if (widget.teste != null) {
                      var res = widget.teste(item.idNivel);
                    }
                  },
                  child: new Container(
                      color: Colors.white,
                      child: new ConfigurableExpansionTile(
                        key: listaKey[(item.index)][p],
                        borderColorStart: Colors.grey.withOpacity(0.3),
                        borderColorEnd: (item.filhos.length != 0)
                            ? Color(0xff2bbab4)
                            : Colors.grey.withOpacity(0.3),
                        bottomBorderOn: true,
                        onExpansionChanged: (bool value) {
                          for (int i = 0;
                              i < listaKey[item.index].length;
                              i++) {
                            if (i != item.indexAuxiliar) {
                              listaKey[item.index][i] =
                                  new GlobalKey<_ZTreeViewState>();
                            } else {}
                          }
                          setState(() {
                            if (item.aberto == false) {
                              item.aberto = true;
                            } else {
                              item.aberto = false;
                            }
                          });
                          if (item.filhos.length == 0) {
                            if (widget.teste != null) {
                              var res = widget.teste(item.idNivel);
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
                                      (item.filhos.length != 0)
                                          ? (item.aberto == false)
                                              ? new Container(
                                                  margin: EdgeInsets.only(
                                                      left: margin * 10),
                                                  child: new Icon(
                                                      Icons.arrow_drop_down),
                                                )
                                              : new Container(
                                                  margin: EdgeInsets.only(
                                                      left: margin * 10),
                                                  child: new Icon(
                                                      Icons.arrow_drop_up),
                                                )
                                          : new Container(
                                              margin: EdgeInsets.only(
                                                  left: margin * 10),
                                              child: new Icon(
                                                Icons.arrow_drop_up,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                      new Container(
                                        // margin: EdgeInsets.only(left: margin * 10),
                                        color: Colors.grey.withOpacity(0.5),
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
                                AnimatedSize(
                                    vsync: this,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.fastOutSlowIn,
                                    reverseDuration:
                                        Duration(milliseconds: 500),
                                    child: new GestureDetector(
                                      onTap: () {
                                        if (widget.teste != null) {
                                          var res = widget.teste(item.idNivel);
                                        }
                                      },
                                      child: new Container(
                                        color: Colors.transparent,
                                        padding: const EdgeInsets.only(
                                            right: 16,
                                            left: 40.0,
                                            bottom: 10.0,
                                            top: 10.0),
                                        child: new Icon(
                                          Icons.keyboard_arrow_right,
                                          color: Color(0xff999999),
                                          size: 16,
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        children: <Widget>[
                          (item.filhos.length != 0)
                              ? new Container(
                                  child: new Column(
                                  children: lista2Novo(
                                    nivel: item,
                                    margin: j,
                                    posicaoAnterior: item.index,
                                  ),
                                ))
                              : new Container()
                        ],
                      )),
                )
              : new Container(
                  color: Colors.white,
                  child: new ConfigurableExpansionTile(
                    key: listaKey[(item.index)][p],
                    borderColorStart: Colors.grey.withOpacity(0.3),
                    borderColorEnd: (item.filhos.length != 0)
                        ? Color(0xff2bbab4)
                        : Colors.grey.withOpacity(0.3),
                    bottomBorderOn: true,
                    onExpansionChanged: (bool value) {
                      for (int i = 0; i < listaKey[item.index].length; i++) {
                        if (i != item.indexAuxiliar) {
                          listaKey[item.index][i] =
                              new GlobalKey<_ZTreeViewState>();
                        } else {}
                      }
                      setState(() {
                        if (item.aberto == false) {
                          item.aberto = true;
                        } else {
                          item.aberto = false;
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
                                  (item.filhos.length != 0)
                                      ? (item.aberto == false)
                                          ? new Container(
                                              margin: EdgeInsets.only(
                                                  left: margin * 10),
                                              child: new Icon(
                                                  Icons.arrow_drop_down),
                                            )
                                          : new Container(
                                              margin: EdgeInsets.only(
                                                  left: margin * 10),
                                              child:
                                                  new Icon(Icons.arrow_drop_up),
                                            )
                                      : new Container(
                                          margin: EdgeInsets.only(
                                              left: margin * 10),
                                          child: new Icon(
                                            Icons.arrow_drop_up,
                                            color: Colors.transparent,
                                          ),
                                        ),
                                  new Container(
                                    // margin: EdgeInsets.only(left: margin * 10),
                                    color: Colors.grey.withOpacity(0.5),
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
                            (size == 20 && select == false)
                                ? AnimatedSize(
                                    vsync: this,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.fastOutSlowIn,
                                    reverseDuration:
                                        Duration(milliseconds: 500),
                                    child: new GestureDetector(
                                      onTap: () {
                                        if (widget.teste != null) {
                                          var res = widget.teste(item.idNivel);
                                        }
                                      },
                                      child: new Container(
                                        margin:
                                            const EdgeInsets.only(right: 16),
                                        child: new Icon(
                                          Icons.add_circle,
                                          color: Color(0xff2bbab4),
                                          size: size,
                                        ),
                                      ),
                                    ))
                                : AnimatedSize(
                                    vsync: this,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.fastOutSlowIn,
                                    reverseDuration:
                                        Duration(milliseconds: 500),
                                    child: new GestureDetector(
                                      onTap: () {
                                        if (widget.teste != null) {
                                          var res = widget.teste(item.idNivel);
                                        }
                                      },
                                      child: new Container(
                                        color: Colors.transparent,
                                        padding: const EdgeInsets.only(
                                            right: 16,
                                            left: 40.0,
                                            bottom: 10.0,
                                            top: 10.0),
                                        child: new Icon(
                                          Icons.keyboard_arrow_right,
                                          color: Color(0xff999999),
                                          size: 16,
                                        ),
                                      ),
                                    ))
                          ],
                        ),
                      ),
                    ),
                    children: <Widget>[
                      (item.filhos.length != 0)
                          ? new Container(
                              child: new Column(
                              children: lista2Novo(
                                nivel: item,
                                margin: j,
                                posicaoAnterior: item.index,
                              ),
                            ))
                          : new Container()
                    ],
                  )));
      p++;
    });
    return list;
  }

  Widget _buildSearchBar() {
    return new Material(
      elevation: 5,
      child: new Container(
        padding: const EdgeInsets.only(top: 4, bottom: 4),
        // margin: const EdgeInsets.only(bottom: 8,),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(color: Colors.grey.withOpacity(0.2)))),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
                padding: EdgeInsets.all(7.0),
                //margin: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(9.0))),
                child: new Row(
                  children: <Widget>[
                    new Container(
                      child: new Icon(
                        Icons.search,
                        color: Colors.grey.withOpacity(0.9),
                      ),
                    ),
                    new Container(
                      margin: const EdgeInsets.only(left: 2),
                      width: MediaQuery.of(context).size.width / 1.40,
                      child: new TextField(
                        decoration:
                            InputDecoration.collapsed(hintText: "Busca"),
                        style: TextStyle(fontSize: 19.0, color: Colors.black),
                        onChanged: (text) {
                          montarListaPossiveisItens(text);
                        },
                      ),
                    )
                  ],
                )),
            new Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: new Icon(
                Icons.filter_list,
                color: Color(0xff801F92),
              ),
            )
          ],
        ),
      ),
    );
  }

  void preencherListaDeBusca() {
    var lista = widget.lisTree;
    for (int i = 0; i < lista.length; i++) {
      buscaProfundidade(widget.lisTree[i]);
    }
  }

  void preencherListaDeBuscaFiltrada(lista, String id) {
    lista = listTreeOriginal
        .map((item) => new ZTreeViewViewModel.clone(item))
        .toList();
    for (int i = 0; i < lista.length; i++) {
      buscaProfundidadeFiltrada(lista[i], id);
    }
  }

  void buscaProfundidade(ZTreeViewViewModel base) {
    if (base.filhos.isEmpty) {
      if (base.jaPassou == false) {
        listaBusca.add(new ItemBuscaViewModel(
            nome: base.nome, idPai: base.idNivelPai, idAmbiente: base.idNivel));
      }
      base.jaPassou = true;
    }
    base.filhos.forEach((filho) {
      if (base.jaPassou == false) {
        listaBusca.add(new ItemBuscaViewModel(
            nome: base.nome, idPai: base.idNivelPai, idAmbiente: base.idNivel));
      }
      base.jaPassou = true;
      buscaProfundidade(filho);
    });
    listaBuscaFiltrada = listaBusca;
  }

  void buscaProfundidadeFiltrada(ZTreeViewViewModel base, String id) {
    if (base.filhos.isEmpty) {
      if (base.jaPassou == false && base.nome == id) {
        listaId.add(base.idNivel);
        var lista = listTreeOriginal
            .map((item) => new ZTreeViewViewModel.clone(item))
            .toList();
        preencherListaDeBuscaFiltrada(lista, base.idNivelPai);
      }
      base.jaPassou = true;
    }
    base.filhos.forEach((filho) {
      if (base.jaPassou == false) {
        base.jaPassou = true;
      }
      if (base.idNivel == id && !listaId.contains(base.idNivel)) {
        var lista = listTreeOriginal
            .map((item) => new ZTreeViewViewModel.clone(item))
            .toList();
        listaId.add(base.idNivel);
        preencherListaDeBuscaFiltrada(lista, base.idNivelPai);
      } else {
        buscaProfundidadeFiltrada(filho, id);
      }
    });
    listaBuscaFiltrada = listaBusca;
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
    for (int i = 0; i < listaPossiveisId.length; i++) {
      preencherListaDeBuscaFiltrada(new List(), listaPossiveisId[i]);
    }
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
