
import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/styles/media-query.dart';
import 'package:z_components/view-model/item-busca-viewmodel.dart';
import 'package:z_components/view-model/z-tree-view-viewmodel.dart';

class ZNewTreeView extends StatefulWidget {
  List<ZTreeViewViewModel>? lisTree;
  void Function(ZTreeViewViewModel)? onTap;

  ZNewTreeView({this.lisTree, this.onTap});

  @override
  _ZNewTreeViewState createState() => _ZNewTreeViewState();
}

class _ZNewTreeViewState extends State<ZNewTreeView>
    with TickerProviderStateMixin {
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
  GlobalKey containerKey = new GlobalKey<_ZNewTreeViewState>();
  int? profArvore = 0;
  int? auxProfArvore = 0;
  int? contadorBuscas = 0;
  bool? comecouBusca = false;

  @override
  void initState() {
    super.initState();
    treeViewList = widget.lisTree;
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
    if (widget.lisTree!.length == 0 || widget.lisTree == null) {
      return [];
    }

    int j = 0;
    if (testeAki == false) {
      List<GlobalKey> lista = [];

      for (int i = 0; i < widget.lisTree!.length; i++) {
        widget.lisTree![i].index = 0;
        GlobalKey key = new GlobalKey<_ZNewTreeViewState>();
        lista.add(key);
      }
      listaKey?.add(lista);
    }

    List<Widget> list = [];
    widget.lisTree?.forEach((item) {
      item.indexAuxiliar = j;
      List<String> caminhoAkis = [];
      montarCaminho(item.caminho!, caminhoAkis);
      list.add(new Container(
          margin: EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0),
          child: new ConfigurableExpansionTile(
            initiallyExpanded: true,
            header: new Expanded(
              child: new Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: new Border.all(width: 1, color: Color(0xFFCCCCCC)),
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
                          new GestureDetector(
                            child: new Container(
                                width: MediaQuerySize.get(context).width * 0.72,
                                color: Colors.transparent,
                                padding: EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 6.0,
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: new Text(
                                    "${item.nome}",
                                    style: new TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          )
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
                              child: new GestureDetector(
                                onTap: () {},
                                child: new Container(
                                    color: Colors.transparent,
                                    padding: const EdgeInsets.only(
                                        right: 16,
                                        left: 8,
                                        bottom: 10.0,
                                        top: 10.0),
                                    child: new Row(
                                      children: <Widget>[new Container()],
                                    )),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            childrenBody:
              (widget.lisTree!.length != 0)
                  ? new Container(
                      child: new Column(
                      children: lista2Novo(
                          nivel: item,
                          margin: 1.0,
                          posicaoAnterior: 0,
                          filhos: item.filhos!.length),
                    ))
                  : new Container(),

          )));
      j++;
    });
    testeAki = true;
    return list;
  }

  List<Widget> lista2Novo(
      {ZTreeViewViewModel? nivel,
      double? margin,
      int? posicaoAnterior,
      int? filhos}) {
    int p = 0;
    List<GlobalKey> lista = [];
    int? posAnterior = posicaoAnterior;
    int? total;
    if (testeAki == false) {
      total = testeRecursao! + 1;

      testeRecursao! +1;
    }
    if (testeAki == false) {
      if (nivel!.filhos!.length == 0) {
        GlobalKey key = new GlobalKey<_ZNewTreeViewState>();
        lista.add(key);
      }
      for (int i = 0; i < nivel!.filhos!.length; i++) {
        GlobalKey key = new GlobalKey<_ZNewTreeViewState>();
        lista.add(key);
      }
      listaKey?.add(lista);
    }
    var j = margin;
    j! +1;
    List<Widget> list = [];
    nivel!.filhos!.forEach((item) {
      List<String> caminhoAkis = [];
      montarCaminho(item.caminho!, caminhoAkis);
      item.indexAuxiliar = p;
      if (testeAki == false) {
        item.index = total;
      }
      list.add(new GestureDetector(
        onTap: () {
          if(widget.onTap!=null){
            widget.onTap!(item);
          }

        },
        child: new Container(
            decoration: BoxDecoration(
              border: new Border.all(width: 1, color: Color(0xFFCCCCCC)),
              borderRadius: new BorderRadius.circular(4),
            ),
            margin: EdgeInsets.only(top: 4.0, left: 8.0, right: 8),
            child: new Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.circular(4),
              ),
              padding: EdgeInsets.only(left: 16),
              child: new Container(
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Container(
                      child: new Row(
                        children: <Widget>[
                          new Container(
                              width: MediaQuerySize.get(context).width * 0.75,
                              color: Colors.transparent,
                              padding: EdgeInsets.only(
                                top: 10.0,
                                bottom: 10.0,
                                left: 6.0,
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: new Text(
                                  "${item.nome}",
                                  style: new TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                              ))
                        ],
                      ),
                    ),
                    new Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(
                          right: 16, bottom: 10.0, top: 10.0),
                      child: new Icon(
                        Icons.keyboard_arrow_right,
                        color: Color(0xff999999),
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ));
      p++;
    });
    return list;
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

  void montarCaminho(String caminho, List<String> caminhoAkis) {
    if (caminho.contains('|')) {
      caminhoAkis.addAll(caminho.split("|"));
    } else {
      caminhoAkis.add(caminho);
    }
    caminhoAkis;
  }
}
