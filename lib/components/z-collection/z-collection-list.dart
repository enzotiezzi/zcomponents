import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/filtro-campo.dart';
import 'package:z_components/components/utils/icone-voltar.dart';
import 'package:z_components/components/z-collection/z-collection-item.dart';
import 'package:z_components/components/z-tile.dart';
import 'package:z_components/styles/main-style.dart';

class ZCollectionList extends StatefulWidget {
  GlobalKey key;
  List<ZCollectionItem> lista;
  final ThemeData theme;
  final String titulo;
  final ZCollectionItem ultimoValor;
  final color;
  final FiltroCampo filtroPrincipal;
  int skip;
  int take;
  Function(List<FilterExpression>) onChange;
  Function(List<FilterExpression>, List<ZCollectionItem>) onScroll;

  ZCollectionList(
      {this.lista,
      this.key,
      this.theme,
      this.titulo: "",
      this.ultimoValor,
      this.color,
      this.skip: 0,
      this.take: 0,
      this.onChange,
      this.filtroPrincipal,
      this.onScroll})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ZCollectionListState();
}

class ZCollectionListState extends State<ZCollectionList> {
  List<ZCollectionItem> _listaFiltro;
  ScrollController scrollController;
  GlobalKey keyLista = new GlobalKey();
  String textoBusca = "";

  @override
  void initState() {
    _listaFiltro = <ZCollectionItem>[];
    scrollController = new ScrollController();
    scrollController.addListener(_scrollListener);
    _initList();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: widget.theme.backgroundColor,
      appBar: new AppBar(
          backgroundColor: widget.color,
          leading: IconeVoltar(
            context: context,
          ),
          centerTitle: true,
          title: new Container(
            child: new Text(
              widget.titulo.toUpperCase(),
              style: new TextStyle(color: Colors.white),
            ),
          )),
      body: new Column(
        children: <Widget>[
          _buildFiltro(),
          new Expanded(
              child: new Container(
            margin: EdgeInsets.only(top: 16.0),
            child: _buildLista(),
          ))
        ],
      ),
    );
  }

  Widget _buildFiltro() {
    return new Material(
        elevation: 5,
        child: new Row(
          children: <Widget>[
            new Expanded(
              flex: 85,
              child: new Container(
                margin: const EdgeInsets.only(bottom: 6, top: 6.0),
                child: new Container(
                  height: 36,
                  margin: EdgeInsets.only(left: 16, right: 2),
                  decoration: BoxDecoration(
                      color: Color(0xfff0f0f0),
                      borderRadius: BorderRadius.all(Radius.circular(9.0))),
                  child: new Row(
                    children: <Widget>[
                      new Container(
                          padding: EdgeInsets.only(left: 8.0),
                          child: new Icon(
                            Icons.search,
                            color: Color(0xff999999),
                          )),
                      new Expanded(
                          child: new CupertinoTextField(
                        placeholderStyle: new TextStyle(
                            color: Color(0xff999999), fontSize: 17),
                        placeholder: "Busca",
                        decoration:
                            new BoxDecoration(color: Colors.transparent),
                        onChanged: (text) {
                          if (text.length >= 3 || text.length == 0) {
                            if (widget.onChange != null) {
                              textoBusca = text;
                              widget.onChange([
                                new FilterExpression(
                                    propertyName: widget.filtroPrincipal.key,
                                    operatorBetween: "AndAlso",
                                    operator: "Contains",
                                    value: text)
                              ]);
                            } else {
                              text = text.toLowerCase();
                              keyLista = new GlobalKey();
                              setState(() {
                                if (text.length > 0)
                                  _listaFiltro = widget.lista
                                      .where((x) =>
                                          x.valor.toLowerCase().contains(text))
                                      .toList();
                                else
                                  _listaFiltro = widget.lista;
                              });
                            }
                          }
                        },
                      )),
                    ],
                  ),
                ),
              ),
            ),
            new Expanded(
                flex: 15,
                child: new IconButton(
                    icon: new Icon(
                      Icons.filter_list,
                      color: widget.color,
                    ),
                    onPressed: () {}))
          ],
        ));
  }

  Widget _buildLista() {
    return ListView.builder(
      key: keyLista,
      itemCount: _listaFiltro.length,
      controller: scrollController,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var item = _listaFiltro[index];
        return new Column(
          children: [
            new Container(
              alignment: Alignment.topCenter,
              color: Colors.white,
              child: new ZTile(
                  onTap: () {
                    _selecionarItem(item);
                  },
                  leading: new Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: new Text(
                      _retornaTextoDoItem(_listaFiltro[index].ordem, _listaFiltro, index),
                      style: widget.theme.textTheme.bodyText1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
            ),
            new Divider(
              height: 2,
              color: widget.theme.backgroundColor,
            ),
          ],
        );
      },
    );
  }

  String _retornaTextoDoItem(String ordemItem, List<ZCollectionItem> listaFiltro, int index){
    if(ordemItem == "Z"){
      return "* ${listaFiltro[index].titulo ?? listaFiltro[index].valor}";
    }else{
      return "${listaFiltro[index].titulo ?? listaFiltro[index].valor} ";
    }
  }


  void _selecionarItem(ZCollectionItem item) {
    Navigator.of(context).pop(item);
  }

  Future<void> _initList() {
    if (widget.take == 0) {
      setState(() {
        _listaFiltro = widget.lista;
      });
    } else {
      var listaSkipTake =
          widget.lista.skip(widget.skip).take(widget.take).toList();

      if (listaSkipTake != null && listaSkipTake.length > 0) {
        setState(() {
          _listaFiltro.addAll(listaSkipTake);
          widget.skip += widget.take;
        });
      }
    }
  }

  Future<void> _scrollListener() async {
    if (widget.take > 0) {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        var listaSkipTake =
            widget.lista.skip(widget.skip).take(widget.take).toList();
        if (listaSkipTake != null && listaSkipTake.length > 0) {
          setState(() {
            _listaFiltro.addAll(listaSkipTake);
            widget.skip += widget.take;
          });
        }
      }
    }
    if (widget.onScroll != null) {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        widget.onScroll([
          new FilterExpression(
              propertyName: widget.filtroPrincipal.key,
              operatorBetween: "AndAlso"
                  "",
              operator: "Contains",
              value: textoBusca)
        ], _listaFiltro);
      }
    }
  }

  void atualizarLista(List<ZCollectionItem> lista) {
    if (mounted) {
      setState(() {
        _listaFiltro = lista;
      });
    }
  }
}
