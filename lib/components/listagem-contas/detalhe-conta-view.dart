import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:z_components/api/conta/conta-service.dart';
import 'package:z_components/api/conta/i-conta-service.dart';
import 'package:z_components/api/contas/contas-service.dart';
import 'package:z_components/api/contas/i-contas-service.dart';
import 'package:z_components/components/listagem-contas/detalhe-conta.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/utils/novo_token.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';

import '../../i-view.dart';
import '../z-alert-dialog.dart';
import '../z-progress-dialog.dart';

class DetalheContaViewModel extends IView<DetalheConta> {
  DetalheContaViewModel(State<DetalheConta> state) : super(state);
  IContasService _contaService;

  DialogUtils _dialogUtils;

  GlobalKey<ZProgressDialogState> _globalKey =
      new GlobalKey<ZProgressDialogState>();

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    throw UnimplementedError();
  }

  @override
  Future<void> initView() {
    _contaService = new ContasService(state.widget.token);
    _dialogUtils = new DialogUtils(state.context);
  }

  String listarAppsVinculados(List<AppUsuarioContaViewModel> lista) {
    String appsFormatados = "";
    if (lista != null && lista.length != 0) {
      for (int i = 0; i < lista.length; i++) {
        if (i == 0) {
          appsFormatados =
              "$appsFormatados- ${lista[i].app.nomeExibicao ?? ""}";
        } else {
          appsFormatados =
              "$appsFormatados, ${lista[i].app.nomeExibicao ?? ""}";
        }
      }
    } else {
      appsFormatados = "Sem apps vinculados";
    }
    return appsFormatados;
  }

  Future showDialogContaSelecionada() async {
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
                        "Deseja trocar para a conta: ${state.widget.contaV2ViewModel.conta.nomeFantasia} ?",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    new Container(
                      padding: const EdgeInsets.all(4.0),
                      child: new Text(
                        "Ao trocar a conta você só poderá ver informações da conta ${state.widget.contaV2ViewModel.conta.nomeFantasia}",
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
                              await _trocarConta();

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

  Future _trocarConta() async {
    _dialogUtils.showZProgressDialog("Trocando de conta", 0.5, _globalKey);

    var res = await _contaService
        .alterarConta(state.widget.contaV2ViewModel.conta.idConta);

    if (res) {
      _globalKey.currentState
          .refresh(1.0, "Conta trocada com sucesso.", success: true);

      if (state.widget.onAccountChange != null)
        await state.widget.onAccountChange(state.widget.contaV2ViewModel);

      state.setState(() {});
    } else {
      _globalKey.currentState
          .refresh(1.0, "Não foi possível trocar de conta.", success: false);
    }

    await Future.delayed(
        new Duration(seconds: 1), () => _dialogUtils.dismiss());
    Navigator.of(state.context).pop();
  }
}
