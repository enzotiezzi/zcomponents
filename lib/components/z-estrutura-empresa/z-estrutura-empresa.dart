import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:z_components/api/z-estrutura-empresa/nivel.dart';
import 'package:z_components/components/utils/icone-voltar.dart';
import 'package:z_components/components/z-estrutura-empresa/bloc/z-estrutura-empresa-cubit-model.dart';
import 'package:z_components/components/z-estrutura-empresa/bloc/z-estrutura-empresa-cubit.dart';
import 'package:z_components/components/z-item-tile.dart';
import 'package:z_components/components/z_loading.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/conta.dart';

class ZEstruturaEmpresa extends StatelessWidget {
  final String token;
  final GlobalKey key;
  final void Function(Nivel) onNodeSelected;
  final void Function() onInfoSelected;

  ZEstruturaEmpresa(
      {@required this.token,
      @required this.key,
      this.onNodeSelected,
      this.onInfoSelected});

  ZEstruturaEmpresaCubit _bloc;

  final TreeViewTheme _treeViewTheme = TreeViewTheme(
    expanderTheme: ExpanderThemeData(
        type: ExpanderType.chevron,
        modifier: ExpanderModifier.none,
        position: ExpanderPosition.start,
        color: MainStyle.APP_THEME,
        size: 20,
        animated: true),
    labelStyle: TextStyle(
      fontSize: 16,
      letterSpacing: 0.3,
    ),
    parentLabelStyle: TextStyle(
      fontSize: 16,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w800,
    ),
    iconTheme: IconThemeData(
      size: 18,
      color: Colors.grey.shade800,
    ),
    colorScheme: ColorScheme.light(),
  );

  @override
  Widget build(BuildContext context) {
    return new BlocProvider(
        create: (context) {
          _bloc = new ZEstruturaEmpresaCubit(token: token);

          _bloc.buscarEstruturaEmpresa();

          return _bloc;
        },
        child: new Scaffold(
          appBar: new AppBar(
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.info,
                    size: 28,
                  ),
                  onPressed: () {
                    onInfoSelected();
                  }),
            ],
            leading: IconeVoltar(
              context: context,
            ),
            title: Text("ESTRUTURA DE EMPRESA"),
            centerTitle: true,
          ),
          body: new BlocBuilder<ZEstruturaEmpresaCubit,
              ZEstruturaEmpresaCubitModel>(builder: (context, state) {
            Widget widget = new Container(
              padding: const EdgeInsets.all(8.0),
              child: new TreeView(
                  controller: _bloc.treeViewController,
                  theme: _treeViewTheme,
                  onNodeTap: (String key) {
                    var node = _bloc.treeViewController.getNode(key);

                    _bloc.selecionarNo(node);
                  },
                  nodeBuilder: (context, node) => new Container(
                        padding: const EdgeInsets.all(4.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            new Expanded(
                              child: new Text(node.label),
                              flex: 90,
                            ),
                            new Expanded(
                              child: new IconButton(
                                  icon: new Icon(
                                    Icons.chevron_right,
                                    color: MainStyle.APP_THEME,
                                  ),
                                  onPressed: () {
                                    if (onNodeSelected != null)
                                      onNodeSelected(
                                          _bloc.selectedNode?.data as Nivel);
                                  }),
                              flex: 10,
                            )
                          ],
                        ),
                      )),
            );

            if (state.isLoading)
              widget = new Center(
                child: new ZLoading(),
              );

            return new Column(
              children: [
                new Row(
                  children: <Widget>[
                    new Expanded(
                      flex: 85,
                      child: new Container(
                        margin: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                        child: new Container(
                          margin: EdgeInsets.only(left: 16, right: 2),
                          decoration: BoxDecoration(
                              color: Color(0xfff0f0f0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9.0))),
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
                                controller: _bloc.searchTextController,
                                onChanged: (value) {
                                  _bloc.filtrarEstruturaEmpresa(value);
                                },
                                placeholder: "Buscar",
                                decoration: new BoxDecoration(
                                    color: Colors.transparent),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    new Expanded(
                        flex: 15,
                        child: new IconButton(
                          icon: new Icon(
                            Icons.filter_list_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                        )),
                  ],
                ),
                new Expanded(child: widget)
              ],
            );
          }),
        ));
  }
}
