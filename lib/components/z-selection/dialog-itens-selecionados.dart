import 'package:flutter/material.dart';

import '../z-tile.dart';
import 'z-selection-item.dart';

class DialogItensSelecionados extends StatefulWidget {
  List<ZSelectionItem> listaSelecao;
  ThemeData theme;

  DialogItensSelecionados({this.listaSelecao, this.theme});

  @override
  _DialogItensSelecionadosState createState() =>
      _DialogItensSelecionadosState();
}

class _DialogItensSelecionadosState extends State<DialogItensSelecionados> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.transparent, body: _buildBody());
  }

  Widget _buildBody() {
    return new Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(32),
      child: new Column(children: [new ListView.builder(
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
      ),],)
    );
  }
}
