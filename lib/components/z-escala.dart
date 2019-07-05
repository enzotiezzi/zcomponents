import 'package:flutter/material.dart';
import 'package:z_components/api/zescala-service.dart';
import 'package:z_components/components/z-collection-item.dart';
import 'package:z_components/components/z-collection.dart';
import 'package:z_components/interface/i-zescala-service.dart';
import 'package:z_components/view-model/EscalaViewModel.dart';

class ZEscala extends StatefulWidget {
  final String token;

  ZEscala({Key key, this.token}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ZEscalaState();
}

class ZEscalaState extends State<ZEscala> {
  ZCollectionItem _itemSelecionado;

  ZCollectionItem get itemSelecionado => _itemSelecionado;

  var _keyEscala = new GlobalKey<ZCollectionState>();

  IZEscalaService _service;

  var _escalas = new List<EscalaViewModel>();

  @override
  void initState() {
    _service = new ZEscalaService(widget.token);
    _listarEscalas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new ZCollection(
      key: _keyEscala,
      titulo: "Escalas",
      lista: _escalas
          .map((x) => new ZCollectionItem(
          chave: x.idEscala, titulo: x.nome, valor: x.nome))
          .toList(),
      onChange: (item) {
        _itemSelecionado = item;
      },
    );
  }

  void _listarEscalas() async {
    var escalas = await _service.listarEscalas();

    if (escalas != null) {
      setState(() {
        _escalas = escalas;
      });
    }
  }
}
