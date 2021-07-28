import 'package:flutter/material.dart';
import 'package:z_components/components/z-item-tile-usuario-adm.dart';
import 'package:z_components/components/z-item-tile-modulo-adm.dart';
import 'package:z_components/components/z-inputs/z-input-cpf.dart';
import 'package:z_components/components/z-aba/z-aba.dart';
import 'package:z_components/components/z-aba/z-aba-viewmodel.dart';
import 'package:z_components/components/z-item-tile-os.dart';
import 'package:z_components/components/z-header.dart';
import 'package:z_components/components/z-inputs/z-input-cnpj.dart';
import 'package:z_components/components/z-selection/z-selection.dart';
import 'package:z_components/components/z-selection/z-selection-item.dart';

class TelaTesteCard extends StatefulWidget {
  @override
  _TelaTesteCardState createState() => _TelaTesteCardState();
}

class _TelaTesteCardState extends State<TelaTesteCard> {
  List<ZSelectionItem> listaSelecao = [];

  @override
  void initState() {
    listaSelecao = [
      ZSelectionItem(
          chave: "Universidade", titulo: "Universidade", valor: "Universidade"),
      ZSelectionItem(chave: "1", titulo: "1", valor: "1"),
      ZSelectionItem(chave: "2", titulo: "2", valor: "2"),
      ZSelectionItem(chave: "3", titulo: "3", valor: "3"),
      ZSelectionItem(chave: "4", titulo: "4", valor: "4"),
      ZSelectionItem(chave: "5", titulo: "5", valor: "5"),
      ZSelectionItem(chave: "6", titulo: "6", valor: "6"),
      ZSelectionItem(chave: "7", titulo: "7", valor: "7"),
      ZSelectionItem(chave: "8", titulo: "8", valor: "8"),
      ZSelectionItem(chave: "9", titulo: "9", valor: "9"),
      ZSelectionItem(chave: "10", titulo: "10", valor: "10"),
      ZSelectionItem(chave: "11", titulo: "11", valor: "11"),
      ZSelectionItem(chave: "12", titulo: "12", valor: "12"),
      ZSelectionItem(chave: "13", titulo: "13", valor: "13"),
      ZSelectionItem(chave: "14", titulo: "14", valor: "14"),
      ZSelectionItem(chave: "15", titulo: "15", valor: "15"),
      ZSelectionItem(chave: "16", titulo: "16", valor: "16"),
      ZSelectionItem(chave: "17", titulo: "17", valor: "17"),
      ZSelectionItem(chave: "18", titulo: "18", valor: "18"),
      ZSelectionItem(chave: "19", titulo: "19", valor: "19"),
      ZSelectionItem(chave: "20", titulo: "20", valor: "20"),
    ];
    super.initState();
  }

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
            /*    ZHeader(
              titulo: "Minhas Ordens de Serviço",
            ),
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
            SizedBox(
              height: 10,
            ),
            ZItemTileModuloAdm(
              nomeModulo: "Módulo",
              perfilAcesso: "Perfil",
              statusVinculo: "Ativo",
              dataExpiracao: "20/05/2020",
              dataVinculo: "01/09/2018",
            ),
            ZItemTileOS(
              codigo: "012192102910",
              onde: "Zellar Vital Brasil > Banheiro",
              oque: "Zellar Vital Brasil > Banheiro",
              porque: "Dispenser Papel",
              prioridade: "Baixa",
              dataSla: "",
              visibilidade: false,
              emAndamento: true,
              onPressedFinalizar: () {
                print("tap no icone");
              },
              onTap: () {
                print("tap no card");
              },
            ),
            ZItemTileOS(
              codigo: "012192102910",
              onde: "Zellar Vital Brasil > Banheiro",
              oque: "Zellar Vital Brasil > Banheiro",
              porque: "Dispenser Papel",
              prioridade: "Baixa",
              dataSla: "",
              visibilidade: true,
              emAndamento: false,
              onPressedFinalizar: () {
                print("tap no icone");
              },
              onTap: () {
                print("tap no card");
              },
            ),
            ZInputCPF(
              themeData: Theme.of(context),
              cpfFocus: new FocusNode(),
              controllerCpf: new TextEditingController(),
              validacao: (b) {},
            ),
            ZInputCNPJ(
              themeData: Theme.of(context),
              cnpjFocus: new FocusNode(),
              controllerCNPJ: new TextEditingController(),
              validacao: (b) {},
            ),*/
            new Container(
              margin: EdgeInsets.only(top: 10),
              child: ZSelection(
                  themeData: Theme.of(context),
                  titulo: "Teste Seleção",
                  onChange: (value) {
                    listaSelecao = value;
                  },
                  lista: listaSelecao),
            )
            /*   ZAba(
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
            ),*/
          ],
        ),
      ),
    );
  }
}
