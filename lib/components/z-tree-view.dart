
import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/view-model/item-busca-viewmodel.dart';
import 'package:z_components/view-model/z-tree-view-viewmodel.dart';

class ZTreeView extends StatefulWidget {
  List<ZTreeViewViewModel>? lisTree;
  void Function(String)? onTap;

  ZTreeView({this.lisTree, this.onTap});

  @override
  _ZTreeViewState createState() => _ZTreeViewState();
}

class _ZTreeViewState extends State<ZTreeView> with TickerProviderStateMixin {
  List<ZTreeViewViewModel>? treeViewList = [];
  List<List<GlobalKey>>? listaKey = [];
  bool? testeAki = false;
  int? testeRecursao = 0;
  List<String>? listaId = [];
  List<ItemBuscaViewModel>? listaBusca = [];
  List<ItemBuscaViewModel>? listaBuscaFiltrada = [];
  List<String>? listaPossiveisId = [];
  double? size = 0.0;
  bool? select = false;
  double? sizeEdit = 22.0;
  GlobalKey? containerKey = new GlobalKey<_ZTreeViewState>();
  int? profArvore = 0;
  int? auxProfArvore = 0;
  int? contadorBuscas = 0;
  bool? comecouBusca = false;

  @override
  void initState() {
    super.initState();
    treeViewList = widget.lisTree;
    preencherListaDeBusca();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        _buildSearchBar(),
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
    if (widget.lisTree == null  || widget.lisTree!.length == 0) {
      return [];
    }

    int j = 0;

    List<GlobalKey> lista = [];

    for (int i = 0; i < treeViewList!.length; i++) {
      treeViewList![i].index = 0;
      GlobalKey key = new GlobalKey<_ZTreeViewState>();
      lista.add(key);
    }
    listaKey?.add(lista);

    List<Widget> list = [];
    treeViewList?.forEach((item) {
      item.indexAuxiliar = j;

      list.add(_itemListaNovo(item, j));
      j++;
    });
    testeAki = true;
    return list;
  }

  Widget _itemListaNovo(item, j) {
    if (!listaId!.contains(item.idNivel) && listaId!.length != 0) {
      return new Container();
    } else if (item.filhos.length == 0) {
      return new GestureDetector(
        onTap: () {
          if (widget.onTap != null) {
            var res = widget.onTap!(item.idNivel);
          }
        },
        child: new Container(
            color: Colors.white,
            child: new ConfigurableExpansionTile(
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
                for (int i = 0; i < listaKey![0].length; i++) {
                  if (i != item.indexAuxiliar) {
                    listaKey![0][i] = new GlobalKey<_ZTreeViewState>();
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
                      new Row(
                        children: <Widget>[
                          _contadorResultadosBusca(item),
                          AnimatedSize(
                              vsync: this,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn,
                              reverseDuration: Duration(milliseconds: 500),
                              child: new GestureDetector(
                                onTap: () {
                                  if (widget.onTap != null) {
                                    var res = widget.onTap!(item.idNivel);
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
                      )
                    ],
                  ),
                ),
              ),
              childrenBody:
                _definirFilho(item, 1.0, 0),
            )),
      );
    } else {
      return new Container(
          color: Colors.white,
          child: new ConfigurableExpansionTile(
            key: listaKey![0][j],
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
              for (int i = 0; i < listaKey![0].length; i++) {
                if (i != item.indexAuxiliar) {
                  listaKey![0][i] = new GlobalKey<_ZTreeViewState>();
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
                  var res = widget.onTap!(item.idNivel);
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
                    new Row(
                        children: <Widget>[
                          _contadorResultadosBusca(item),
                          AnimatedSize(
                              vsync: this,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn,
                              reverseDuration: Duration(milliseconds: 500),
                              child: new GestureDetector(
                                onTap: () {
                                  if (widget.onTap != null) {
                                    var res = widget.onTap!(item.idNivel);
                                  }
                                },
                                child: new Container(
                                  color: Colors.transparent,
                                  padding: const EdgeInsets.only(
                                      right: 16, left: 40.0, bottom: 10.0, top: 10.0),
                                  child: new Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Color(0xff999999),
                                    size: 16,
                                  ),
                                ),
                              ))])
                  ],
                ),
              ),
            ),
            childrenBody:
              _definirFilho(item, 1.0, 0),
          ));
    }
  }

  Color definirCorExpansionTile(item) {
    if (item.filhos.length != 0) {
      return Color(0xff2bbab4);
    } else {
      return Colors.grey.withOpacity(0.3);
    }
  }

