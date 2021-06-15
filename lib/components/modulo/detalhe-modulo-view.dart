import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:z_components/api/contas/contas-service.dart';
import 'package:z_components/api/contas/i-contas-service.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/fluxo-admin/usuarios.dart';
import 'package:z_components/components/modulo/detalhe-modulo.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/utils/novo_token.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/components/z-collection/z-collection-item.dart';
import 'package:z_components/components/z-collection/z-collection.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/i-view.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';

class DetalheModuloView extends IView<DetalheModulo> {
  DetalheModuloView(State<DetalheModulo> state) : super(state);

  SearchOptions searchOptions = new SearchOptions();
  PaginationMetaData paginationMetaData = new PaginationMetaData();
  ScrollController scrollController;
  GlobalKey<ZCollectionState> keyPerfil = new GlobalKey<ZCollectionState>();

  IContasService contasService;
  DialogUtils _dialogUtils;
  TextEditingController dataExpiracaoController = new TextEditingController();
  FocusNode dataExpiracaoFocus = new FocusNode();
  TextEditingController dataController = new TextEditingController();
  FocusNode dataFocus = new FocusNode();
  TextEditingController statusController = new TextEditingController();
  FocusNode statusFocus = new FocusNode();
  TextEditingController moduloController = new TextEditingController();
  FocusNode moduloFocus = new FocusNode();
  TextEditingController perfilController = new TextEditingController();
  FocusNode perfilFocus = new FocusNode();
  TextEditingController dataVinculoController = new TextEditingController();
  FocusNode dataVinculoFocus = new FocusNode();

  bool alterouPerfil = false;
  bool editarDados = false;
  String titulo = "";
  bool cliqueEditar = false;
  String hintNomePerfil = '';
  String hintStatus = '';
  String hintDataExpiracao = '';
  String hintDataVinculo = '';
  bool preencheuDataExpiracao = false;
  String textModificar = '';
  String textModificarAcesso = '';
  String tipoDialog = "";
  List<String> itensMenu = [];
  List<ZCollectionItem> listaPerfis = [];

  @override
  Future<void> afterBuild() {}

  @override
  Future<void> initView() async {
    _dialogUtils = DialogUtils(state.context);
    _definirTextoDialog();
    contasService = new ContasService(NovoToken.newToken);
    if (state.widget.editarDados) {
      itensMenu = [_definirTexto()];
      OrderByExpression order = new OrderByExpression();
      order.propertyName = "Nome";
      order.orientation = "ASC";
      searchOptions.orders = [order];
      listaPerfis = await buscarPerfis(searchOptions);
      state.setState(() {});
    } else {
      itensMenu = ["Editar dados", _definirTexto()];
    }
    preencherDados();
  }

  Future<List<ZCollectionItem>> buscarPerfis(
      SearchOptions searchOptions) async {
    var res = await contasService.buscarListaPerfis(
        searchOptions, state.widget.appUsuarioContaViewModel.app.idApp);
    List<ZCollectionItem> listaAux = [];
    if (res != null) {
      paginationMetaData = res.paginationMetaData;
      for (int i = 0; i < res.body.length; i++) {
        listaAux.add(new ZCollectionItem(
            chave: res.body[i].idPerfil,
            titulo: res.body[i].nome,
            chaveSecundaria: res.body[i].idApp,
            valor: res.body[i].nome));
      }
    }
    return listaAux;
  }

  String _definirTexto() {
    if (state.widget.appUsuarioContaViewModel.status == "Ativo") {
      return "Revogar";
    } else {
      return "Ativar";
    }
  }

  String _definirTextoDialog() {
    if (state.widget.appUsuarioContaViewModel.status == "Ativo") {
      tipoDialog = "removido";
    } else {
      tipoDialog = "habilitado";
    }
  }

  void definirTextoMenu() {
    if (statusController.text == "Ativo") {
      state.setState(() {
        textModificarAcesso = "Revogar";
      });
    } else {
      state.setState(() {
        textModificarAcesso = "Ativar";
      });
    }
  }

