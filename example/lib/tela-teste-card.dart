import 'package:flutter/material.dart';
import 'package:z_components/components/z-item-tile-usuario-adm.dart';
import 'package:z_components/components/z-item-tile-modulo-adm.dart';

class TelaTesteCard extends StatefulWidget {
  @override
  _TelaTesteCardState createState() => _TelaTesteCardState();
}

class _TelaTesteCardState extends State<TelaTesteCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Container(

          child: new Text(
            "Teste dos cards",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 16),
              child: new ZItemTileUsuarioAdm(
                email: "luiz.sousa@zellar.com.br",
                appsVinculados: "Z Chamados, Quadro Pessoal, Lançamento",
                nomeUsuario: "Luiz Fernando",
                status: "Ativo",
                onTap: (){},
                quantidadeApps: "3",
              ),
            ),
            SizedBox(height: 10,),
            ZItemTileModuloAdm(
              nomeModulo: "Módulo",
              perfilAcesso: "Perfil",
              statusVinculo: "Revogado",
              dataExpiracao: "20/05/2020",
              dataVinculo: "01/09/2018",
            )
          ],
        ),
      ),
    );
  }
}
