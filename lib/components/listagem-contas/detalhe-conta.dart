import 'dart:typed_data';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/utils/icone-voltar.dart';
import 'package:z_components/view-model/conta-v2-viewmodel.dart';
import '../../z-item-tile-conta.dart';
import 'detalhe-conta-view.dart';

class DetalheConta extends StatefulWidget {
  ContaV2ViewModel contaV2ViewModel;
  ThemeData themeData;
  String token;
  Function(ContaV2ViewModel) onAccountChange;

  DetalheConta(
      {this.contaV2ViewModel,
      this.themeData,
      this.token,
      this.onAccountChange});

  @override
  _DetalheContaState createState() => _DetalheContaState();
}

class _DetalheContaState extends State<DetalheConta> {
  DetalheContaViewModel _view;

  @override
  void initState() {
    _view = DetalheContaViewModel(this);
    _view.initView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor:  widget.themeData.primaryColor,
        leading: IconeVoltar(
          context: context,
        ),
        centerTitle: true,
        title: new Text("CONTA"),
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
              animatedWidgetFollowingHeader: new Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
              header: new Expanded(
                  child: new Container(
                padding: EdgeInsets.all(16.0),
                child: new Text(
                  widget.contaV2ViewModel.conta.nome,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )),
              children: [
                new Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: new ZItemTileConta(
                    imagemPerfil:
                        _montarImagem(widget.contaV2ViewModel.conta.logo),
                    tamanhoLista: widget.contaV2ViewModel.appLista.length,
                    visibilidade: true,
                    dataVinculo: (widget.contaV2ViewModel.dataVinculo != null)
                        ? UtilData.obterDataDDMMAAAA(
                            DateTime.parse(widget.contaV2ViewModel.dataVinculo))
                        : "Nunca",
                    appsVinculados: _view
                        .listarAppsVinculados(widget.contaV2ViewModel.appLista),
                    ativo: widget.contaV2ViewModel.contaLogada,
                    nomeConta: widget.contaV2ViewModel.conta.nome ?? "",
                  ),
                )
              ],
            )),
        _montarInfosConta(),
        exibirBotaoModificar()
      ],
    );
  }

  Widget _montarInfosConta() {
    return new Container(
      margin: EdgeInsets.only(top: 2.0),
      child: new Column(
        children: [
          new Container(
            color: Colors.white,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 20, right: 16, left: 16, bottom: 20),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  child: new Text("Aplicativos"),
                ),
                new Container(
                  margin: EdgeInsets.only(top: 6.0),
                  child: new Row(
                    children: [
                      new Container(
                        margin: EdgeInsets.only(right: 4.0),
                        padding: EdgeInsets.only(
                            top: 4.0, bottom: 4, left: 6, right: 6),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(6)),
                        child: new Text(
                            widget.contaV2ViewModel.appLista.length.toString()),
                      ),
                      new Text(
                        _view.listarAppsVinculados(
                            widget.contaV2ViewModel.appLista),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: 1.0),
            color: Colors.white,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 20, right: 16, left: 16, bottom: 20),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  child: new Text("Data de vínculo"),
                ),
                new Container(
                  margin: EdgeInsets.only(top: 6.0),
                  child: new Text(
                    UtilData.obterDataDDMMAAAA(
                        DateTime.parse(widget.contaV2ViewModel.dataVinculo)),
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget exibirBotaoModificar() {
    if (!widget.contaV2ViewModel.contaLogada) {
      return new Container(
        padding: EdgeInsets.only(top: 20.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // ignore: deprecated_member_use
            new RaisedButton(
              onPressed: () {
                _view.showDialogContaSelecionada();
              },
              child: new Container(
                child: new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    new Container(
                      padding: const EdgeInsets.only(right: 40, left: 40),
                      child: Text(
                        "TROCAR CONTA",
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              color:  widget.themeData.accentColor,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.only(left: 10, right: 10),
            )
          ],
        ),
      );
    } else {
      return Container(
          padding: EdgeInsets.only(top: 20.0),
          child: new Text(
            "Você está utilizando esta conta no momento.",
            style: TextStyle(color:  widget.themeData.primaryColor),
          ));
    }
  }

  Widget _montarImagem(Uint8List logo) {
    if (logo != null) {
      return new Container(
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(6.0), topLeft: Radius.circular(6.0)),
          image: new DecorationImage(
            image: MemoryImage(logo),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else
      return new Container();
  }
}
