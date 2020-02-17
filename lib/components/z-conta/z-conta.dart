import 'package:after_init/after_init.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-conta/z-conta-view.dart';
import 'package:z_components/components/z-tile.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/conta-view-model.dart';

class ZConta extends StatefulWidget {
  String token;

  ZConta({this.token});

  @override
  State<StatefulWidget> createState() => _ZContaState();
}

class _ZContaState extends State<ZConta> with AfterInitMixin<ZConta> {
  ZContaView _view;

  @override
  Widget build(BuildContext context) {
    return MainStyle.get(context)
        .getDefaultScaffold("MINHAS CONTAS", _buildBody());
  }

  @override
  void didInitState() {
    _view = new ZContaView(this);
    _view.initView();
  }

  Widget _buildBody() {
    return new ListView.builder(
        shrinkWrap: true,
        itemCount: _view.contas.length,
        itemBuilder: (context, index) {
          var item = _view.contas[index];

          return new ListTile(
            leading: new CircleAvatar(
              backgroundColor: MainStyle.APP_THEME,
              child: new Icon(Icons.business_center),
            ),
            title: new Text("${item.conta}"),
            subtitle: new Text(item.ativa ? "Conta ativa" : "Ativar conta"),
            trailing: new Icon(Icons.arrow_forward_ios),
            onTap: () => _view.selecionarConta(item),
          );
        });
  }
}
