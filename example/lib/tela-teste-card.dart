import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-item-tile-convite.dart';
import 'package:z_components/components/z-selection/z-selection-item.dart';
import 'package:z_components/components/z-collection/z-collection-item.dart';
import 'package:z_components/components/z-collection/z-collection.dart';
import 'package:z_components/components/utils/icone-voltar.dart';
import 'package:z_components/view-model/item-tile-convite-viewmodel.dart';

class TelaTesteCard extends StatefulWidget {
  @override
  _TelaTesteCardState createState() => _TelaTesteCardState();
}

class _TelaTesteCardState extends State<TelaTesteCard> {
  List<ZSelectionItem> listaSelecao = [];
  List<ZSelectionItem> listaSelecaoRespostas = [];

  final zEstrutura = new GlobalKey();

  TextEditingController cep = new TextEditingController();
  TextEditingController logradouro = new TextEditingController();
  TextEditingController numero = new TextEditingController();
  TextEditingController cidade = new TextEditingController();
  TextEditingController bairro = new TextEditingController();
  TextEditingController complemento = new TextEditingController();
  TextEditingController estado = new TextEditingController();
  List<ZCollectionItem> lista = [];

  GlobalKey<ZCollectionState> keyPorte = new GlobalKey<ZCollectionState>();

  List<ZCollectionItem> listaPorte = [
    ZCollectionItem(valor: "T-E-S-T", chave: "TesteChave", titulo: "Teste"),
    ZCollectionItem(valor: "Teste2", chave: "Teste2", titulo: "Teste2"),
    ZCollectionItem(valor: "Teste3", chave: "Teste3", titulo: "Teste3"),
    ZCollectionItem(valor: "Teste4", chave: "Teste4", titulo: "Teste4"),
    ZCollectionItem(valor: "Teste5", chave: "Teste5", titulo: "Teste5"),
  ];

