import 'package:flutter/material.dart';
import 'package:z_components/api/zescala-service.dart';
import 'package:z_components/components/z-collection-item.dart';
import 'package:z_components/components/z-collection.dart';
import 'package:z_components/interface/i-zescala-service.dart';
import 'package:z_components/view-model/escala-viewmodel.dart';

class ZEscala extends StatefulWidget {
  final String token;
  final Key key;
  final ValueChanged<ZCollectionItem> onChange;
  final String valorPadrao;


  ZEscala({this.key, @required this.token, this.onChange, this.valorPadrao});

  @override
  State<StatefulWidget> createState() => ZEscalaState();
}

class ZEscalaState extends State<ZEscala> {
  ZCollectionItem _itemSelecionado;

  ZCollectionItem get itemSelecionado => _itemSelecionado;

  IZEscalaService _service;

  var _keyZCollection = new GlobalKey<ZCollectionState>();

  var _escalas = new List<EscalaViewModel>();

  @override
  void initState() {
    super.initState();
    _service = new ZEscalaService(widget.token);
    _listarEscalas();
  }

  @override
  Widget build(BuildContext context) {
    return new ZCollection(
        titulo: "Escalas",
        lista: _escalas
            .map((x) => new ZCollectionItem(
                chave: x.escala, titulo: x.nome, valor: x.escala))
            .toList(),
        onChange: (item) {
          _itemSelecionado = item;
          if (widget.onChange != null) widget.onChange(item);
        },
      valorPadrao: widget.valorPadrao,
      key: _keyZCollection,

        );

  }

  void _listarEscalas() async {
    var escalas = await _service.listarEscalas();

    if (escalas != null && escalas.length > 0) {
      setState(() {
        _escalas = escalas;
      });
      _keyZCollection.currentState.buscarValorPadrao(_escalas
          .map((x) => new ZCollectionItem(
          chave: x.escala, titulo: x.nome, valor: x.escala))
          .toList());
    }
  }
}
