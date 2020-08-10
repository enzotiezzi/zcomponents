import 'package:flutter/material.dart';
import 'package:z_components/components/z-tab-bar/z-tab-bar-viewmodel.dart';

import 'z-tav-bar-view.dart';


class ZTabBar extends StatefulWidget {
  List<ZTabBarViewModel> listaZTabBarViewModel;
  void Function(int) onChanged;

  Color color;

  ZTabBar({@required this.listaZTabBarViewModel, this.color, this.onChanged});

  @override
  _ZTabBarState createState() => _ZTabBarState();
}

class _ZTabBarState extends State<ZTabBar> {
  ZTabBarView _view;

  @override
  void initState() {
    _view = ZTabBarView(this);
    _view.initView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10.0),
      child: Material(
          elevation: 4,
          child: new Container(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _itemLista(),
            ),
          )),
    );
  }

  List<Widget> _itemLista() {
    List<Widget> lista = new List<Widget>();
    for (int i = 0; i < widget.listaZTabBarViewModel.length; i++) {
      var item = widget.listaZTabBarViewModel[i];
      if (item.enable) {
        lista.add(new InkWell(
          onTap: () {
            _view.selecionarItem(i);
          },
          child: new Container(
              decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Color(0xffEFEFF4)))),
              width: MediaQuery.of(context).size.width /
                  widget.listaZTabBarViewModel.length,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Container(
                          height: 1,
                          width: 1,
                          color: Colors.transparent,
                        ),
                        new Container(
                          child: new Text(
                            item.titulo,
                            style: TextStyle(
                                color: _view.corTexto(
                                    item.selecionado, item.enable),
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0xffF0F0F0),
                              borderRadius: BorderRadius.circular(6.0)),
                          margin: EdgeInsets.only(right: 16.0),
                          child: new Text(
                            item.contador,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  _focusTextField(item.selecionado),
                ],
              )),
        ));
      } else {lista.add( new Container(
            decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Color(0xffEFEFF4)))),
            width: MediaQuery.of(context).size.width /
                widget.listaZTabBarViewModel.length,
            child: new Container(
                  padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        child: new Text(
                          item.titulo,
                          style: TextStyle(
                              color: _view.corTexto(item.selecionado, item.enable),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),

              ),
      );}
    }
    return lista;
  }

  Widget _focusTextField(bool selecionado) {
    if (selecionado != null && selecionado) {
      return AnimatedContainer(
        height: 4,
        color: widget.color,
        duration: Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
      );
    } else
      return new Container();
  }
}
