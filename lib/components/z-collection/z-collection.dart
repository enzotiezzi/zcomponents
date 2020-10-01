import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-collection/z-collection-item.dart';
import 'package:z_components/components/z-collection/z-collection-list.dart';
import 'package:z_components/styles/main-style.dart';

class ZCollection extends StatefulWidget {
  final String titulo;
  final List<ZCollectionItem> lista;
  final ThemeData themeData;
  final ValueChanged<ZCollectionItem> onChange;
  final String valorPadrao;
  final Color colorStyle;
  final int skip;
  final int take;

  ZCollection({
    Key key,
    @required this.titulo,
    @required this.lista,
    @required this.themeData,
    this.onChange,
    this.valorPadrao,
    this.colorStyle: const Color(0xff2bbab4),
    this.skip: 0,
    this.take: 0,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ZCollectionState();
}

class ZCollectionState extends State<ZCollection> {
  ZCollectionItem _itemSelecionado  = new ZCollectionItem();
  String _anterior = "Selecione";

  ZCollectionItem get itemSelecionado => _itemSelecionado;

  @override
  void initState() {
    buscarValorPadrao(widget.lista);
    //setarvalor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Column(
        children: <Widget>[
          new Container(
            height: 42,
            decoration: BoxDecoration(
                color: Colors.white,
               ),
            padding: EdgeInsets.only(left: 16.0, right: 14),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 45,
                  fit: FlexFit.tight,
                  child: new RichText(
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    text: TextSpan(
                      style: widget.themeData.textTheme.bodyText1.copyWith(color: Color(0xff999999)),
                      text: widget.titulo,
                    ),
                  ),
                ),
                Flexible(
                  flex: 55,
                  fit: FlexFit.tight,
                  child: new RichText(
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    softWrap: false,
                    text: TextSpan(
                        style: widget.themeData.textTheme.bodyText1,
                        text: (_itemSelecionado?.valor == null &&
                            _anterior == "Selecione")
                            ? _anterior
                            : _itemSelecionado?.valor),
                  ),
                ),
                Flexible(
                  flex: 10,
                  fit: FlexFit.tight,
                  child: new Icon(Icons.keyboard_arrow_right),
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: _irParaSelecaoDeItemHorizontal,
    );
  }

  void buscarValorPadrao(List<ZCollectionItem> lista) {
    if (lista != null && lista.length > 0) {
      if (widget.valorPadrao != null) {
        var vP =
            lista.where((lista) => lista.chave == widget.valorPadrao).first;
        if (vP != null) {
          setState(() {
            _itemSelecionado = vP;
          });
        }
      }
    }
  }

  void setarvalor() {
    if (_itemSelecionado?.valor != null) {
      setState(() {
        _anterior = _itemSelecionado?.valor;
      });
    }
  }

/*
  return ZCollectionList(
  lista: widget.lista,
  titulo: widget.titulo,
  );
*/

  void _irParaSelecaoDeItemHorizontal() async {
    _itemSelecionado = await Navigator.push<ZCollectionItem>(
        context,
        new PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation animation,
              Animation secondaryAnimation) {
            return ZCollectionList(
              lista: widget.lista,
              titulo: widget.titulo,
              ultimoValor: _itemSelecionado,
              color: widget.colorStyle,
              skip: widget.skip,
              take: widget.take,
            );
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: new SlideTransition(
                position: new Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(1.0, 0.0),
                ).animate(secondaryAnimation),
                child: child,
              ),
            );
          },
        ));
    if (widget.onChange != null) widget.onChange(_itemSelecionado);

    setState(() {});
  }
}
