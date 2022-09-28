import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/filtro-campo.dart';
import 'package:z_components/components/z-inputs/z-input-generic.dart';

class ZSearchBar extends StatefulWidget {
  final GlobalKey key;
  final FiltroCampo filtroPrincipal;
  final List<FiltroCampo> camposFiltro;
  final Function(List<FilterExpression>) onFilter;

  ZSearchBar(
      {@required this.key,
      @required this.camposFiltro,
      @required this.filtroPrincipal,
      this.onFilter})
      : super(key: key);

  @override
  ZSearchBarState createState() => ZSearchBarState();
}

class ZSearchBarState extends State<ZSearchBar> {
  TextEditingController searchTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _buildSearchBar();
  }

  Widget _buildSearchBar() {
    return new Material(
        elevation: 5,
        child: new Row(
          children: <Widget>[
            new Expanded(
              flex: 85,
              child: new Container(
                margin: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                child: new Container(
                  margin: EdgeInsets.only(left: 16, right: 2),
                  decoration: BoxDecoration(
                      color: Color(0xfff0f0f0),
                      borderRadius: BorderRadius.all(Radius.circular(9.0))),
                  child: new Row(
                    children: <Widget>[
                      new Container(
                          padding: EdgeInsets.only(left: 8.0),
                          child: new Icon(
                            Icons.search,
                            color: Color(0xff999999),
                          )),
                      new Expanded(
                          child: new CupertinoTextField(
                        placeholderStyle: new TextStyle(
                            color: Color(0xff999999), fontSize: 17),
                        keyboardType: TextInputType.text,
                        controller: searchTextController,
                        onChanged: (value) {
                          if (value.length >= 3 || value.length == 0)
                            widget.onFilter([
                              new FilterExpression(
                                  propertyName: widget.filtroPrincipal.key,
                                  operatorBetween: "AndAlso",
                                  operator: "Contains",
                                  value: value)
                            ]);
                          print(value);
                        },
                        placeholder: "Buscar",
                        decoration:
                            new BoxDecoration(color: Colors.transparent),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Future filter() async {
    var filters = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new _ZFilter(
                  camposFiltro: widget.camposFiltro,
                )));

    if (filters != null && widget.onFilter != null) widget.onFilter(filters);
  }
}

class _ZFilter extends StatefulWidget {
  final List<FiltroCampo> camposFiltro;

  _ZFilter({@required this.camposFiltro});

  @override
  _ZFilterState createState() => _ZFilterState();
}

class _ZFilterState extends State<_ZFilter> {
  List<FilterExpression> filters = new List();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new CupertinoNavigationBar(
        middle: new Text("FILTROS"),
        trailing: new GestureDetector(
          child: new Icon(Icons.search_outlined),
          onTap: () {
            Navigator.of(context).pop(filters);
          },
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return new ListView.builder(
      itemCount: widget.camposFiltro.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var focusNode = new FocusNode();
        var textController = new TextEditingController();

        return new ZInputGeneric(
            themeData: Theme.of(context),
            titulo: widget.camposFiltro[index].value,
            inputPadraoFocus: focusNode,
            controllerInputPadrao: textController,
            hintText: widget.camposFiltro[index].value,
            onChange: (value) {
              var key = widget.camposFiltro[index].key;

              var campo = filters.firstWhere(
                  (element) => element.propertyName == key,
                  orElse: () => null);

              if (campo != null)
                campo.value = value;
              else
                filters.add(new FilterExpression(
                    value: value,
                    operator: "Contains",
                    operatorBetween: "AndAlso",
                    propertyName: key));
            });
      },
    );
  }
}
