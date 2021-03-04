import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/filtro-campo.dart';
import 'package:z_components/components/z-collection/z-collection-item.dart';
import 'package:z_components/styles/main-style.dart';

class ZCollectionList extends StatefulWidget {
  GlobalKey key;
  final List<ZCollectionItem> lista;
  final ThemeData theme;
  final String titulo;
  final ZCollectionItem ultimoValor;
  final color;
  final FiltroCampo filtroPrincipal;
  int skip;
  int take;
  Function(List<FilterExpression>) onChange;

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
      this.filtroPrincipal})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZCollectionListState();
}

class _ZCollectionListState extends State<ZCollectionList> {
  List<ZCollectionItem> _listaFiltro;
  ScrollController scrollController;

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
      appBar: new CupertinoNavigationBar(
          backgroundColor: widget.color,
          leading: new GestureDetector(
            onTap: () => _selecionarItem(widget.ultimoValor),
            child: new Container(
              padding: EdgeInsets.only(right: 20.0),
              color: Colors.transparent,
              child: new Icon(
                Icons.arrow_back_ios,
                size: 20.0,
                color: Colors.white,
              ),
            ),
          ),
          middle: new Container(
            child: new Text(
              widget.titulo,
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
                          if (text.length > 3) {
                            if (widget.onChange != null) {
                              widget.onChange([
                                new FilterExpression(
                                    propertyName: widget.filtroPrincipal.key,
                                    operatorBetween: "OrElse",
                                    operator: "Contains",
                                    value: text)
                              ]);
                            } else {
                              text = text.toLowerCase();
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
      itemCount: _listaFiltro.length,
      controller: scrollController,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var item = _listaFiltro[index];
        return new Column(
          children: [
            new Container(
              height: 42,
              color: Colors.white,
              child: new ListTile(
                onTap: () {
                  _selecionarItem(item);
                },
                title: new Text(
                  "${item.titulo ?? item.valor}",
                  style: widget.theme.textTheme.bodyText1,
                ),
              ),
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
  }
}
