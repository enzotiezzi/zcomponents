import 'package:flutter/material.dart';
import 'package:z_components/api/zlocal-service.dart';
import 'package:z_components/components/z-collection-item.dart';
import 'package:z_components/components/z-collection.dart';
import 'package:z_components/interface/i-zlocal-service.dart';
import 'package:z_components/view-model/centrocusto-viewmodel.dart';

class ZLocal extends StatefulWidget {
  final String token;
  final ValueChanged<ZCollectionItem> onChange;
  final String idEmpresa;
  final Key key;
  final String valorPadrao;

  ZLocal(
      {this.key,
      @required this.token,
      @required this.idEmpresa,
      this.onChange,
      this.valorPadrao});

  @override
  State<StatefulWidget> createState() => ZLocalState();
}

class ZLocalState extends State<ZLocal> {
  ZCollectionItem _itemSelecionado;

  ZCollectionItem get itemSelecionado => _itemSelecionado;

  IZLocalService _service;

  var _keyZCollection = new GlobalKey<ZCollectionState>();

  var _centroCustos = new List<CentroCustoViewModel>();

  @override
  void initState() {
    super.initState();
    _service = new ZLocalService(widget.token, widget.idEmpresa);
    _listarLocais();
  }

  @override
  Widget build(BuildContext context) {
    return new ZCollection(
      titulo: "Locais",
      lista: _centroCustos
          .map((x) => new ZCollectionItem(
              chave: x.idCentroCusto, titulo: x.nome, valor: x.nome))
          .toList(),
      onChange: (item) {
        _itemSelecionado = item;
        if (widget.onChange != null) widget.onChange(item);
      },
      valorPadrao: widget.valorPadrao,
      key: _keyZCollection,
    );
  }

  void _listarLocais() async {
    var centroCustos = await _service.listarCentrosCusto();

    if (centroCustos != null && centroCustos.length > 0) {
      setState(() {
        _centroCustos = centroCustos;
      });

      _keyZCollection.currentState.buscarValorPadrao(_centroCustos
          .map((x) => new ZCollectionItem(
              chave: x.idCentroCusto, titulo: x.nome, valor: x.nome))
          .toList());
    }
  }
}
