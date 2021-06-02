import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/fluxo-admin/listagem-aplicativos-view.dart';
import 'package:z_components/components/fluxo-admin/listagem-usuario-view.dart';
import 'package:z_components/components/fluxo-admin/listagem-usuario.dart';
import 'package:z_components/components/z-item-tile-modulo-adm.dart';
import 'package:z_components/components/z-item-tile-modulo-gestao.dart';
import 'package:z_components/view-model/app-view-model.dart';
import 'package:z_components/view-model/modulo-conta-viewmodel.dart';

class ListagemAplicativos extends StatefulWidget {
  ModuloContaViewModel moduloContaViewModel;

  ListagemAplicativos({this.moduloContaViewModel});

  @override
  _ListagemAplicativosState createState() => _ListagemAplicativosState();
}

class _ListagemAplicativosState extends State<ListagemAplicativos> {
  ListagemAplicativosView _view;

  @override
  void initState() {
    _view = ListagemAplicativosView(this);
    _view.initView();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("APLICATIVOS"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody (){
    return new Column(
      children: [
        new Material(
          elevation: 4,
          child: new Container(
              margin: EdgeInsets.only(top: 10.0),
              child: ZItemTileModuloGestao(
                visibilidade: true,
                status: widget.moduloContaViewModel.status,
                nomeModulo: widget.moduloContaViewModel.modulo.nome,
              ),
          ),
        ),
        Expanded(
          child: _listarAplicativos(),
        )
      ],
    );
  }

  Widget _listarAplicativos(){
    return new ListView.builder(
      padding: EdgeInsets.only(top: 20.0),
      shrinkWrap: true,
      itemCount: _view.listaModulos.length,
      itemBuilder: (context,index)=>
      _montarCardAplicativo(_view.listaModulos[index]),
    );
  }

  Widget _montarCardAplicativo (AppViewModel appViewModel){
    print(appViewModel.nome);
    return ZItemTileModuloAdm(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context)=>
                    ListagemUsuarios(
                      moduloContaViewModel: widget.moduloContaViewModel,
                      appViewModel: appViewModel,
                    )
            )
        );
      },
      nomeModulo: appViewModel.nome,
      statusVinculo: widget.moduloContaViewModel.status,
      perfilAcesso: "Não possui",
      dataVinculo: (widget.moduloContaViewModel.dataVinculo != null)
          ? UtilData.obterDataDDMMAAAA(DateTime.parse(widget.moduloContaViewModel.dataVinculo))
          : "Nunca",
      dataExpiracao:(widget.moduloContaViewModel.dataInativacao != null)
          ? UtilData.obterDataDDMMAAAA(DateTime.parse(widget.moduloContaViewModel.dataInativacao))
          : "Nunca",
      );
  }
}
