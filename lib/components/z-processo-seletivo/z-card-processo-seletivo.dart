import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/processo-seletivo.dart';

class ZCardProcessoSeletivo extends StatefulWidget {
  final ThemeData? themeData;
  final ProcessoSeletivoViewModel? processoSeletivo;

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
                        _retornarDescricao(),
                        style: widget.themeData!.textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ],
                  ),
                  new Column(
                    children: [
                      new Row(
                        children: [
                          new Text(
                            _retornarCodigo(),
                            style: new TextStyle(fontSize: size, color: color),
                          ),
                          new Text(
                              _retornarDiasEmAberto(),
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
              color: widget.themeData!.backgroundColor,
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
                             _retornarCargo(),
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
                              "${tipoSalario()}/${_retornarPeriodicidadePagamento()},${_retornarTipoContrato()!}",
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
                            new Container(
                              width: MediaQuery.of(context).size.width / 3.2,
                              child:
                              new Text(_retornarLocalidade(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: new TextStyle(
                                    fontSize: size,
                                    color: color,
                                  )),
                            )
                          ],
                        ),
                        new Container(
                          padding: EdgeInsets.only(top: 4),
                          child: new Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              new Container(
                                  padding: EdgeInsets.only(right: 4.0),
                                  child: new Icon(
                                    Icons.money,
                                    color: color,
                                    size: size,
                                  )),
                              new Container(
                                width: MediaQuery.of(context).size.width / 3.2,
                                child: new Text(
                                   _retornarBeneficios(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: new TextStyle(
                                        fontSize: size, color: color)),
                              )
                            ],
                          ),
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
                              "ETAPA ${_retornarProgressoEtapa()}",
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
                              _retornarQtdeParticipantesAnual(),
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
    if (widget.processoSeletivo!.salarioFixoOuFaixa!.toUpperCase() == "FIXO") {
      return widget.processoSeletivo!.salarioValorFixo!.toStringAsFixed(2);
    } else {
      return "${widget.processoSeletivo!.salarioValorFaixaInicial!.toStringAsFixed(2)} até ${widget.processoSeletivo!.salarioValorFaixaFinal!.toStringAsFixed(2)}";
    }
  }

  String _retornarDiasEmAberto(){
    if(widget.processoSeletivo !=null && widget.processoSeletivo!.diasEmAberto != null){
      return widget.processoSeletivo!.diasEmAberto!.toString();
    }else{
      return "";
    }
  }

  String _retornarCargo(){
    if(widget.processoSeletivo !=null && widget.processoSeletivo!.nomeCargo != null){
      return widget.processoSeletivo!.nomeCargo!;
    }else{
      return "";
    }
  }

  String _retornarLocalidade(){
    if(widget.processoSeletivo !=null && widget.processoSeletivo!.localidade != null){
      return widget.processoSeletivo!.localidade!;
    }else{
      return "";
    }
  }

  String _retornarBeneficios(){
    if(widget.processoSeletivo !=null && widget.processoSeletivo!.beneficios != null){
      return widget.processoSeletivo!.beneficios!;
    }else{
      return "";
    }
  }

  String _retornarProgressoEtapa(){
    if(widget.processoSeletivo !=null && widget.processoSeletivo!.progressoEtapa != null){
      return widget.processoSeletivo!.progressoEtapa!;
    }else{
      return "";
    }
  }

  String _retornarQtdeParticipantesAnual(){
    if(widget.processoSeletivo !=null && widget.processoSeletivo!.qtdeParticipantesAtual != null){
      return widget.processoSeletivo!.qtdeParticipantesAtual!.toString();
    }else{
      return "";
    }
  }

  String _retornarTipoContrato(){
    if(widget.processoSeletivo !=null && widget.processoSeletivo!.tipoContrato != null){
      return widget.processoSeletivo!.tipoContrato!;
    }else{
      return "";
    }
  }

  String _retornarPeriodicidadePagamento(){
    if(widget.processoSeletivo !=null && widget.processoSeletivo!.periodicidadePagamento != null){
      return widget.processoSeletivo!.periodicidadePagamento!;
    }else{
      return "";
    }
  }

  String _retornarDescricao(){
    if(widget.processoSeletivo !=null && widget.processoSeletivo!.descricao != null){
      return widget.processoSeletivo!.descricao!;
    }else{
      return "";
    }
  }

  String _retornarCodigo(){
    if(widget.processoSeletivo != null && widget.processoSeletivo!.codigo !=null){
      return widget.processoSeletivo!.codigo! ;
    }else{
      return "";
    }

  }

}
