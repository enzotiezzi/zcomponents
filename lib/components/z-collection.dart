import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-collection-item.dart';
import 'package:z_components/components/z-collection-list.dart';

class ZCollection extends StatefulWidget {
  final String titulo;
  final List<ZCollectionItem> lista;
  final ValueChanged<ZCollectionItem> onChange;
  final String valorPadrao;

  ZCollection(
      {Key key,
      this.titulo: "Z Collection",
      this.lista,
      this.onChange,
      this.valorPadrao})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ZCollectionState();
}

class ZCollectionState extends State<ZCollection> {
  ZCollectionItem _itemSelecionado;

  ZCollectionItem get itemSelecionado => _itemSelecionado;

  @override
  void initState() {
    super.initState();
    _itemSelecionado = new ZCollectionItem();
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
              child: new Text(
                widget.titulo,
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            new Expanded(
                child: ListTile(
              title: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  (_itemSelecionado?.valor == null)
                      ? new Text(
                          "Selecione",
                          style: new TextStyle(
                            color: Colors.grey,
                          ),
                        )
                      : new Text(
                          "${_itemSelecionado?.valor ?? ""}",
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

  void buscarValorPadrao( List<ZCollectionItem> lista) {

    if (lista != null && lista.length > 0) {
      if (widget.valorPadrao != null) {
        var vP = lista
            .where((lista) => lista.chave == widget.valorPadrao)
            .first;
        if (vP != null) {
          setState(() {
            _itemSelecionado = vP;
          });
        }
      }
    }

  }


  void _irParaSelecaoDeItemHorizontal() async {
    _itemSelecionado = await Navigator.push<ZCollectionItem>(
        context,
        new PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation animation,
              Animation secondaryAnimation) {
            return ZCollectionList(
              lista: widget.lista,
              titulo: widget.titulo,
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
