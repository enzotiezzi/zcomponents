import 'package:flutter/material.dart';
import 'package:z_components/components/fluxo-admin/listagem-usuario-view.dart';

class ListagemUsuarios extends StatefulWidget {
  @override
  _ListagemUsuariosState createState() => _ListagemUsuariosState();
}

class _ListagemUsuariosState extends State<ListagemUsuarios> {

  ListagemUsuariosView _view;
  @override
  void initState() {
    _view = ListagemUsuariosView(this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("APLICATIVOS"),
      ),
    );
  }
}
