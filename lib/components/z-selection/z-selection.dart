import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/filtro-campo.dart';
import 'package:z_components/components/z-collection/z-collection-item.dart';
import 'package:z_components/components/z-collection/z-collection-list.dart';
import 'package:z_components/components/z-selection/z-selection-item.dart';
import 'package:z_components/components/z-selection/z-selection-list.dart';
import 'package:z_components/components/z-text.dart';
import 'package:z_components/components/z-tile.dart';
import 'package:z_components/config/z-tipo-textos.dart';

class ZSelection extends StatefulWidget {
  final String titulo;
  List<ZSelectionItem> lista;
  final ThemeData themeData;
  final ValueChanged<List<ZSelectionItem>> onChange;
  final String valorPadrao;
  final Color colorStyle;
  final int skip;
  final int take;
  final bool campoObrigatorio;
  final FiltroCampo filtroPrincipal;
  final Function(List<FilterExpression>) onFilter;
  Function(List<FilterExpression>, List<ZSelectionItem>) onScroll;

  ZSelection(
      {Key key,
      @required this.titulo,
      @required this.lista,
      @required this.themeData,
      this.onChange,
      this.valorPadrao,
      this.colorStyle: const Color(0xff2bbab4),
      this.skip: 0,
      this.take: 0,
      this.campoObrigatorio = false,
      this.filtroPrincipal,
      this.onFilter,
      this.onScroll})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ZSelectionState();
}

class ZSelectionState extends State<ZSelection> {
  List<ZSelectionItem> _itemSelecionado = new List<ZSelectionItem>();
  GlobalKey<ZSelectionListState> keyLista =
      new GlobalKey<ZSelectionListState>();

  List<ZSelectionItem> get itemSelecionado => _itemSelecionado;
  List<ZSelectionItem> listaRespostas = [];

  @override
  void initState() {
    _montarListaRespostas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new GestureDetector(
          onTap: _irParaSelecaoDeItemHorizontal,
          child: new Container(
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
                      "Selecione",
                      style: _retornaCorTexto(),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )),
                Flexible(
                  flex: 10,
                  fit: FlexFit.tight,
                  child: new Icon(
                    Icons.keyboard_arrow_right,
                    color: _retornaCorIcon(),
                  ),
                ),
              ],
            ),
          ),
        ),
        _montarTituloItensSelecionados(),
        _montarItensSelecionados()
      ],
    );
  }

  Color _retornaCorIcon() {
    return widget.themeData.primaryColor;
  }

  Widget _montarTituloItensSelecionados() {
    if (listaRespostas.isEmpty) {
      return new Container();
    } else {
      return new Column(
        children: [
          new Container(
            margin: EdgeInsets.only(top: 10.0),
            child: new ZText(
              zTipos: ZTipoTextos.isTitulo,
              tituloText: "Itens selecionados",
            ),
          ),
          new Divider(
            height: 1,
          )
        ],
      );
    }
  }

  Widget _montarItensSelecionados() {
    if (listaRespostas.isEmpty) {
      return new Container();
    } else {
      return new ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: listaRespostas.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                new ZTile(
                  leading: new Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: new Text(
                      listaRespostas[index].titulo,
                      style: TextStyle(color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                new Divider(
                  height: 1,
                )
              ],
            );
          });
    }
  }

  TextStyle _retornaCorTexto() {
    return widget.themeData.textTheme.bodyText1
        .copyWith(color: widget.themeData.primaryColor);
  }

  void _montarListaRespostas() {
    if (_itemSelecionado != null&& _itemSelecionado.isNotEmpty) {
      widget.lista = _itemSelecionado;
    }
    listaRespostas.clear();
    for (int i = 0; i < widget.lista.length; i++) {
      if (widget.lista[i].selecionado) {
        listaRespostas.add(widget.lista[i]);
      }
    }
  }

  void atualizarLista(List<ZSelectionItem> lista) {
    keyLista.currentState.atualizarLista(lista);
  }

  void _irParaSelecaoDeItemHorizontal() async {
    _itemSelecionado = await Navigator.push<List<ZSelectionItem>>(
        context,
        new PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation animation,
              Animation secondaryAnimation) {
            return ZSelectionList(
              key: keyLista,
              lista: widget.lista,
              titulo: widget.titulo,
              color: widget.colorStyle,
              skip: widget.skip,
              take: widget.take,
              theme: widget.themeData,
              onChange: widget.onFilter,
              filtroPrincipal: widget.filtroPrincipal,
              onScroll: widget.onScroll,
            );
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: new SlideTransition(
                position: new Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(1.0, 0.0),
                ).animate(secondaryAnimation),
                child: child,
              ),
            );
          },
        ));

    _montarListaRespostas();
    if (widget.onChange != null) widget.onChange(_itemSelecionado);

    setState(() {});
  }

  Widget _returnRequiredField() {
    if (widget.campoObrigatorio) {
      return Flexible(
        flex: 45,
        fit: FlexFit.tight,
        child: new RichText(
          maxLines: 2,
          text: TextSpan(
            children: <TextSpan>[
              new TextSpan(
                text: "${widget.titulo}",
                style: widget.themeData.textTheme.bodyText1
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
                text: "${widget.titulo}",
                style: widget.themeData.textTheme.bodyText1
                    .copyWith(color: Color(0xff999999)),
              ),
            ],
          ),
        ),
      );
    }
  }
}
