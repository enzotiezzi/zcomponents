import 'package:flutter/material.dart';
import 'package:z_components/api/zempresa-service.dart';
import 'package:z_components/components/z-collection/z-collection-item.dart';
import 'package:z_components/components/z-collection/z-collection.dart';
import 'package:z_components/interface/i-zempresa-service.dart';
import 'package:z_components/view-model/company-components-viewmodel.dart';

class ZEmpresa extends StatefulWidget {
  final String? token;
  final ValueChanged<ZCollectionItem>? onChange;
  final String? idUser;
  final Key? key;
  final String? valorPadrao;

  ZEmpresa(
      {this.key,
      @required this.token,
      @required this.idUser,
      this.onChange,
      this.valorPadrao});

  @override
  State<StatefulWidget> createState() => ZEmpresaState();
}

class ZEmpresaState extends State<ZEmpresa> {
  ZCollectionItem? _itemSelecionado;

  ZCollectionItem? get itemSelecionado => _itemSelecionado;

  late IZEmpresaService _service;

  var _keyZCollection = new GlobalKey<ZCollectionState>();

  List<CompanyViewModel> _empresas = [];

  @override
  void initState() {
    super.initState();
    _service = new ZEmpresaService(widget.token!, widget.idUser);
    _listarLocais();
  }

  @override
  Widget build(BuildContext context) {
    return new ZCollection(
      titulo: "Empresas",
      lista: _empresas
          .map((x) => new ZCollectionItem(
              chave: x.idEmpresa, titulo: x.nome, valor: x.nome))
          .toList(),
      onChange: (item) {
        _itemSelecionado = item;
        if (widget.onChange != null) widget.onChange!(item);
      },
      valorPadrao: widget.valorPadrao,
      key: _keyZCollection,
    );
  }

  void _listarLocais() async {
    var listaEmpresa = await _service.list();

    if (listaEmpresa != null && listaEmpresa.length > 0) {
      setState(() {
        _empresas = listaEmpresa;
      });

      _keyZCollection.currentState?.buscarValorPadrao(listaEmpresa
          .map((x) => new ZCollectionItem(
              chave: x.idEmpresa, titulo: x.nome, valor: x.nome))
          .toList());
    }
  }
}
