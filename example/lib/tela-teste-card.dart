import 'package:flutter/material.dart';
import 'package:z_components/components/z-item-tile-usuario-adm.dart';
import 'package:z_components/components/z-item-tile-modulo-adm.dart';
import 'package:z_components/components/z-inputs/z-input-cpf.dart';
import 'package:z_components/components/z-aba/z-aba.dart';
import 'package:z_components/components/z-aba/z-aba-viewmodel.dart';
import 'package:z_components/components/z-item-tile-os.dart';
import 'package:z_components/components/z-header.dart';

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
            ZHeader(
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
              dataSla: "17/08/2001",
              visibilidade:false,
              emAndamento: true,
              onPressedFinalizar: () {
                print("tap no icone");
              },
              onTap: (){
                print("tap no card");
              },
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
            ),

          ],
        ),
      ),
    );
  }
}
