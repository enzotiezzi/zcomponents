import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/processo-seletivo.dart';

class ZCardProcessoSeletivo extends StatefulWidget {
  final ThemeData themeData;
  final ProcessoSeletivoViewModel processoSeletivo;

  ZCardProcessoSeletivo(
      {@required this.themeData, @required this.processoSeletivo});

  @override
  State<StatefulWidget> createState() => _ZCardProcessoSeletivoState();
}

class _ZCardProcessoSeletivoState extends State<ZCardProcessoSeletivo> {
  double size = 14.0;
  Color color = const Color(0xFF707070);

  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: 3,
      child: new Padding(
        padding: const EdgeInsets.all(0.0),
        child: new Column(
          children: [
            new Container(
              padding: const EdgeInsets.all(8.0),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Column(
                    children: [
                      new Text(
                        widget.processoSeletivo.descricao,
                        style: widget.themeData.textTheme.bodyText2.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ],
                  ),
                  new Column(
                    children: [
                      new Row(
                        children: [
                          new Text(
                            widget.processoSeletivo.codigo,
                            style: new TextStyle(fontSize: size, color: color),
                          ),
                          new Text(
                              widget.processoSeletivo.diasEmAberto.toString(),
                              style:
                                  new TextStyle(fontSize: size, color: color))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            new Container(
              color: widget.themeData.backgroundColor,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(1.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Container(
                        margin: const EdgeInsets.all(2.0),
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Container(
                              padding: EdgeInsets.only(right: 4.0),
                              child: new Icon(
                                Icons.work_outline,
                                size: size,
                                color: color,
                              ),
                            ),
                            new Text(
                              widget.processoSeletivo.nomeCargo,
                              style:
                                  new TextStyle(fontSize: size, color: color),
                            )
                          ],
                        ),
                      ),
                      new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Icon(
                            Icons.attach_money,
                            color: color,
                            size: size,
                          ),
                          new Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: new Text(
                              "${tipoSalario()}/${widget.processoSeletivo.periodicidadePagamento},${widget.processoSeletivo.tipoContrato}",
                              style:
                                  new TextStyle(fontSize: size, color: color),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  new Container(
                    padding: EdgeInsets.only(left: 8.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Container(
                              padding: EdgeInsets.only(right: 4.0),
                              child: new Icon(
                                Icons.location_on,
                                color: color,
                                size: size,
                              ),
                            ),
                            new Text(widget.processoSeletivo.localidade,
                                style:
                                    new TextStyle(fontSize: size, color: color))
                          ],
                        ),
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Container(
                                padding: EdgeInsets.only(right: 4.0),
                                child: new Icon(
                                  Icons.money,
                                  color: color,
                                  size: size,
                                )),
                            new Text(widget.processoSeletivo.beneficios,
                                style:
                                    new TextStyle(fontSize: size, color: color))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            new Container(
              padding: const EdgeInsets.all(8.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Row(
                        children: [
                          new Icon(
                            Icons.wysiwyg,
                            color: color,
                            size: size,
                          ),
                          new Text(
                              "ETAPA ${widget.processoSeletivo.progressoEtapa}",
                              style: new TextStyle(
                                  fontSize: size,
                                  color: color,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ],
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Row(
                        children: [
                          new Icon(
                            Icons.work_outline,
                            color: color,
                            size: size,
                          ),
                          new Text(
                              "${widget.processoSeletivo.qtdeParticipantesAtual}",
                              style: new TextStyle(
                                  fontSize: size,
                                  fontWeight: FontWeight.bold,
                                  color: color)),
                          new Icon(
                            Icons.people,
                            color: color,
                            size: size,
                          ),
                          new Text("                       "),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String tipoSalario() {
    if (widget.processoSeletivo.salarioFixoOuFaixa.toUpperCase() == "FIXO") {
      return widget.processoSeletivo.salarioValorFixo.toStringAsFixed(2);
    } else {
      return "${widget.processoSeletivo.salarioValorFaixaInicial.toStringAsFixed(2)} até ${widget.processoSeletivo.salarioValorFaixaFinal.toStringAsFixed(2)}";
    }
  }
}
