import 'package:brasil_fields/brasil_fields.dart';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/fluxo-admin/listagem-usuario-view.dart';
import 'package:z_components/components/z-item-tile-modulo-adm.dart';
import 'package:z_components/components/z-item-tile-usuario-adm.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';
import 'package:z_components/view-model/app-view-model.dart';
import 'package:z_components/view-model/modulo-conta-viewmodel.dart';


class ListagemUsuarios extends StatefulWidget {
  AppViewModel appViewModel;
  ModuloContaViewModel moduloContaViewModel;
  ListagemUsuarios({this.appViewModel,this.moduloContaViewModel});
  @override
  _ListagemUsuariosState createState() => _ListagemUsuariosState();
}

class _ListagemUsuariosState extends State<ListagemUsuarios> {

  ListagemUsuariosView _view;
  @override
  void initState() {
    _view = ListagemUsuariosView(this);
    _view.initView();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("LISTAGEM USUÁRIO"),
      ),
      body: _buildBody(),
    );
  }
  Widget _buildBody(){
   return new Column(
      children: [
        new Material(
            elevation: 4,
            child:  ConfigurableExpansionTile(
              initiallyExpanded: false,
              onExpansionChanged: (bool){
                setState(() {
                  _view.icons2 = bool;
                });
              },
              borderColorStart: Color(0xffcccccc),
              borderColorEnd: Color(0xffcccccc),
              header: new Expanded(
                child: new Container(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 16),
                        padding: const EdgeInsets.only(top: 8,bottom: 8),
                        child: new Text(
                          widget.appViewModel.nomeExibicao,
                          style: new TextStyle(
                              color:Colors.black,
                              fontWeight:FontWeight.w500,
                              fontSize: MainStyle.get(context).fontSizePadrao
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              animatedWidgetFollowingHeader: new Container(
                padding: const EdgeInsets.only(top: 8,bottom: 8),
                child:(_view.icons2 == true)
                    ? new Icon(Icons.arrow_drop_up, color: Color(0xffE6E6E6))
                    : new Icon(Icons.arrow_drop_down, color: Color(0xffE6E6E6)),
              ),
              children: [
                Divider(height: 1,),
                new Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: ZItemTileModuloAdm(
                    visibilidade: true,
                    nomeModulo: widget.appViewModel.nomeExibicao,
                    statusVinculo: widget.moduloContaViewModel.status,
                    perfilAcesso: "Não possui",
                    dataVinculo: (widget.moduloContaViewModel.dataVinculo != null)
                        ? UtilData.obterDataDDMMAAAA(DateTime.parse(widget.moduloContaViewModel.dataVinculo))
                        : "Nunca",
                    dataExpiracao:(widget.moduloContaViewModel.dataInativacao != null)
                        ? UtilData.obterDataDDMMAAAA(DateTime.parse(widget.moduloContaViewModel.dataInativacao))
                        : "Nunca",
                  ),
                ),
              ],
            ),
        ),
        Expanded(
          child: _listaUsuarios(),
        )
      ],
    );
  }
  Widget _listaUsuarios (){
    if(_view.listaUsuarioPorApp != null){
      return
      new ListView.builder(
          padding: EdgeInsets.only(top: 20.0),
          shrinkWrap: true,
          itemCount: _view.listaUsuarioPorApp.length,
          itemBuilder: (builder, index) =>
              _montarCardUsuario(_view.listaUsuarioPorApp[index]));
    }else{
      return new Container();
    }
  }

  Widget _montarCardUsuario(AppUsuarioContaViewModel app) {
    return new Container(
      child: new ZItemTileUsuarioAdm(
        nomeUsuario: app.usuario.nome,
        status: app.status,
        telefone: app.usuario.telefone,
        email: app.usuario.email,
        appsVinculados: _listarAppsVinculados(_view.listaUsuarioPorApp),
        quantidadeApps: _view.listaUsuarioPorApp.length.toString(),
        onTap: () {},
      ),
    );
  }

  String _listarAppsVinculados(List<AppUsuarioContaViewModel> lista) {
    String appsFormatados = "";
    if (lista != null && lista.length != 0) {
      for (int i = 0; i < lista.length; i++) {
        if (i == 0) {
          appsFormatados = "$appsFormatados- ${lista[i].app.nome}";
        } else {
          appsFormatados = "$appsFormatados, ${lista[i].app.nome}";
        }
      }
    } else {
      appsFormatados = "Sem apps vinculados";
    }
    return appsFormatados;
  }
}
