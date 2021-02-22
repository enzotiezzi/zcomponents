import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-collection/z-collection-item.dart';

class ZCollectionBottomSheet extends StatefulWidget {
  final String title;
  final ThemeData themeData;
  final List<ZCollectionItem> lista;
  final ValueChanged<ZCollectionItem> onChange;
  final bool campoObrigatorio;

  ZCollectionBottomSheet(
      {@required this.title,
      @required this.themeData,
      @required this.lista,
      this.onChange,
      this.campoObrigatorio = false});

  @override
  _ZCollectionBottomSheetState createState() => _ZCollectionBottomSheetState();
}

class _ZCollectionBottomSheetState extends State<ZCollectionBottomSheet> {
  ZCollectionItem _itemSelecionado = new ZCollectionItem();
  String _anterior = "Selecione";

  ZCollectionItem get itemSelecionado => _itemSelecionado;


  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Column(
        children: <Widget>[
          new Container(
            height: 42,
            color: Colors.white,
            padding: EdgeInsets.only(left: 16.0, right: 14),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 45,
                  fit: FlexFit.tight,
                  child:
                  widget.campoObrigatorio ?
                  new RichText(
                    maxLines: 2,
                    text: TextSpan(
                        children: <TextSpan>[
                          new TextSpan(
                            text: "${widget.title}",
                            style: widget.themeData.textTheme.bodyText1
                                .copyWith(color: Color(0xff999999)),
                          ),
                          TextSpan(
                            text: "*",
                            style: TextStyle(color: Colors.redAccent)
                          )
                        ],
                      ),
                  ):
                  RichText(
                    maxLines: 2,
                    text: TextSpan(
                      children: <TextSpan>[
                        new TextSpan(
                          text: "${widget.title}",
                          style: widget.themeData.textTheme.bodyText1
                              .copyWith(color: Color(0xff999999)),
                        ),
                      ],
                    ),
                  )
                ),

                Flexible(
                    flex: 55,
                    fit: FlexFit.tight,
                    child: new Text(
                      (_itemSelecionado?.valor == null &&
                              _anterior == "Selecione")
                          ? _anterior
                          : _itemSelecionado?.valor,
                      style: widget.themeData.textTheme.bodyText1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    )),
                Flexible(
                  flex: 10,
                  fit: FlexFit.tight,
                  child: new Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
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
                        style: widget.themeData.textTheme.subtitle1
                            .copyWith(color: Color(0xff999999)),
                      ),
                    ),
                  ],
                ),
                new Divider(color: Color(0xffCECECE)),
                new ListView.builder(
                  itemCount: widget.lista.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var item = widget.lista[index];
                    return new GestureDetector(
                      child: new Container(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 8.0, bottom: 8.0),
                        child: Text(
                          "${item.titulo}",
                          style: widget.themeData.textTheme.bodyText2
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        if (mounted)
                          setState(() {
                            _itemSelecionado = item;
                            if (widget.onChange != null) widget.onChange(_itemSelecionado);
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
}
