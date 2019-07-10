import 'package:flutter/material.dart';
import 'package:z_components/components/z-collection-item.dart';
import 'package:z_components/components/z-collection.dart';
import 'package:z_components/interface/i-zcargo-service.dart';
import 'package:z_components/view-model/cargo-viewmodel.dart';
import 'package:z_components/api/zcargo-service.dart';

class ZCargo extends StatefulWidget {
  final String token;
  Key key;

  ZCargo({Key key, this.token}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ZCargoState();
}

class ZCargoState extends State<ZCargo> {
  ZCollectionItem _itemSelecionado;

  ZCollectionItem get itemSelecionado => _itemSelecionado;

  var key = new GlobalKey<ZCollectionState>();

  IZCargoService _service;

  var _cargos = new List<CargoViewModel>();

  @override
  void initState() {
    _service = new ZCargoService(widget.token);
    _listarCargos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new ZCollection(
      key: key,
      titulo: "Cargos",
      lista: _cargos
          .map((x) => new ZCollectionItem(
              chave: x.idCargo, titulo: x.nome, valor: x.nome))
          .toList(),
      onChange: (item) {
        _itemSelecionado = item;
      },
    );
  }

  void _listarCargos() async {
    var cargos = await _service.listarCargos();

    if (cargos != null) {
      setState(() {
        _cargos = cargos;
      });
    }
  }
}
