import 'dart:math';

import 'package:flutter/material.dart';
import 'package:z_components/components/z-item-tile-usuario-adm.dart';
import 'package:z_components/components/z-item-tile-modulo-adm.dart';
import 'package:z_components/components/z-inputs/z-input-cpf.dart';
import 'package:z_components/components/z-aba/z-aba.dart';
import 'package:z_components/components/z-aba/z-aba-viewmodel.dart';
import 'package:z_components/components/z-item-tile-os.dart';
import 'package:z_components/components/z-header.dart';
import 'package:z_components/components/z-inputs/z-input-cnpj.dart';
import 'package:z_components/components/z-endereco/z-input-endereco.dart';
import 'package:z_components/components/z-collection/z-collection.dart';
import 'package:z_components/components/z-collection/z-collection-item.dart';

class TelaTesteCard extends StatefulWidget {
  @override
  _TelaTesteCardState createState() => _TelaTesteCardState();
}

class _TelaTesteCardState extends State<TelaTesteCard> {
  TextEditingController cep = new TextEditingController();
  TextEditingController logradouro = new TextEditingController();
  TextEditingController numero = new TextEditingController();
  TextEditingController cidade = new TextEditingController();
  TextEditingController bairro = new TextEditingController();
  TextEditingController complemento = new TextEditingController();
  TextEditingController estado = new TextEditingController();
  List<ZCollectionItem> lista=[];

  @override
  Widget build(BuildContext context) {
  print("card");
    print(cep.text);
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
              dataSla: "",
              visibilidade:false,
              emAndamento: true,
              onPressedFinalizar: () {
                print("tap no icone");
              },
              onTap: (){
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
              visibilidade:true,
              emAndamento: false,
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
            ZInputCNPJ(
              themeData: Theme.of(context),
              cnpjFocus: new FocusNode(),
              controllerCNPJ: new TextEditingController(),
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
            ZInputEndereco(
              themeData: Theme.of(context),
              campoObrigatorio: true,
              cepController: cep,
              bairroController: bairro,
              cidadeController: cidade,
              complementoController: complemento,
              estadoController: estado,
              logradouroController: logradouro,
              numeroController: numero,
            ),

          ],
        ),
      ),
    );
  }
}
