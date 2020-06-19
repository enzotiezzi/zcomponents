import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-collection-item.dart';
import 'package:z_components/components/z-collection-list.dart';
import 'package:z_components/components/z-tile.dart';
import 'package:z_components/styles/main-style.dart';

class ZCollection extends StatefulWidget {
  final String titulo;
  final List<ZCollectionItem> lista;
  final ValueChanged<ZCollectionItem> onChange;
  final String valorPadrao;
  final Color colorStyle;

  ZCollection(
      {Key key,
      @required this.titulo,
      @required this.lista,
      this.onChange,
      this.valorPadrao,
      this.colorStyle: const Color(0xff2bbab4)})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ZCollectionState();
}

class ZCollectionState extends State<ZCollection> {
  ZCollectionItem _itemSelecionado;
  String _anterior = "Selecione";

  ZCollectionItem get itemSelecionado => _itemSelecionado;

  @override
  void initState() {
    buscarValorPadrao(widget.lista);
    _itemSelecionado = new ZCollectionItem();
    //setarvalor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey))),
        padding: EdgeInsets.only(left: 16.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Container(
              width: 130,
              child: new Text(widget.titulo,
                  style: MainStyle.get(context).mainStyleTextBaseLine),
            ),
            new Expanded(
                child: ZTile(
              leading: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  (_itemSelecionado?.valor == null && _anterior == "Selecione")
                      ? new Text(
                          _anterior,
                          style:
                              MainStyle.get(context).mainStyleTextBaseLineHint,
                        )
                      : new Text(
                          (_itemSelecionado?.valor.length > 14)
                              ? "${_itemSelecionado?.valor.substring(0, 14) ?? ""}..."
                              : _itemSelecionado?.valor,
                          style: new TextStyle(
                            color: Colors.grey,
                          ),
                        )
                ],
              ),
              trailing: new Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ))
          ],
        ),
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
