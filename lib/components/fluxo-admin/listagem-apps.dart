import 'package:brasil_fields/brasil_fields.dart';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/fluxo-admin/usuarios.dart';
import 'package:z_components/components/modulo/detalhe-modulo.dart';
import 'package:z_components/components/utils/icone-voltar.dart';
import 'package:z_components/components/z-item-tile-modulo-adm.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';
import 'package:z_components/view-model/usuario-conta-viewmodel.dart';

import '../z-item-tile-usuario-adm.dart';
import 'listagem-apps-view.dart';

class ListagemApps extends StatefulWidget {
  List<AppUsuarioContaViewModel> listaApps;
  UsuarioContaViewModel usuario;

  ListagemApps({this.listaApps, this.usuario});

  @override
  _ListagemAppsState createState() => _ListagemAppsState();
}

class _ListagemAppsState extends State<ListagemApps> {
  ListagemAppsView _view;

  AppUsuarioContaViewModel result;

  @override
  void initState() {
    _view = ListagemAppsView(this);
    print("lista app");
    print(widget.listaApps);
    _view.initView();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    print("lista did");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconeVoltar(context: context),
        centerTitle: true,
        title: new Text("USUÁRIO"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return new Column(
      children: [
        new Material(
            elevation: 4,
            child: new ConfigurableExpansionTile(
              initiallyExpanded: true,
              onExpansionChanged: (bool) {
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
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: new Text(
                          widget.usuario.usuario.nome,
                          style: new TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: MainStyle.get(context).fontSizePadrao),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              animatedWidgetFollowingHeader: new Container(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child:
                    new Icon(Icons.arrow_drop_down, color: Color(0xffE6E6E6)),
              ),
              children: [
                new Divider(
                  height: 1.0,
                ),
                new Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: new ZItemTileUsuarioAdm(
                    visibilidade: true,
                    nomeUsuario: widget.usuario.usuario.nome,
                    email: widget.usuario.usuario.email,
                    quantidadeApps: widget.usuario.appLista.length.toString(),
                    status: widget.usuario.status,
                    telefone: widget.usuario.usuario.telefone,
                    appsVinculados:
                        _view.listarAppsVinculados(widget.usuario.appLista),
                  ),
                )
              ],
            )),
        new Expanded(
          child: _ListarModulos(),
        )
      ],
    );
  }

  Widget _ListarModulos() {
    return new ListView.builder(
        padding: EdgeInsets.only(top: 20.0),
        shrinkWrap: true,
        itemCount: widget.listaApps.length,
        itemBuilder: (builder, index) =>
            _montarCardUsuario(widget.listaApps[index]));
  }

  Widget _montarCardUsuario(AppUsuarioContaViewModel app) {
    return new Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: new Material(
        elevation: 4,
        child: new ConfigurableExpansionTile(
          initiallyExpanded: false,
          onExpansionChanged: (bool) {},
          borderColorStart: Color(0xffcccccc),
          borderColorEnd: Color(0xffcccccc),
          header: new Expanded(
            child: new Container(
              //color: Colors.white,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: new Text(
                      app.app.nomeExibicao,
                      style: new TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: MainStyle.get(context).fontSizePadrao),
                    ),
                  ),
                ],
              ),
            ),
          ),
          animatedWidgetFollowingHeader: new Container(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: new Icon(
              Icons.unfold_less,
              color: Color(0xffcccccc),
            ),
          ),
          children: [
            Divider(
              height: 1.0,
            ),
            new ZItemTileModuloAdm(
              dataExpiracao: (app.dataInativacao != null)
                  ? UtilData.obterDataDDMMAAAA(
                      DateTime.parse(app.dataInativacao))
                  : "Nunca",
              dataVinculo: (app.dataVinculo != null)
                  ? UtilData.obterDataDDMMAAAA(DateTime.parse(app.dataVinculo))
                  : "Nunca",
              nomeModulo: app.app.nomeExibicao,
              perfilAcesso: retornaPerfil(app.perfil.nome),
              statusVinculo: retornaStatus(app.status),
              onTap: () async{
                print(widget.usuario.toString());
                print(app.toMap());
                final resultado  = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetalheModulo(
                              cliqueEditar: false,
                              editarDados: false,
                              appUsuarioContaViewModel: app,
                              usuario: widget.usuario,
                            )));
                
               setState(() {
                 result = resultado;
               });

              },
            )
          ],
        ),
      ),
    );
  }
  
  String retornaPerfil (String app){
    if(result ==null  || result.perfil.nome == null || result.perfil.nome.isEmpty){
        if(app==null|| app.isEmpty ){
          return "Não contém perfil";
        }else{
          return app;
        }
    }else{
      return result.perfil.nome;
    }
  }
  
  String retornaStatus (String app){
    if (result==null || result.status.isEmpty){
      return app;
    }else{
      return result.status;
    }
  }
}
