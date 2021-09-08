import 'package:flutter/material.dart';
import 'package:z_components/components/utils/icone-voltar.dart';
import 'package:z_components/components/z-selection/z-selection-list.dart';

import '../z-tile.dart';
import 'z-selection-item.dart';

class DialogItensSelecionados extends StatefulWidget {
  List<ZSelectionItem> listaSelecao;
  GlobalKey<ZSelectionListState> keyListagemSelecao;
  ThemeData theme;

  DialogItensSelecionados(
      {this.listaSelecao, this.theme, this.keyListagemSelecao});

  @override
  _DialogItensSelecionadosState createState() =>
      _DialogItensSelecionadosState();
}

class _DialogItensSelecionadosState extends State<DialogItensSelecionados> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: widget.theme.primaryColor,
          leading: IconeVoltar(
            context: context,
          ),
          centerTitle: true,
          title: new Container(
            child: new Text(
              "ITENS SELECIONADOS",
              style: new TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return new Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top:16),
        child: new Column(
          children: [
            new Expanded(
              child: new ListView.builder(
                shrinkWrap: true,
                itemCount: widget.listaSelecao.length,
                itemBuilder: (context, index) {
                  return new Column(
                    children: [
                      new ZTile(
                        leading: new Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: new Text(
                            widget.listaSelecao[index].titulo,
                            style: widget.theme.textTheme.bodyText1,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        trailing: new IconButton(
                          onPressed: () {
                            widget.listaSelecao.removeAt(index);
                            widget.keyListagemSelecao.currentState
                                .atualizarListas(widget.listaSelecao);
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.remove_circle_outline,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      new Divider(
                        height: 1,
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ));
  }
}
