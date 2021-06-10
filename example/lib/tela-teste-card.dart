import 'package:flutter/material.dart';
import 'package:z_components/components/z-item-tile-usuario-adm.dart';
import 'package:z_components/components/z-item-tile-modulo-adm.dart';
import 'package:z_components/components/modulo/detalhe-modulo.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';
import 'package:z_components/components/z-inputs/z-input-data-expiracao.dart';
import 'package:z_components/components/z-inputs/z-input-cpf.dart';
import 'package:z_components/components/z-item-tile-modulo-gestao.dart';
import 'package:z_components/components/fluxo-admin/detalhe-usuario.dart';
import 'package:z_components/view-model/usuario-adm-viewmodel.dart';
import 'package:z_components/view-model/app-view-model.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:z_components/components/z-aba/z-aba.dart';
import 'package:z_components/components/z-aba/z-aba-viewmodel.dart';

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
                telefone: "(11)961479207",
                onTap: () {},
                quantidadeApps: "3",
              ),
            ),
            SizedBox(height: 10,),
            ZItemTileModuloAdm(
              nomeModulo: "Módulo",
              perfilAcesso: "Perfil",
              statusVinculo: "Ativo",
              dataExpiracao: "20/05/2020",
              dataVinculo: "01/09/2018",
            ),
            ZItemTileModuloGestao(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetalheUsuario(
                              editarDados: false,
                              cliqueEditar: false,
                              appUsuarioContaViewModel:
                                  new AppUsuarioContaViewModel(
                                      status: "Ativo",
                                      dataVinculo: (null != null)
                                          ? UtilData.obterDataDDMMAAAA(
                                              DateTime.parse(null))
                                          : "Nunca",
                                      dataInativacao: "",
                                      app: new AppViewModel(nome: "Teste"),
                                      usuario: new UsuarioAdmViewModel(
                                          nome: "Teste")),
                            )));
              },
              nomeModulo: "Quadro pessoal",
              status: "Ativo",
              visibilidade: true,
            ),
            ZInputCPF(
              themeData: Theme.of(context),
              cpfFocus: new FocusNode(),
              controllerCpf: new TextEditingController(),
              validacao: (b) {},
            ),
            ZAba(
              zAbaViewModel: [
                ZAbaViewModel(
                  icon: Icon(Icons.person),
                    onTap: () {
                      print("1");
                    },
                    titulo: "UF(Estados)"),

                ZAbaViewModel(
                    onTap: () {
                      print("2");
                    },
                    titulo: "Feriados"),

              ],
            )
          ],
        ),
      ),
    );
  }
}
