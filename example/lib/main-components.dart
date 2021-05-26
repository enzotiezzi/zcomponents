import 'package:flutter/material.dart';
import 'package:z_components/components/z-perfil-item.dart';
import 'package:z_components/components/informacoes-organizacao/informacoes-organizacao.dart';
import 'package:z_components/components/usuarios/usuarios.dart';

class MainComponents extends StatefulWidget {
  @override
  _MainComponentsState createState() => _MainComponentsState();
}

class _MainComponentsState extends State<MainComponents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text("ZAdmin"),
      ),
      body: _buildBody(),
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
        numeroQuadrados: 4,
        listaIcones: [Icons.add, Icons.add, Icons.add, Icons.add],
        listaOnTap: [
          () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InformacoesOrganizacao(
                          themeData: Theme.of(context),
                          editarDados: false,
                          textoFoto: "",
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
          () {},
          () {}
        ],
        listaTextos: ["Info. de Organizacão", "Usuários", "Módulos", "Contas"],
      ),
    );
  }
}
