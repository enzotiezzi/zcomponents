import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/view-model/lancamento-ocorrencia-viewmodel.dart';

class DialogOcorrencia extends StatefulWidget {
  List<ZLancamentoOcorrenciaViewModel> listaOcorrenciaViewModel;

  DialogOcorrencia({this.listaOcorrenciaViewModel});

  @override
  _DialogOcorrenciaState createState() => _DialogOcorrenciaState();
}

class _DialogOcorrenciaState extends State<DialogOcorrencia> {
  @override
  Widget build(BuildContext context) {
    double _largura = MediaQuery.of(context).size.width;
    double _altura = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _buildBody(_largura, _altura),
    );
  }

  Widget _buildBody(_largura, _altura) {
    return new Column(
      children: <Widget>[
        new Expanded(
          child: new ListView.builder(
              itemCount: widget.listaOcorrenciaViewModel.length,
              itemBuilder: (context, index) =>
                  _itemOcorrencia(_largura, index, _altura)),
        ),
        new GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: new Container(
            color: Colors.transparent,
            padding: EdgeInsets.all(10.0),
            child: new Container(
                height: MediaQuery.of(context).size.height / 15.8,
                width: MediaQuery.of(context).size.width / 8.9,
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                child: new Center(
                  child: new Icon(
                    Icons.close,
                    color: const Color(0xff707070),
                    size: (MediaQuery.of(context).size.width < 360) ? 16 : 24.0,
                  ),
                )),
          ),
        )
      ],
    );
  }

  Widget _itemOcorrencia(_largura, index, _altura) {
    var item = widget.listaOcorrenciaViewModel[index];
    return new Column(
      children: <Widget>[
        (index == 0)
            ? new Container(
                color: Colors.transparent,
                height: _altura / 3,
              )
            : new Container(),
        new Container(
          child: new ZAlertDialog(
            zDialog: ZDialog.alert,
            child: new Column(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(top: 8.0, bottom: 2.0),
                  child: new Row(
                    children: <Widget>[
                      new Container(
                        width: _largura / 2.8,
                        margin: EdgeInsets.only(left: 8.0),
                        child: new Text(
                          "Data da Ocorrência",
                          style: TextStyle(
                              color: const Color(0xff999999), fontSize: 12.0),
                        ),
                      ),
                      new Container(
                        child: new Text(
                          _montarData(item.dataOcorrencia),
                          style: TextStyle(fontSize: 12.0),
                        ),
                      )
                    ],
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(bottom: 2.0),
                  child: new Row(
                    children: <Widget>[
                      new Container(
                        width: _largura / 2.8,
                        margin: EdgeInsets.only(left: 8.0),
                        child: new Text(
                          "Título da Ocorrência",
                          style: TextStyle(
                              color: const Color(0xff999999), fontSize: 12.0),
                        ),
                      ),
                      new Container(
                        child: new Text(
                          item.nomeOcorrencia,
                          style: TextStyle(fontSize: 12.0),
                        ),
                      )
                    ],
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(bottom: 2.0),
                  child: new Row(
                    children: <Widget>[
                      new Container(
                        width: _largura / 2.8,
                        margin: EdgeInsets.only(left: 8.0),
                        child: new Text(
                          "Justificativa",
                          style: TextStyle(
                              color: const Color(0xff999999), fontSize: 12.0),
                        ),
                      ),
                      new Container(
                        width: _largura / 2.8,
                        child: new Text(
                          item.nomeJustificativa,
                          style: TextStyle(fontSize: 12.0),
                        ),
                      )
                    ],
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  child: new Row(
                    children: <Widget>[
                      new Container(
                        width: _largura / 2.8,
                        margin: EdgeInsets.only(left: 8.0),
                        child: new Text(
                          "Observação",
                          style: TextStyle(
                              color: const Color(0xff999999), fontSize: 12.0),
                        ),
                      ),
                      new Container(
                        child: new Text(""),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  String _montarData(text) {
    var splitDataI = text.split("T");
    var novoText = splitDataI[0].split("-");
    String novaData = "${novoText[2]}/${novoText[1]}/${novoText[0]}";
    return novaData;
  }
}
