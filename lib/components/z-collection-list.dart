import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-collection-item.dart';

class ZCollectionList extends StatefulWidget {
  final List<ZCollectionItem> lista;
  final String titulo;

  ZCollectionList({this.lista, this.titulo: ""});

  @override
  State<StatefulWidget> createState() => _ZCollectionListState();
}

class _ZCollectionListState extends State<ZCollectionList> {
  List<ZCollectionItem> _listaFiltro;

  @override
  void initState() {
    _listaFiltro = widget.lista;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new CupertinoNavigationBar(
          leading: new GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: new Container(
              padding: EdgeInsets.only(right: 20.0),
              color: Colors.transparent,
              child: new Icon(
                Icons.arrow_back_ios,
                size: 20.0,
                color: const Color(0xff2BB9B4),
              ),
            ),
          ),
          middle: new Container(
            child: new Text(widget.titulo),
          )),
      body: new Column(
        children: <Widget>[_buildFiltro(), new Expanded(child: _buildLista())],
      ),
    );
  }

  Widget _buildFiltro() {
    return new Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border:
          Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2)))),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Container(
              padding: EdgeInsets.all(7.0),
              margin: EdgeInsets.only(left: 8.0),
              decoration: BoxDecoration(
                  color: const Color(0xff8E8E93).withOpacity(0.2),
                  borderRadius: BorderRadius.all(Radius.circular(9.0))),
              child: new Container(
                width: MediaQuery.of(context).size.width / 1.25,
                child: new TextField(
                  decoration: InputDecoration.collapsed(hintText: "Busca"),
                  style: TextStyle(fontSize: 19.0, color: Colors.black),
                  onChanged: (text) {
                    text = text.toLowerCase();
                    setState(() {
                      if(text.length > 0)
                        _listaFiltro = widget.lista.where((x) => x.valor.toLowerCase().contains(text)).toList();
                      else
                        _listaFiltro = widget.lista;
                    });
                  },
                ),
              )),
          new IconButton(
              icon: Icon(
                Icons.filter_list,
                color: const Color(0xff2FA9A2),
              ),
              onPressed: null)
        ],
      ),
    );
  }

  Widget _buildLista() {
    return ListView.builder(
      itemCount: _listaFiltro.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var item = _listaFiltro[index];
        if(_listaFiltro[index].valor.length > 16)
          {
            _listaFiltro[index].valor = "${_listaFiltro[index].valor.substring(0, 16)}...";
          }
        return new ListTile(
          onTap: () => _selecionarItem(item),
          title: new Text("${item.titulo ?? item.valor}"),
          trailing: new Icon(
            Icons.chevron_right,
            color: Colors.grey,
          ),
        );
      },
    );
  }

  void _selecionarItem(ZCollectionItem item){
    Navigator.of(context).pop(item);
  }
}