  Widget preencherDados() {
    titulo = state.widget.appUsuarioContaViewModel.app.nome;
    perfilController.text = state.widget.appUsuarioContaViewModel.perfil.nome ??
        "Não contém perfil";
    dataVinculoController.text = _validarDataVinculo();
    dataExpiracaoController.text = _validarDataExpiracao();
    statusController.text = state.widget.appUsuarioContaViewModel.status;
    if (state.widget.appUsuarioContaViewModel.status == "Ativo") {
      textModificar = "REVOGAR ACESSO";
    } else {
      textModificar = "ATIVAR ACESSO";
    }
  }

  String _validarDataVinculo() {
    if (state.widget.appUsuarioContaViewModel.dataVinculo != null) {
      return UtilData.obterDataDDMMAAAA(
          DateTime.parse(state.widget.appUsuarioContaViewModel.dataVinculo));
    } else {
      return "Nunca";
    }
  }

  String _validarDataExpiracao() {
    if (state.widget.appUsuarioContaViewModel.dataInativacao != null) {
      return UtilData.obterDataDDMMAAAA(
          DateTime.parse(state.widget.appUsuarioContaViewModel.dataInativacao));
    } else {
      return "Nunca";
    }
  }

  bool validarCampos() {
    if (preencheuDataExpiracao) {
      return true;
    } else {
      return false;
    }
  }

  Function editarOnPressed() {
    if (alterouPerfil) {
      return () async {
        await _alterarAcesso("perfil");
      };
    } else {
      return null;
    }
  }

  String _montarData(String data) {
    return "${data.split("/")[2]}-${data.split("/")[1]}-${data.split("/")[0]}T00:00:00";
  }

  Function cliqueModificarAcesso(AppUsuarioContaViewModel appUsuarioConta) {
    if (textModificar.contains("REVOGAR")) {
      return () {
        state.setState(() {
          appUsuarioConta.status = "Inativo";
          contasService.modificarAcesso(appUsuarioConta);
        });
      };
    } else {
      return () {
        state.setState(() {
          appUsuarioConta.status = "Ativo";
          contasService.modificarAcesso(appUsuarioConta);
        });
      };
    }
  }

  String listarAppsVinculados(List<AppUsuarioContaViewModel> lista) {
    String appsFormatados = "";
    if (lista != null && lista.length != 0) {
      for (int i = 0; i < lista.length; i++) {
        if (i == 0) {
          appsFormatados = "$appsFormatados- ${lista[i].app.nomeExibicao}";
        } else {
          appsFormatados = "$appsFormatados, ${lista[i].app.nomeExibicao}";
        }
      }
    } else {
      appsFormatados = "Sem apps vinculados";
    }
    return appsFormatados;
  }

  Future showDialogAlterarAcesso() async {
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
                        "${_definirTexto()} acesso",
                        style: MainStyle.get(context).mainStyleTextTitle,
                      ),
                    ),
                    new Container(
                      child: new Text(
                        "O acesso do aplicativo: ${state.widget.appUsuarioContaViewModel.app.nomeExibicao.toUpperCase()} será $tipoDialog para ${state.widget.appUsuarioContaViewModel.usuario.nome.toUpperCase()}",
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    new Container(
                      padding: const EdgeInsets.all(4.0),
                      child: new Text(
                        "Deseja prosseguir?",
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
                              if (state
                                      .widget.appUsuarioContaViewModel.status ==
                                  "Ativo") {
                                state.widget.appUsuarioContaViewModel.status =
                                    "Inativo";
                              } else {
                                state.widget.appUsuarioContaViewModel.status =
                                    "Ativo";
                              }
                              Navigator.pop(context);
                              await _alterarAcesso("acesso");
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

  Future<void> _alterarAcesso(String operacao) async {
    _dialogUtils.showProgressDialog();

    var res = await contasService.editarDadosFluxoUsuario(
        state.widget.appUsuarioContaViewModel.app.idModulo,
        state.widget.appUsuarioContaViewModel.idApp,
        state.widget.appUsuarioContaViewModel.idUsuario,
        state.widget.appUsuarioContaViewModel,
        operacao);

    if (res != null && res) {
      _dialogUtils.dismiss();
      Navigator.of(state.context).pop(state.widget.appUsuarioContaViewModel);
    } else {
      _dialogUtils.dismiss();
      _dialogUtils.showAlertDialogErro(
          "Erro!", "Não foi possivel finalizar a alteração.");
      print("Erro");
    }
  }
}
