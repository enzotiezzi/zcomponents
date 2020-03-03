import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:z_components/api/conta/conta-service.dart';
import 'package:z_components/api/conta/i-conta-service.dart';
import 'package:z_components/api/token-parser.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/components/z-conta/z-conta.dart';
import 'package:z_components/components/z-identity-server/token-info.dart';
import 'package:z_components/components/z-progress-dialog.dart';
import 'package:z_components/components/z_button.dart';
import 'package:z_components/config/z-button-type.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/i-view.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/conta-view-model.dart';
import 'package:http/http.dart' as http;

class ZContaView extends IView<ZConta> {
  List<ContaViewModel> contas;

  IContaServce _contaServce;

  DialogUtils _dialogUtils;

  final GlobalKey<ZProgressDialogState> _globalKey =
      new GlobalKey<ZProgressDialogState>();

  ZContaView(State<ZConta> state) : super(state);

  @override
  Future<void> initView() {
    contas = new List<ContaViewModel>();

    _contaServce = new ContaService(state.widget.token);
    _dialogUtils = new DialogUtils(state.context);
  }

  Future<void> selecionarConta(ContaViewModel conta) async {
    if (!conta.ativa)
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
                          "Deseja trocar para a conta: ${conta.conta} ?"),
                    ),
                    new Container(
                      padding: const EdgeInsets.all(4.0),
                      child: new Text(
                        "Ao trocar a conta você só poderá ver informações da conta ${conta.conta}",
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
                            onTap: () async {},
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
                      child: new Text("${conta.conta} já é sua conta ativa"),
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

  void showDialogVinculo() async {
    showDialog(
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
                              onChanged: (text) {},
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
                              "Cancelar",
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
                          onTap: () {},
                          child: new Container(
                            padding: const EdgeInsets.all(12),
                            child: new Text(
                              "Vincular",
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

  Future<void> _listarContas() async {
    _dialogUtils.showZProgressDialog(
        "Carregando suas contas...", 0.5, _globalKey);

    var contas = await _contaServce.listarContasUsuario();

    if (contas != null) {
      _globalKey.currentState
          .refresh(1.0, "Contas carregadas com sucesso", sucess: true);

      if (state.mounted) {
        state.setState(() {
          this.contas = contas;
        });
      }
    } else {
      _globalKey.currentState
          .refresh(1.0, "Houve um erro ao carregar as contas", sucess: false);
    }

    Future.delayed(new Duration(seconds: 2), () => _dialogUtils.dismiss());
  }

  @override
  Future<void> afterBuild() async {
    _listarContas();
  }

  bool verificarContaAtiva(String idConta){
    var tokenInfo = TokenInfo.fromJson(TokenParser.parseJwt(state.widget.token));

    return idConta.toUpperCase() == tokenInfo.idConta.toUpperCase();
  }
}
