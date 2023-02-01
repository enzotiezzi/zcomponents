import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-collection/z-collection-item.dart';

class ZCollectionBottomSheet extends StatefulWidget {
  final String? title;
  final ThemeData? themeData;
  final List<ZCollectionItem>? lista;
  final ValueChanged<ZCollectionItem>? onChange;
  final bool? campoObrigatorio;
  String? valorPadrao;

  ZCollectionBottomSheet(
      {@required this.title,
        @required this.themeData,
        @required this.lista,
        this.onChange,
        this.campoObrigatorio = false,
        this.valorPadrao});

  @override
  _ZCollectionBottomSheetState createState() => _ZCollectionBottomSheetState();
}

class _ZCollectionBottomSheetState extends State<ZCollectionBottomSheet> {
  ZCollectionItem? _itemSelecionado;
  String _anterior = "Selecione";

  ZCollectionItem? get itemSelecionado => _itemSelecionado;

  @override
  void initState() {
    if (widget.valorPadrao != null && widget.valorPadrao!.isNotEmpty) {
      _itemSelecionado = new ZCollectionItem(
          chave: widget.valorPadrao,
          titulo: widget.valorPadrao,
          valor: widget.valorPadrao);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Column(
        children: <Widget>[
          new Container(
            height: 39,
            color: Colors.white,
            padding: EdgeInsets.only(left: 16.0, right: 14),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _returnRequiredField(),
                Flexible(
                    flex: 65,
                    fit: FlexFit.tight,
                    child: new Text(
                      (_itemSelecionado == null || _itemSelecionado!.valor == null &&
                          _anterior == "Selecione")
                          ? _anterior
                          : _itemSelecionado!.valor!,
                      style: _retornaCorTexto(),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    )),
                Flexible(
                  flex: 10,
                  fit: FlexFit.tight,
                  child: new Icon(
                    Icons.arrow_drop_down,
                    color: _retornaCorIcon(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        showDialogBottom(context);
      },
    );
  }

  Color _retornaCorIcon() {
    if (_itemSelecionado?.valor == null && _anterior == "Selecione") {
      return widget.themeData!.accentColor;
    } else {
      return Colors.black;
    }
  }

  TextStyle _retornaCorTexto() {
    if (_itemSelecionado?.valor == null && _anterior == "Selecione") {
      return widget.themeData!.textTheme.bodyText1!
          .copyWith(color: widget.themeData!.accentColor);
    } else {
      return widget.themeData!.textTheme.bodyText1!.copyWith(color: Colors.black);
    }
  }

  Future showDialogBottom(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (builder) {
          return new Wrap(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.only(top: 18, bottom: 8),
                    child: new Text(
                      "${widget.title}",
                      style: widget.themeData!.textTheme.subtitle1!
                          .copyWith(color: Color(0xff999999)),
                    ),
                  ),
                ],
              ),
              new Divider(color: Color(0xffCECECE)),
              new ListView.builder(
                itemCount: widget.lista!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item = widget.lista![index];
                  return new GestureDetector(
                    child: new Container(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 8.0, bottom: 8.0),
                      child: Text(
                        "${item.titulo}",
                        style: widget.themeData!.textTheme.bodyText2!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    onTap: () {
                      if (mounted)
                        setState(() {
                          _itemSelecionado = item;
                          widget.valorPadrao = item.titulo;
                          if (widget.onChange != null)
                            widget.onChange!(_itemSelecionado!);
                          Navigator.pop(context);
                        });
                    },
                  );
                },
              )
            ],
          );
        });
  }

  Widget _returnRequiredField() {
    if (widget.campoObrigatorio != null && widget.campoObrigatorio!) {
      return Flexible(
        flex: 45,
        fit: FlexFit.tight,
        child: new RichText(
          maxLines: 2,
          text: TextSpan(
            children: <TextSpan>[
              new TextSpan(
                text: "${widget.title}",
                style: widget.themeData!.textTheme.bodyText1!
                    .copyWith(color: Color(0xff999999)),
              ),
              TextSpan(text: "*", style: TextStyle(color: Colors.redAccent))
            ],
          ),
        ),
      );
    } else {
      return Flexible(
        flex: 45,
        fit: FlexFit.tight,
        child: RichText(
          maxLines: 2,
          text: TextSpan(
            children: <TextSpan>[
              new TextSpan(
                text: "${widget.title}",
                style: widget.themeData!.textTheme.bodyText1!
                    .copyWith(color: Color(0xff999999)),
              ),
            ],
          ),
        ),
      );
    }
  }
}