  IconData? definirIconeExpansionTile(item) {
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
      {ZTreeViewViewModel? nivel, double? margin, int? posicaoAnterior}) {
    int p = 0;
    List<GlobalKey> lista = [];
    int total;

    total = testeRecursao! + 1;

    testeRecursao! + 1;

    if (nivel!.filhos!.length == 0) {
      GlobalKey key = new GlobalKey<_ZTreeViewState>();
      lista.add(key);
    }
    for (int i = 0; i < nivel.filhos!.length; i++) {
      GlobalKey key = new GlobalKey<_ZTreeViewState>();
      lista.add(key);
    }
    listaKey?.add(lista);

    var j = margin;
    j! +1;
    List<Widget> list = [];
    nivel.filhos?.forEach((item) {
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
    if (!listaId!.contains(item.idNivel) && listaId!.length != 0) {
      return new Container();
    } else if (item.filhos.length == 0) {
      return new GestureDetector(
        onTap: () {
          if (widget.onTap != null) {
            var res = widget.onTap!(item.idNivel);
          }
        },
        child: new Container(
            color: Colors.white,
            child: new ConfigurableExpansionTile(
              borderColorStart: Colors.grey.withOpacity(0.3),
              borderColorEnd: definirCorExpansionTile(item),
              bottomBorderOn: true,
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
                              margin: EdgeInsets.only(left: margin * 10),
                              child: new Icon(
                                definirIconeExpansionTile(item),
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
                          reverseDuration: Duration(milliseconds: 500),
                          child: new GestureDetector(
                            onTap: () {
                              if (widget.onTap != null) {
                                var res = widget.onTap!(item.idNivel);
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
              childrenBody:
                _definirFilho(item, j, item.index),
            )),
      );
    } else
      return new Container(
          color: Colors.white,
          child: new ConfigurableExpansionTile(
            key: listaKey![item.index][p],
            borderColorStart: Colors.grey.withOpacity(0.3),
            borderColorEnd: definirCorExpansionTile(item),
            bottomBorderOn: true,
            onExpansionChanged: (bool value) {
              for (int i = 0; i < listaKey![item.index].length; i++) {
                if (i != item.indexAuxiliar) {
                  listaKey![item.index][i] = new GlobalKey<_ZTreeViewState>();
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
                            margin: EdgeInsets.only(left: margin * 10),
                            child: new Icon(
                              definirIconeExpansionTile(item),
                              color: Colors.black,
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
                        reverseDuration: Duration(milliseconds: 500),
                        child: new GestureDetector(
                          onTap: () {
                            if (widget.onTap != null) {
                              var res = widget.onTap!(item.idNivel);
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
            childrenBody:
              _definirFilho(item, j, item.index)
          ));
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
                padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 16),
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
                          preencherContadorListaDeBusca(text);
                          if (text.length > 0) {
                            comecouBusca = true;
                          } else {
                            comecouBusca = false;
                          }
                          containerKey = new GlobalKey<_ZTreeViewState>();
                          setState(() {});
                        },
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void preencherListaDeBusca() {
    var lista = widget.lisTree
        ?.map((item) => new ZTreeViewViewModel.clone(item))
        .toList();
    for (int i = 0; i < lista!.length; i++) {
      buscaProfundidade(lista[i]);
    }
    print(profArvore);
  }

  void preencherListaDeBuscaFiltrada(lista, String id) {
    lista = widget.lisTree
        ?.map((item) => new ZTreeViewViewModel.clone(item))
        .toList();
    for (int i = 0; i < lista.length; i++) {
      buscaProfundidadeFiltrada(lista[i], id);
    }
  }

  void buscaProfundidade(ZTreeViewViewModel base) {
    if (base.filhos!.isEmpty) {
      auxProfArvore!+1;
      if (auxProfArvore! > profArvore!) {
        profArvore = auxProfArvore;
      }
      auxProfArvore = 0;
      if (base.jaPassou == null || base.jaPassou == false) {
        auxProfArvore! +1;
        listaBusca?.add(new ItemBuscaViewModel(
            nome: base.nome, idPai: base.idNivelPai, idAmbiente: base.idNivel));
      }
      base.jaPassou = true;
    }
    base.filhos?.forEach((filho) {
      if (base.jaPassou == null || base.jaPassou == false) {
        listaBusca?.add(new ItemBuscaViewModel(
            nome: base.nome, idPai: base.idNivelPai, idAmbiente: base.idNivel));
      }
      base.jaPassou = true;
      buscaProfundidade(filho);
    });
    listaBuscaFiltrada = listaBusca;
  }

  void buscaProfundidadeFiltrada(ZTreeViewViewModel base, String id) {
    if (base.filhos!.isEmpty) {
      if ((base.jaPassou == null || base.jaPassou == false) &&
          base.nome == id) {
        listaId?.add(base.idNivel!);
        var lista = widget.lisTree
            ?.map((item) => new ZTreeViewViewModel.clone(item))
            .toList();
        preencherListaDeBuscaFiltrada(lista, base.idNivelPai!);
      }
      base.jaPassou = true;
    }
    base.filhos?.forEach((filho) {
      if (base.jaPassou == null || base.jaPassou == false) {
        base.jaPassou = true;
      }
      if (base.idNivel == id && !listaId!.contains(base.idNivel)) {
        var lista = widget.lisTree
            ?.map((item) => new ZTreeViewViewModel.clone(item))
            .toList();
        listaId?.add(base.idNivel!);
        preencherListaDeBuscaFiltrada(lista, base.idNivelPai!);
      } else {
        buscaProfundidadeFiltrada(filho, id);
      }
    });
    listaBuscaFiltrada = listaBusca;
  }

  void montarListaPossiveisItens(String text) {
    listaPossiveisId?.clear();
    listaId?.clear();
    if (text.length == 0) {
      return;
    }
    for (int i = 0; i < listaBusca!.length; i++) {
      if (listaBusca![i].nome!.toLowerCase().contains(text.toLowerCase())) {
        listaPossiveisId?.add(listaBusca![i].idAmbiente!);
      }
    }
    for (int i = 0; i < listaPossiveisId!.length; i++) {
      preencherListaDeBuscaFiltrada([], listaPossiveisId![i]);
    }
    containerKey = new GlobalKey<_ZTreeViewState>();
    setState(() {});
  }

  void limparBoolsFilhosTree(
      {ZTreeViewViewModel? ambienteHierarquicoViewModel}) {
    var item = ambienteHierarquicoViewModel;
    for (int i = 0; i < item!.filhos!.length; i++) {
      if (item.filhos![i].aberto == true) {
        item.filhos![i].aberto = false;
      }
      limparBoolsFilhos(ambienteHierarquicoViewModel: item.filhos![i]);
    }
    setState(() {});
  }

  void limparBoolsFilhos({ZTreeViewViewModel? ambienteHierarquicoViewModel}) {
    var item = ambienteHierarquicoViewModel;
    for (int i = 0; i < item!.filhos!.length; i++) {
      if (item.filhos![i].select == true) {
        item.filhos![i].select = false;
      }
      limparBoolsFilhos(ambienteHierarquicoViewModel: item.filhos![i]);
    }
    setState(() {});
  }

  Widget _contadorResultadosBusca(item) {
    if (comecouBusca == false) {
      return new Container();
    } else {
      return new Container(
        margin: EdgeInsets.only(right: 24.0),
        padding: EdgeInsets.only(left: 8.0, right: 8.0),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffcccccc)),
            borderRadius: BorderRadius.circular(12.0)),
        child: new Container(
          child: new Text(
            "${item.possiveisBuscas}",
            style: TextStyle(color: Color(0xff000000)),
          ),
        ),
      );
    }
  }

  void preencherContadorListaDeBusca(text) {
    var lista = widget.lisTree
        ?.map((item) => new ZTreeViewViewModel.clone(item))
        .toList();
    for (int i = 0; i < lista!.length; i++) {
      buscaProfundidadeContador(lista[i], text);
      if (treeViewList![i].possiveisBuscas == null) {
        treeViewList![i].possiveisBuscas = 0;
      }
      treeViewList![i].possiveisBuscas = contadorBuscas;
      contadorBuscas = 0;
    }
  }

  void buscaProfundidadeContador(ZTreeViewViewModel base, text) {
    if (base.filhos!.isEmpty) {
      if (base.jaPassou == null || base.jaPassou == false) {
        if (base.nome!.toLowerCase().contains(text)) {
          contadorBuscas! +1;
        }
        listaBusca?.add(new ItemBuscaViewModel(
            nome: base.nome, idPai: base.idNivelPai, idAmbiente: base.idNivel));
      }
      base.jaPassou = true;
    }
    base.filhos?.forEach((filho) {
      if (base.jaPassou == null || base.jaPassou == false) {
        if (base.nome!.toLowerCase().contains(text)) {
          contadorBuscas! +1;
        }
        listaBusca?.add(new ItemBuscaViewModel(
            nome: base.nome, idPai: base.idNivelPai, idAmbiente: base.idNivel));
      }
      base.jaPassou = true;
      buscaProfundidadeContador(filho, text);
    });
    listaBuscaFiltrada = listaBusca;
  }
}
