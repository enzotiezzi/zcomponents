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
import 'package:z_components/components/z_button.dart';
import 'package:z_components/config/z-button-type.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/i-view.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/conta-view-model.dart';
import 'package:http/http.dart' as http;

class ZContaView extends IView<ZConta> {
  List<ContaViewModel> contas;

  IContaServce _contaService;

  DialogUtils _dialogUtils;

  final GlobalKey<ZProgressDialogState> _globalKey =
      new GlobalKey<ZProgressDialogState>();

  ZIdentityServer _zIdentityServer;

  String _clientId = 'ZPonto';
  String _redirectUrl = 'net.openid.appzponto:/oauth2redirect';

  List<String> _scopes = [
    'openid',
    'profile',
    'email',
    'offline_access',
    'moltres.acesso.api.full'
  ];

  ZContaView(State<ZConta> state) : super(state) {
    _zIdentityServer = new ZIdentityServer(
        clientId: _clientId, redirectURI: _redirectUrl, scopes: _scopes);
  }

  @override
  Future<void> initView() async {
    contas = new List<ContaViewModel>();

    _contaService = new ContaService(state.widget.token);
    _dialogUtils = new DialogUtils(state.context);
  }

  Future<void> selecionarConta(ContaViewModel conta) async {
    if (!conta.ativo)
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
                          "Deseja trocar para a conta: ${conta.nomeFantasia} ?"),
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
                      child: new Text(
                          "${conta.nomeFantasia} já é sua conta ativa"),
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
                          onTap: () {
                            _confirmarVinculo(codigoAtivacao);
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

  Future<void> _listarContas() async {
    var token = await _zIdentityServer.authorize();

    _contaService = new ContaService(token.accessToken);

    _dialogUtils.showZProgressDialog(
        "Carregando suas contas...", 0.5, _globalKey);

    var contas = await _contaService.listarContasUsuario();

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

    Future.delayed(new Duration(seconds: 1), () => _dialogUtils.dismiss());
  }

  @override
  Future<void> afterBuild() async {
    _listarContas();
  }

  bool verificarContaAtiva(String idConta) {
    var tokenInfo =
        TokenInfo.fromJson(TokenParser.parseJwt(state.widget.token));

    return idConta.toUpperCase() == tokenInfo.idConta.toUpperCase();
  }

  Future _confirmarVinculo(String codigoAtivacao) async {
    _dialogUtils.showZProgressDialog("Buscando conta", 0.3, _globalKey);

    var conta = await _contaService.localizarConta(codigoAtivacao);

    if (conta != null) {
      _globalKey.currentState.refresh(1.0, "Conta encontrada", sucess: true);

      Future.delayed(new Duration(seconds: 1), () async {
        _dialogUtils.dismiss();

        var res = await _showDialogConfirmarVinculo(conta);

        if (res == null || !res) {
          _dialogUtils.showAlertDialogErro(
              "Erro", "Não foi possível fazer o vínculo com essa conta.");
        } else {
          _dialogUtils.showSuccessDialog("Vínculo feito com sucesso");
        }
      });
    } else {
      _globalKey.currentState
          .refresh(1.0, "Não foi possível encontrar a conta", sucess: false);

      Future.delayed(new Duration(seconds: 1), () => _dialogUtils.dismiss());
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
                          "Deseja se vincular à conta: ${conta.nomeFantasia} ?"),
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
                              var res = await _vincularConta(conta.idConta);

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

  Future<bool> _vincularConta(String idConta) async {
    var res = await _contaService.associarConta(idConta);

    return res;
  }
}
