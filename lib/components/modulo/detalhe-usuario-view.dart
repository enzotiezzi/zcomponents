import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:z_components/api/contas/contas-service.dart';
import 'package:z_components/api/contas/i-contas-service.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/modulo/detalhe-usuario.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/utils/novo_token.dart';
import 'package:z_components/components/z-collection/z-collection-item.dart';
import 'package:z_components/components/z-collection/z-collection.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/i-view.dart';
import 'package:z_components/styles/main-style.dart';

import '../z-alert-dialog.dart';
import '../z-progress-dialog.dart';

class DetalheUsuarioView extends IView<DetalheUsuario> {
    DetalheUsuarioView(State<DetalheUsuario> state) : super(state);

    String? titulo = "";
    String? textModificar = '';
    String? tipoDialog = "";
    SearchOptions searchOptions = new SearchOptions();
    PaginationMetaData paginationMetaData = new PaginationMetaData();
    ScrollController scrollController = ScrollController();

    TextEditingController emailController = new TextEditingController();
    FocusNode emailFocus = new FocusNode();
    TextEditingController dataController = new TextEditingController();
    FocusNode dataFocus = new FocusNode();
    TextEditingController nomeController = new TextEditingController();
    FocusNode nomeFocus = new FocusNode();
    TextEditingController moduloController = new TextEditingController();
    FocusNode moduloFocus = new FocusNode();
    TextEditingController perfilController = new TextEditingController();
    FocusNode perfilFocus = new FocusNode();
    TextEditingController telefoneController = new TextEditingController();
    FocusNode telefoneFocus = new FocusNode();
    GlobalKey<ZCollectionState> keyPerfil = new GlobalKey<ZCollectionState>();
    late IContasService _contasService;
    bool alterouPerfil = false;
    String textModificarAcesso = '';

    String hintNomePerfil = '';
    String hintStatus = '';
    String hintDataExpiracao = '';
    String hintDataVinculo = '';
    bool preencheuDataExpiracao = false;
    List<String>? itensMenu = [];
    List<ZCollectionItem>? listaPerfis = [];

    late DialogUtils _dialogUtils;

    GlobalKey<ZProgressDialogState> _globalKey =
    new GlobalKey<ZProgressDialogState>();

    @override
    Future<void> afterBuild() async{

    }

    @override
    Future<void> initView() async {
        _dialogUtils = DialogUtils(state.context);
        _definirTextoDialog();
        _contasService = new ContasService(NovoToken.newToken);
        if (state.widget.editarDados!=null && state.widget.editarDados!) {
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
        var res = await _contasService.buscarListaPerfis(
            searchOptions, state.widget.appUsuarioContaViewModel!.app!.idApp!);
        List<ZCollectionItem> listaAux = [];
        if (res != null) {
            paginationMetaData = res.paginationMetaData!;
            for (int i = 0; i < res.body!.length; i++) {
                listaAux.add(new ZCollectionItem(
                    chave: res.body?[i].idPerfil,
                    titulo: res.body?[i].nome,
                    chaveSecundaria: res.body?[i].idApp,
                    valor: res.body?[i].nome));
            }
        }
        return listaAux;
    }

     _definirTextoDialog() {
        if (state.widget.appUsuarioContaViewModel?.status == "Ativo") {
            tipoDialog = "removido";
        } else {
            tipoDialog = "habilitado";
        }
    }

    String _definirTexto() {
        if (state.widget.appUsuarioContaViewModel?.status == "Ativo") {
            textModificarAcesso = "Inativar";
            return "Revogar";
        } else {
            textModificarAcesso = "Ativar";
            return "Ativar";
        }
    }


     preencherDados() {
        titulo = state.widget.appUsuarioContaViewModel?.app?.nome ?? "";
        perfilController.text = state.widget.appUsuarioContaViewModel?.perfil?.nome ??
            "Não contém perfil";
        telefoneController.text =
            state.widget.appUsuarioContaViewModel?.usuario?.telefone ?? "";
        emailController.text =
            state.widget.appUsuarioContaViewModel?.usuario?.email ?? "";
        nomeController.text = state.widget.appUsuarioContaViewModel?.usuario?.nome ?? "";
        if (state.widget.appUsuarioContaViewModel?.status != null && state.widget.appUsuarioContaViewModel!.status == "Ativo") {
            textModificar = "REVOGAR ACESSO";
        } else {
            textModificar = "ATIVAR ACESSO";
        }
    }


    bool validarCampos() {
        if (preencheuDataExpiracao) {
            return true;
        } else {
            return false;
        }
    }

    Function? cliqueModificarAcesso() {}

    Function editarOnPressed() {
        if (alterouPerfil) {
            return () async {
                await _alterarAcesso("perfil");
            };
        } else
            return (){};
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
                                    "O acesso ao aplicativo: ${state.widget.appUsuarioContaViewModel?.app?.nomeExibicao?.toUpperCase()} será $tipoDialog HOJE para ${state.widget.appUsuarioContaViewModel?.usuario?.nome.toUpperCase()}",
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
                                                if (
                                                state
                                                    .widget.appUsuarioContaViewModel?.status != null &&
                                                    state
                                                    .widget.appUsuarioContaViewModel!.status ==
                                                    "Ativo") {
                                                    state.widget.appUsuarioContaViewModel?.status =
                                                    "Inativo";
                                                } else {
                                                    state.widget.appUsuarioContaViewModel?.status =
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

        if(operacao.contains("perfil")){
            textModificarAcesso = "perfil";
        }

        var res = await _contasService.editarDadosUsuario(
            state.widget.idModulo!,
            state.widget.appUsuarioContaViewModel!.idApp!,
            state.widget.appUsuarioContaViewModel!.idUsuario!,
            state.widget.appUsuarioContaViewModel!,
            textModificarAcesso);

        if (res != null && res) {
            _dialogUtils.dismiss();
            Navigator.of(state.context).pop(state.widget.appUsuarioContaViewModel);
        } else {
            if (operacao == "perfil") textModificarAcesso = "alterar";
            if (state.widget.appUsuarioContaViewModel?.status != null &&
                state.widget.appUsuarioContaViewModel!.status == "Inativo") {
                state.widget.appUsuarioContaViewModel?.status = "Ativo";
            } else {
                state.widget.appUsuarioContaViewModel?.status = "Inativo";
            }
            _dialogUtils.dismiss();
            _dialogUtils.showAlertDialogErro(
                 "Não foi possivel $textModificarAcesso o $operacao.");
            print("Erro");
        }
    }
}