import 'package:flutter/material.dart';
import 'package:z_components/components/z-collection/z-collection-item.dart';
import 'package:z_components/components/z-collection/z-collection.dart';
import 'package:z_components/interface/i-zcargo-service.dart';
import 'package:z_components/view-model/cargo-viewmodel.dart';
import 'package:z_components/api/zcargo-service.dart';

class ZCargo extends StatefulWidget {
  final String? token;
  final Key? key;
  final ValueChanged<ZCollectionItem>? onChange;
  final String? valorPadrao;

  ZCargo({this.key, @required this.token, this.onChange, this.valorPadrao});

  @override
  State<StatefulWidget> createState() => ZCargoState();
}

class ZCargoState extends State<ZCargo> {
  ZCollectionItem? _itemSelecionado;

  ZCollectionItem? get itemSelecionado => _itemSelecionado;

  late IZCargoService _service;

  var _keyZCollection = new GlobalKey<ZCollectionState>();

  List<CargoViewModel> _cargos = [];

  @override
  void initState() {
    _service = new ZCargoService(widget.token!);
    _listarCargos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new ZCollection(
      titulo: "Cargos",
      lista: _cargos
          .map((x) => new ZCollectionItem(
              chave: x.idCargo, titulo: x.nome, valor: x.nome))
          .toList(),
      onChange: (item) {
        _itemSelecionado = item;
        if (widget.onChange != null) widget.onChange!(item);
      },
      valorPadrao: widget.valorPadrao,
      key: _keyZCollection,
    );
  }

  void _listarCargos() async {
    var cargos = await _service.listarCargos();

    if (cargos != null && cargos.length > 0) {
      setState(() {
        _cargos = cargos;
      });
      _keyZCollection.currentState?.buscarValorPadrao(_cargos
          .map((x) => new ZCollectionItem(
              chave: x.idCargo, titulo: x.nome, valor: x.nome))
          .toList());
    }
  }
}
