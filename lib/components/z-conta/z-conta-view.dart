import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:z_components/api/conta/conta-service.dart';
import 'package:z_components/api/conta/i-conta-service.dart';
import 'package:z_components/api/token-parser.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/components/z-conta/z-conta.dart';
import 'package:z_components/components/z-identity-server/login/z-identity-server.dart';
import 'package:z_components/components/z-identity-server/token-info.dart';
import 'package:z_components/components/z-identity-server/vincular-conta/vinculo-conta.dart';
import 'package:z_components/components/z-progress-dialog.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/i-view.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/conta-view-model.dart';

class ZContaView extends IView<ZConta> {
  IContaServce _contaService;

  DialogUtils _dialogUtils;

  GlobalKey<ZProgressDialogState> _globalKey =
      new GlobalKey<ZProgressDialogState>();

  ZContaView(State<ZConta> state) : super(state);

  @override
  Future<void> initView() async {
    _contaService = new ContaService(state.widget.token);
    _dialogUtils = new DialogUtils(state.context);
  }

  Future<void> selecionarConta(ContaViewModel conta) async {
    if (!verificarContaAtiva(conta.idConta))
      _showDialogContaSelecionada(conta);
    else
      _showDialogContaJaAtiva(conta);
  }

  Future _showDialogContaSelecionada(ContaViewModel conta) async {
    return showDialog(
        context: state.context,
        builder: (context) => new ZAlertDialog(
              zDialog: ZDialog.alert,
              child: new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new Column(
                  children: <Widget>[
                    new Container(
                      padding: const EdgeInsets.all(4.0),
                      child: new Text(
                        "TROCAR CONTA",
                        style: MainStyle.get(context).mainStyleTextTitle,
                      ),
                    ),
                    new Container(
                      child: new Text(
                        "Deseja trocar para a conta: ${conta.nomeFantasia} ?",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    new Container(
                      padding: const EdgeInsets.all(4.0),
                      child: new Text(
                        "Ao trocar a conta você só poderá ver informações da conta ${conta.nomeFantasia}",
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontSize: MainStyle.get(context).subTitleFontSize),
                      ),
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Container(
                          child: new InkWell(
                            borderRadius: new BorderRadius.all(
                                const Radius.circular(20.0)),
                            splashColor: const Color(0xffe6e6e6),
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: new Container(
                              padding: const EdgeInsets.all(12),
                              child: new Text(
                                "CANCELAR",
                                style: new TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff707070)),
                              ),
                            ),
                          ),
                          margin: const EdgeInsets.only(bottom: 8),
                        ),
                        new Container(
                          child: new InkWell(
                            borderRadius: new BorderRadius.all(
                                const Radius.circular(20.0)),
                            splashColor: const Color(0xffe6e6e6),
                            onTap: () async {
                              await _trocarConta(conta);

                              Navigator.pop(context);
                            },
                            child: new Container(
                              padding: const EdgeInsets.all(12),
                              child: new Text(
                                "CONFIRMAR",
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          margin: const EdgeInsets.only(bottom: 8),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  Future _showDialogContaJaAtiva(ContaViewModel conta) async {
    return showDialog(
        context: state.context,
        builder: (context) => new ZAlertDialog(
              zDialog: ZDialog.alert,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: new Column(
                  children: <Widget>[
                    new Container(
                      padding: const EdgeInsets.all(4.0),
                      child: new Text(
                        "ATENÇÃO",
                        style: MainStyle.get(context).mainStyleTextTitle,
                      ),
                    ),
                    new Container(
                      child: new Text(
                        "${conta.nomeFantasia} já é sua conta ativa",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Container(
                          child: new InkWell(
                            borderRadius: new BorderRadius.all(
                                const Radius.circular(20.0)),
                            splashColor: const Color(0xffe6e6e6),
                            onTap: () => Navigator.pop(context),
                            child: new Container(
                              padding: const EdgeInsets.all(12),
                              child: new Text(
                                "OK",
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          margin: const EdgeInsets.only(bottom: 8),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  Future<void> showDialogVinculo() async {
    var codigoAtivacao = "";

    return showDialog(
        context: state.context,
        barrierDismissible: true,
        builder: (BuildContext context) => ZAlertDialog(
              zDialog: ZDialog.normal,
              child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.only(top: 16, bottom: 16),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: new Text(
                          "Digite o Código de sua nova conta.",
                          textAlign: TextAlign.center,
                          style: new TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        padding: const EdgeInsets.only(),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: new Column(
                          children: <Widget>[
                            new TextField(
                              textAlign: TextAlign.center,
                              onChanged: (text) {
                                codigoAtivacao = text;
                              },
                              textCapitalization: TextCapitalization.characters,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Código',
                                counterText: "",
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  new Divider(
                    color: const Color(0xffdbdbdb),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Container(
                        child: new InkWell(
                          borderRadius:
                              new BorderRadius.all(const Radius.circular(20.0)),
                          splashColor: const Color(0xffe6e6e6),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: new Container(
                            padding: const EdgeInsets.all(12),
                            child: new Text(
                              "CANCELAR",
                              style:
                                  new TextStyle(fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        margin: const EdgeInsets.only(bottom: 8),
                      ),
                      new Container(
                        child: new InkWell(
                          borderRadius:
                              new BorderRadius.all(const Radius.circular(20.0)),
                          splashColor: const Color(0xffe6e6e6),
                          onTap: () async {
                            await _pesquisarConta(codigoAtivacao);

                            Navigator.pop(context);
                          },
                          child: new Container(
                            padding: const EdgeInsets.all(12),
                            child: new Text(
                              "PESQUISAR",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        margin: const EdgeInsets.only(bottom: 8),
                      )
                    ],
                  )
                ],
              ),
            ));
  }

  bool verificarContaAtiva(String idConta) {
    var tokenInfo =
        TokenInfo.fromJson(TokenParser.parseJwt(state.widget.token));

    return idConta.toUpperCase() == tokenInfo.idConta.toUpperCase();
  }

  Future<bool> _pesquisarConta(String codigoAtivacao) async {
    _dialogUtils.showZProgressDialog("Buscando conta", 0.3, _globalKey);

    var conta = await _contaService.localizarConta(codigoAtivacao);

    if (conta != null) {
      _globalKey.currentState.refresh(1.0, "Conta encontrada", sucess: true);

      await Future.delayed(new Duration(seconds: 1), () async {
        _dialogUtils.dismiss();

        var res = await _showDialogConfirmarVinculo(conta);

        if (res != null && res) {
          state.widget.contas.add(conta);

          state.setState(() {});
        }

        return res;
      });
    } else {
      _globalKey.currentState
          .refresh(1.0, "Não foi possível encontrar a conta", sucess: false);

      await Future.delayed(new Duration(seconds: 1), () {
        _dialogUtils.dismiss();

        return false;
      });
    }
  }

  Future<bool> _showDialogConfirmarVinculo(ContaViewModel conta) async {
    return showDialog(
        context: state.context,
        builder: (context) => new ZAlertDialog(
              zDialog: ZDialog.alert,
              child: new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new Column(
                  children: <Widget>[
                    new Container(
                      padding: const EdgeInsets.all(4.0),
                      child: new Text(
                        "VINCULAR CONTA",
                        style: MainStyle.get(context).mainStyleTextTitle,
                      ),
                    ),
                    new Container(
                      child: new Text(
                        "Deseja se vincular à conta: ${conta.nomeFantasia} ?",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Container(
                          child: new InkWell(
                            borderRadius: new BorderRadius.all(
                                const Radius.circular(20.0)),
                            splashColor: const Color(0xffe6e6e6),
                            onTap: () {
                              Navigator.pop(context, false);
                            },
                            child: new Container(
                              padding: const EdgeInsets.all(12),
                              child: new Text(
                                "CANCELAR",
                                style: new TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff707070)),
                              ),
                            ),
                          ),
                          margin: const EdgeInsets.only(bottom: 8),
                        ),
                        new Container(
                          child: new InkWell(
                            borderRadius: new BorderRadius.all(
                                const Radius.circular(20.0)),
                            splashColor: const Color(0xffe6e6e6),
                            onTap: () async {
                              var res = await _vincularConta(conta);

                              Navigator.pop(context, res);
                            },
                            child: new Container(
                              padding: const EdgeInsets.all(12),
                              child: new Text(
                                "VINCULAR",
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          margin: const EdgeInsets.only(bottom: 8),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  Future<bool> _vincularConta(ContaViewModel conta) async {
    if (!_verificarSeContaJaVinculada(conta.idConta)) {
      _dialogUtils.showZProgressDialog("Vinculando conta", 0.5, _globalKey);

      var res = await _contaService.associarConta(conta.idConta);

      if (res) {
        _globalKey.currentState
            .refresh(1.0, "Vínculo feito com sucesso.", sucess: true);

        if (state.widget.onBindAccount != null)
          state.widget.onBindAccount(conta);
      } else {
        _globalKey.currentState.refresh(
            1.0, "Não foi possível fazer o vínculo com essa conta.",
            sucess: false);
      }

      await Future.delayed(
          new Duration(seconds: 1), () => _dialogUtils.dismiss());

      return res;
    } else {
      await _dialogUtils.showAlertDialog(
          "Atenção", "Você já está vinculado à esta conta.", "OK");

      return false;
    }
  }

  bool _verificarSeContaJaVinculada(String idConta) {
    return state.widget.contas
            .where((x) => x.idConta.toLowerCase() == idConta.toLowerCase())
            .toList()
            .length >
        0;
  }

  Future _trocarConta(ContaViewModel conta) async {
    _dialogUtils.showZProgressDialog("Trocando de conta", 0.5, _globalKey);

    var res = await _contaService.trocarContaAtiva(conta.idConta);

    if (res) {
      _globalKey.currentState
          .refresh(1.0, "Conta trocada com sucesso.", sucess: true);

      state.setState(() {});

      if (state.widget.onAccountChange != null)
        state.widget.onAccountChange(conta);
    } else {
      _globalKey.currentState
          .refresh(1.0, "Não foi possível trocar de conta.", sucess: false);
    }

    await Future.delayed(
        new Duration(seconds: 1), () => _dialogUtils.dismiss());
  }

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    return null;
  }
}
