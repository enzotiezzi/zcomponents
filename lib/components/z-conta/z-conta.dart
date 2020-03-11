import 'package:after_init/after_init.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-conta/z-conta-view.dart';
import 'package:z_components/styles/main-style.dart';

class ZConta extends StatefulWidget {
  String token;

  ZConta({@required this.token});

  @override
  State<StatefulWidget> createState() => _ZContaState();
}

class _ZContaState extends State<ZConta> with AfterLayoutMixin<ZConta> {
  ZContaView _view;

  @override
  void initState() {
    super.initState();

    _view = new ZContaView(this);
    _view.initView();
  }

  @override
  Widget build(BuildContext context) {
    return MainStyle.get(context)
        .getDefaultScaffold("MINHAS CONTAS", _buildBody());
  }

  Widget _buildBody() {
    return new Column(
      children: <Widget>[
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new GestureDetector(
                onTap: () {
                  _view.showDialogVinculo();
                },
                child: new Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: new Text(
                    "Adicionar Conta",
                    style: new TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Color(0xff2bbab4)),
                  ),
                ))
          ],
        ),
        new ListView.builder(
            shrinkWrap: true,
            itemCount: _view.contas.length,
            itemBuilder: (context, index) {
              var item = _view.contas[index];

              return new ListTile(
                leading: new CircleAvatar(
                  backgroundColor: item.corPrimaria,
                  child: new Text("${item.nomeFantasia[0]}", style: new TextStyle(color: item.corSecundaria),),
                ),
                title: new Text("${item.nomeFantasia}"),
                subtitle: new Text(item.ativo ? "Conta ativa" : "Ativar conta"),
                trailing: new Icon(Icons.arrow_forward_ios),
                onTap: () => _view.selecionarConta(item),
              );
            })
      ],
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _view.afterBuild();
  }
}