  @override
  void initState() {
    listaSelecao = [
      new ZSelectionItem(
          chave: "Universidade", titulo: "Universidade", valor: "Universidade"),
      new ZSelectionItem(
          chave: "1",
          titulo:
              "Instalador de isolantes térmicos de caldeira e tubulações de teste 123 testando overflow",
          valor: "Instalador de isolantes térmicos de caldeira e tubulações"),
      new ZSelectionItem(chave: "2", titulo: "2", valor: "2"),
      new ZSelectionItem(chave: "3", titulo: "3", valor: "3"),
      new ZSelectionItem(chave: "4", titulo: "4", valor: "4"),
      new ZSelectionItem(chave: "5", titulo: "5", valor: "5"),
      new ZSelectionItem(chave: "6", titulo: "6", valor: "6"),
      new ZSelectionItem(chave: "7", titulo: "7", valor: "7"),
      new ZSelectionItem(chave: "8", titulo: "8", valor: "8"),
      new ZSelectionItem(chave: "9", titulo: "9", valor: "9"),
      new ZSelectionItem(chave: "10", titulo: "10", valor: "10"),
      new ZSelectionItem(chave: "11", titulo: "11", valor: "11"),
      new ZSelectionItem(chave: "12", titulo: "12", valor: "12"),
      new ZSelectionItem(chave: "13", titulo: "13", valor: "13"),
      new ZSelectionItem(chave: "14", titulo: "14", valor: "14"),
      new ZSelectionItem(chave: "15", titulo: "15", valor: "15"),
      new ZSelectionItem(chave: "16", titulo: "16", valor: "16"),
      new ZSelectionItem(chave: "17", titulo: "17", valor: "17"),
      new ZSelectionItem(chave: "18", titulo: "18", valor: "18"),
      new ZSelectionItem(chave: "19", titulo: "19", valor: "19"),
      new ZSelectionItem(chave: "20", titulo: "20", valor: "20"),
    ];
    listaSelecaoRespostas = [
      new ZSelectionItem(chave: "2", titulo: "2", valor: "2"),
      new ZSelectionItem(chave: "3", titulo: "3", valor: "3"),
      new ZSelectionItem(chave: "4", titulo: "4", valor: "4"),
    ];
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconeVoltar(
          context: context,
        ),
        title: new Text(
          "TESTE DOS Z-CARDS",
          style: new TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: new Column(children: [
        new Container(
          height: 7,
        ),
        new ZItemTileConvite(
          itemTileViewModel: new ItemTileViewModel(
            nome: "Matheus Albuquerque",
            status: "Lido",
            icone: selectIcon(SelectStatus.LIDO),
            dataAdmissao: "02/06/2021",
            cargo: "Desenvolvedor Mobile",
            porcentagemPreenchimento: "80%",
            prazo: "4 Dias",
          ),
          onTileIsSelected: () {
            print("OI");
          },
        ),
        new ZItemTileConvite(
          itemTileViewModel: new ItemTileViewModel(
            nome: "Monica Guerra",
            status: "Em andamento",
            icone: selectIcon(SelectStatus.EM_ANDAMENTO),
            dataAdmissao: "14/09/2019",
            cargo: "Designer",
            porcentagemPreenchimento: "30%",
            prazo: "3 Dias",
          ),
          onTileIsSelected: () {
            print("OII");
          },
        ),
        new ZItemTileConvite(
          itemTileViewModel: new ItemTileViewModel(
            nome: "Justino Braga",
            status: "Finalizado",
            icone: selectIcon(SelectStatus.FINALIZADO),
            dataAdmissao: "06/11/2012",
            cargo: "Desenvolvedor backend",
            porcentagemPreenchimento: "21%",
            prazo: "9 Dias",
          ),
          onTileIsSelected: () {
            print("OII");
          },
        ),
        new ZItemTileConvite(
          itemTileViewModel: new ItemTileViewModel(
            nome: "Laura Ambev",
            status: "Aprovado",
            icone: selectIcon(SelectStatus.APROVADO),
            dataAdmissao: "31/07/2014",
            cargo: "Desenvolvedor Java",
            porcentagemPreenchimento: "71%",
            prazo: "8 Dias",
          ),
        ),
        new ZItemTileConvite(
          itemTileViewModel: new ItemTileViewModel(
            nome: "Eduardo Silva",
            status: "Não Lido",
            icone: selectIcon(SelectStatus.NAO_LIDO),
            dataAdmissao: "04/12/2020",
            cargo: "Desenvolvedor Web",
            porcentagemPreenchimento: "50%",
            prazo: "7 Dias",
          ),
        ),
        new ZItemTileConvite(
          itemTileViewModel: new ItemTileViewModel(
            nome: "Adriano Imperador",
            status: "Vencido",
            icone: selectIcon(SelectStatus.VENCIDO),
            dataAdmissao: "17/02/2002",
            cargo: "CEO",
            porcentagemPreenchimento: "14%",
            prazo: "15 Dias",
          ),
        ),
      ]),
    );
  }

  Widget selectIcon(SelectStatus selectStatus) {
    switch (selectStatus) {
      case SelectStatus.EM_ANDAMENTO:
        return new Container(
            child: new Icon(
          Icons.article_outlined,
          size: 14,
          color: new Color(0xff2BBAB4),
        ));

      case SelectStatus.FINALIZADO:
        return new Container(
            child: new Icon(
          Icons.sd_card_outlined,
          size: 14,
          color: new Color(0xff2BBAB4),
        ));
      case SelectStatus.APROVADO:
        return new Container(
            child: new Icon(
          Icons.check_circle_outline,
          size: 14,
          color: new Color(0xff2BBAB4),
        ));

      case SelectStatus.NAO_LIDO:
        return new Container(
            child: new Icon(
          Icons.remove_red_eye_outlined,
          size: 14,
          color: Colors.red,
        ));
      case SelectStatus.LIDO:
        return new Container(
            child: new Icon(
          Icons.remove_red_eye_outlined,
          size: 14,
          color: new Color(0xff2BBAB4),
        ));

      case SelectStatus.VENCIDO:
        return new Container(
          child: new Icon(
            Icons.circle,
            color: Colors.red,
            size: 8,
          ),
        );
    }
  }
}
