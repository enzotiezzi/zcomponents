import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:z_components/view-model/conta-v2-viewmodel.dart';
import '../../z-item-tile-conta.dart';
import 'detalhe-conta-view.dart';

class DetalheConta extends StatefulWidget {
  ContaV2ViewModel contaV2ViewModel;
  ThemeData themeData;

  DetalheConta({this.contaV2ViewModel, this.themeData});

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
      appBar: AppBar(
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
            child: new Container(
              margin: EdgeInsets.only(top: 10.0),
              child: new ZItemTileConta(
                visibilidade: true,
                dataVinculo: (widget.contaV2ViewModel.dataVinculo != null)
                    ? UtilData.obterDataDDMMAAAA(
                        DateTime.parse(widget.contaV2ViewModel.dataVinculo))
                    : "Nunca",
                appsVinculados: _view
                    .listarAppsVinculados(widget.contaV2ViewModel.appLista),
                ativo: widget.contaV2ViewModel.contaLogada,
                nomeConta: widget.contaV2ViewModel.nomeConta ?? "",
              ),
            )),
        exibirBotaoModificar()
      ],
    );
  }

  Widget exibirBotaoModificar() {
    if (!widget.contaV2ViewModel.contaLogada) {
      return new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // ignore: deprecated_member_use
              new RaisedButton(
                onPressed: () {},
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
                color: Theme.of(context).accentColor,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.only(left: 10, right: 10),
              )
            ],
          )

      ;
    } else {
      return Container();
    }
  }
}
