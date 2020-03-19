import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/styles/media-query.dart';
import 'package:z_components/view-model/item-busca-viewmodel.dart';
import 'package:z_components/view-model/z-tree-view-viewmodel.dart';

class ZNewTreeView extends StatefulWidget {
  List<ZTreeViewViewModel> lisTree;
  void Function(ZTreeViewViewModel) onTap;

  ZNewTreeView({this.lisTree, this.onTap});

  @override
  _ZNewTreeViewState createState() => _ZNewTreeViewState();
}

class _ZNewTreeViewState extends State<ZNewTreeView>
    with TickerProviderStateMixin {
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
  GlobalKey containerKey = new GlobalKey<_ZNewTreeViewState>();
  int profArvore = 0;
  int auxProfArvore = 0;
  int contadorBuscas = 0;
  bool comecouBusca = false;

  @override
  void initState() {
    super.initState();
    treeViewList = widget.lisTree;
    preencherListaDeBusca();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      key: containerKey,
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
        GlobalKey key = new GlobalKey<_ZNewTreeViewState>();
        lista.add(key);
      }
      listaKey.add(lista);
    }

    List<Widget> list = new List();
    widget.lisTree.forEach((item) {
      item.indexAuxiliar = j;
      List<String> caminhoAkis = new List();
      montarCaminho(item.caminho, caminhoAkis);
      list.add(new GestureDetector(
        onTap: () {
          widget.onTap;
        },
        child: new Container(
          decoration: BoxDecoration(
            border: new Border.all(width: 1, color: Color(0xFFCCCCCC)),
            borderRadius: new BorderRadius.circular(4),
          ),
          margin: EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0),
          child: new Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.circular(4),
            ),
            padding: EdgeInsets.only(left: 16),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Container(
                  child: new Row(
                    children: <Widget>[
                      new Container(
                          width: MediaQuerySize.get(context).width * 0.53,
                          color: Colors.transparent,
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: new Text(
                              "${item.nome}",
                              style: new TextStyle(fontSize: 14),
                            ),
                          ))
                    ],
                  ),
                ),
                new Container(
                  child: new Row(
                    children: <Widget>[
                      new AnimatedSize(
                        vsync: this,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn,
                        reverseDuration: Duration(milliseconds: 500),
                        child: new Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.only(
                            right: 16,
                            left: 4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
      j++;
    });
    testeAki = true;
    return list;
  }

  List<Widget> lista2Novo(
      {ZTreeViewViewModel nivel,
      double margin,
      int posicaoAnterior,
      int filhos}) {
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
        GlobalKey key = new GlobalKey<_ZNewTreeViewState>();
        lista.add(key);
      }
      for (int i = 0; i < nivel.filhos.length; i++) {
        GlobalKey key = new GlobalKey<_ZNewTreeViewState>();
        lista.add(key);
      }
      listaKey.add(lista);
    }
    var j = margin;
    j++;
    List<Widget> list = new List();
    nivel.filhos.forEach((item) {
      List<String> caminhoAkis = new List();
      montarCaminho(item.caminho, caminhoAkis);
      item.indexAuxiliar = p;
      if (testeAki == false) {
        item.index = total;
      }
      list.add(new Container(
          color: Colors.white,
          child: new ConfigurableExpansionTile(
            initiallyExpanded: (filhos == 1) ? true : false,
            key: listaKey[(item.index)][p],
            borderColorStart: Colors.grey.withOpacity(0.3),
            borderColorEnd: (item.filhos.length != 0)
                ? Color(0xff2bbab4)
                : Colors.grey.withOpacity(0.3),
            bottomBorderOn: true,
            onExpansionChanged: (bool value) {
              for (int i = 0; i < listaKey[item.index].length; i++) {
                if (i != item.indexAuxiliar) {
                  listaKey[item.index][i] = new GlobalKey<_ZNewTreeViewState>();
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
                          (item.filhos.length != 0)
                              ? (filhos == 1)
                                  ? (item.aberto == true)
                                      ? new Container(
                                          margin: EdgeInsets.only(
                                              left: margin * 10),
                                          child:
                                              new Icon(Icons.arrow_drop_down),
                                        )
                                      : new Container(
                                          margin: EdgeInsets.only(
                                              left: margin * 10),
                                          child: new Icon(Icons.arrow_drop_up),
                                        )
                                  : (item.aberto == false)
                                      ? new Container(
                                          margin: EdgeInsets.only(
                                              left: margin * 10),
                                          child:
                                              new Icon(Icons.arrow_drop_down),
                                        )
                                      : new Container(
                                          margin: EdgeInsets.only(
                                              left: margin * 10),
                                          child: new Icon(Icons.arrow_drop_up),
                                        )
                              : new Container(
                                  margin: EdgeInsets.only(left: margin * 10),
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
                        reverseDuration: Duration(milliseconds: 500),
                        child: new GestureDetector(
                          onTap: () {
                            if (widget.onTap != null) {
                              var res = widget.onTap(item);
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
                          filhos: item.filhos.length),
                    ))
                  : new Container()
            ],
          )));
      p++;
    });
    return list;
  }

  void preencherListaDeBusca() {
    var lista = widget.lisTree
        .map((item) => new ZTreeViewViewModel.clone(item))
        .toList();
    for (int i = 0; i < lista.length; i++) {
      buscaProfundidade(lista[i]);
    }
    print(profArvore);
  }

  void preencherListaDeBuscaFiltrada(lista, String id) {
    lista = widget.lisTree
        .map((item) => new ZTreeViewViewModel.clone(item))
        .toList();
    for (int i = 0; i < lista.length; i++) {
      buscaProfundidadeFiltrada(lista[i], id);
    }
  }

  void buscaProfundidade(ZTreeViewViewModel base) {
    if (base.filhos.isEmpty) {
      auxProfArvore++;
      if (auxProfArvore > profArvore) {
        profArvore = auxProfArvore;
      }
      auxProfArvore = 0;
      if (base.jaPassou == null || base.jaPassou == false) {
        auxProfArvore++;
        listaBusca.add(new ItemBuscaViewModel(
            nome: base.nome, idPai: base.idNivelPai, idAmbiente: base.idNivel));
      }
      base.jaPassou = true;
    }
    base.filhos.forEach((filho) {
      if (base.jaPassou == null || base.jaPassou == false) {
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
      if ((base.jaPassou == null || base.jaPassou == false) &&
          base.nome == id) {
        listaId.add(base.idNivel);
        var lista = widget.lisTree
            .map((item) => new ZTreeViewViewModel.clone(item))
            .toList();
        preencherListaDeBuscaFiltrada(lista, base.idNivelPai);
      }
      base.jaPassou = true;
    }
    base.filhos.forEach((filho) {
      if (base.jaPassou == null || base.jaPassou == false) {
        base.jaPassou = true;
      }
      if (base.idNivel == id && !listaId.contains(base.idNivel)) {
        var lista = widget.lisTree
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

  void montarCaminho(String caminho, List<String> caminhoAkis) {
    if (caminho.contains('|')) {
      caminhoAkis.addAll(caminho.split("|"));
    } else {
      caminhoAkis.add(caminho);
    }
    caminhoAkis;
  }
}
