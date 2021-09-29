import 'package:flutter/material.dart';
import 'package:z_components/components/z-perfil-item.dart';
import 'package:z_components/components/informacoes-organizacao/informacoes-organizacao.dart';
import 'package:z_components_example/tela-teste-card.dart';
import 'package:z_components/components/fluxo-admin/usuarios.dart';
import 'package:z_components/components/listagem-contas/listagem-contas.dart';
import 'package:z_components/components/fluxo-admin/modulos.dart';
import 'package:z_components/components/z-user-info/z-user-info.dart';
import 'package:z_components/view-model/buscarinfo-viewmodel.dart';
import 'package:z_components/components/utils/novo_token.dart';
import 'package:z_components/components/z-estrutura-empresa/bloc/z-estrutura-empresa-cubit.dart';
import 'package:z_components/components/z-estrutura-empresa/z-estrutura-empresa.dart';

class MainComponents extends StatefulWidget {
  @override
  _MainComponentsState createState() => _MainComponentsState();
}

class _MainComponentsState extends State<MainComponents> {
  ZEstruturaEmpresaCubit bloc = new  ZEstruturaEmpresaCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text("ZAdmin"),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TelaTesteCard()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildBody() {
    return new Container(
      margin: EdgeInsets.only(
        top: 20.0,
        left: 10.0,
        right: 10.0,
      ),
      child: new ZPerfilItem(
        numeroQuadrados: 5,
        listaIcones: [Icons.add, Icons.add, Icons.add, Icons.add, Icons.add],
        listaOnTap: [
              () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InformacoesOrganizacao(
                      themeData: Theme.of(context),
                      editarDados: false,
                      textoFoto: "",
                      idConta: "3f2bdcbb-764f-48c7-0c33-08d7cf63e45b",
                      infoOrganizacaoViewModel: null,
                    )));
          },
              () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Usuarios(
                      themeData: Theme.of(context),
                    )));
          },
              () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Modulos(
                      themeData: Theme.of(context),
                    )));
          },
              () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListagemContas(
                      themeData: Theme.of(context),token: NovoToken.newToken,
                    )));
          }

          ,(){

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ZUserInfo(userInfo: new BuscarInfo(),
                    )));
          }
        ],
        listaTextos: ["Info. de Organizacão", "Usuários", "Módulos", "Contas", "Meu Perfil"],
      ),
    );
  }

  Widget _buildEstruturaEmpresa(){
    return new ZEstruturaEmpresa(
      key: null,
      bloc: bloc,
      token: "[TOKEN A SER UTILIZADO]",
    );
  }
}
