import 'package:flutter/material.dart';
import 'package:z_components/api/zlocal-service.dart';
import 'package:z_components/components/z-collection-item.dart';
import 'package:z_components/components/z-collection.dart';
import 'package:z_components/interface/i-zlocal-service.dart';
import 'package:z_components/view-model/centrocusto-viewmodel.dart';

class ZLocal extends StatefulWidget {
  final String token;
  final String idEmpresa;
  Key key;


  ZLocal({  Key key
  ,this.token, this.idEmpresa}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ZLocalState();
}

class ZLocalState extends State<ZLocal> {
  ZCollectionItem _itemSelecionado;

  ZCollectionItem get itemSelecionado => _itemSelecionado;

  var key = new GlobalKey<ZCollectionState>();

  IZLocalService _service;

  var _centroCustos = new List<CentroCustoViewModel>();

  @override
  void initState() {
    _service = new ZLocalService(widget.token, widget.idEmpresa);
    _listarLocais();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new ZCollection(
      key: key,
      titulo: "Locais",
      lista: _centroCustos
          .map((x) => new ZCollectionItem(
          chave: x.idCentroCusto, titulo: x.nome, valor: x.nome))
          .toList(),
      onChange: (item) {
        _itemSelecionado = item;
      },
    );
  }

  void _listarLocais() async {
    var centroCustos = await _service.listarCentrosCusto();

    if (centroCustos != null) {
      setState(() {
        _centroCustos = centroCustos;
      });
    }
  }
}
