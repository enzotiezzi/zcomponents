import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:z_components/api/contas/contas-service.dart';
import 'package:z_components/api/contas/i-contas-service.dart';
import 'package:z_components/api/endereco/endereco-service.dart';
import 'package:z_components/api/endereco/i-endereco-service.dart';
import 'package:z_components/api/teste-conexao/i-teste-conexao-service.dart';
import 'package:z_components/api/teste-conexao/teste-conexao-service.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/info-organizacao-viewmodel.dart';
import '../../i-view.dart';
import '../z-progress-dialog.dart';
import 'informacoes-organizacao.dart';

class InformacoesOrganizacaoView extends IView<InformacoesOrganizacao> {
  Color corPrimaria = Color(0xFF2BBAB4);
  Color corSecundaria = Color(0xFF801F92);
  Color pickerPrimaria = Color(0xFF2BBAB4);
  Color pickerSecundaria = Color(0xFF801F92);

  FocusNode nomeFocusNode = new FocusNode();
  TextEditingController nomeController = new TextEditingController();
  FocusNode nomeFantasiaFocusNode = new FocusNode();
  TextEditingController nomeFantasiaController = new TextEditingController();
  FocusNode cpfFocusNode = new FocusNode();
  TextEditingController cpfController = new TextEditingController();
  FocusNode cnpjFocusNode = new FocusNode();
  TextEditingController cnpjController = new TextEditingController();
  FocusNode emailFocusNode = new FocusNode();
  TextEditingController emailController = new TextEditingController();
  FocusNode telefoneFocusNode = new FocusNode();
  TextEditingController telefoneController = new TextEditingController();
  FocusNode codigoFocusNode = new FocusNode();
  TextEditingController codigoController = new TextEditingController();
  var focusNodeCEP = new FocusNode();
  var focusNodeNumero = new FocusNode();
  var textEditingControllerCEP = new TextEditingController();
  var textEditingControllerEstado = new TextEditingController();
  var textEditingControllerCidade = new TextEditingController();
  var textEditingControllerBairro = new TextEditingController();
  var textEditingControllerRua = new TextEditingController();
  var textEditingControllerNumero = new TextEditingController();
  TextEditingController complementoController = new TextEditingController();
  GlobalKey<ZProgressDialogState> _globalKey =
      new GlobalKey<ZProgressDialogState>();
  ITesteConexaoService _testeConexaoService;
  IEnderecoService _enderecoService;
  IContasService _contasService;

  DialogUtils _dialogUtils;
  final keyProgress = GlobalKey<ZProgressDialogState>();

  Uint8List imagemPerfil;
  InfoOrganizacaoViewModel infoOrganizacaoViewModel =
      new InfoOrganizacaoViewModel();

  InformacoesOrganizacaoView(State<InformacoesOrganizacao> state)
      : super(state);

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    throw UnimplementedError();
  }

  @override
  Future<void> initView() async {
    _dialogUtils = new DialogUtils(state.context);
    _testeConexaoService = new TesteConexaoService();
    _enderecoService = new EnderecoService();
    _contasService = new ContasService(
        "eyJhbGciOiJSUzI1NiIsImtpZCI6IjdmNWRhNTcwNzBmZTJhZjEyZmM5ZDNhMDAyNDM0ODgwIiwidHlwIjoiSldUIn0.eyJuYmYiOjE2MjI1NzU1NzIsImV4cCI6MTYyMjU3OTE3MiwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIiLCJhdWQiOlsiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIvcmVzb3VyY2VzIiwibW9sdHJlcy5hY2Vzc28uYXBpIl0sImNsaWVudF9pZCI6IlpHZXN0b3IiLCJzdWIiOiIwMjFmOTE4Mi0zZjQxLTRmMGEtYWFkYy00MDc3NmU2MGQwNGMiLCJhdXRoX3RpbWUiOjE2MjIyMTE0OTUsImlkcCI6ImxvY2FsIiwiQXNwTmV0LklkZW50aXR5LlNlY3VyaXR5U3RhbXAiOiIzS0U2RUNEUlRIR0dYQURBTUNXR1pHQUVEWDJEM1lPTCIsImFjY291bnQiOiJaZWxsYXIyIiwiaWRBY2NvdW50IjoiM2YyYmRjYmItNzY0Zi00OGM3LTBjMzMtMDhkN2NmNjNlNDViIiwiaWRDb2xhYm9yYWRvciI6IjE1ODQyQzJFLUM3RDctNERENS04RkE5LUZFMzNDQkQ2NENFQyIsInByZWZlcnJlZF91c2VybmFtZSI6IjQyNi45MTAuMjU4LTYxIiwiZW1haWwiOiJsdWl6Lmx1Y2lhQHplbGxhci5jb20uYnIiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsInBob25lX251bWJlcl92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJMdWl6IEx1Y2lhIE5ldG8iLCJwaG9uZV9udW1iZXIiOiIxMTk0ODQ4NDEyMCIsInNjb3BlIjpbIm9wZW5pZCIsInByb2ZpbGUiLCJlbWFpbCIsIm1vbHRyZXMuYWNlc3NvLmFwaS5mdWxsIiwib2ZmbGluZV9hY2Nlc3MiXSwiYW1yIjpbInB3ZCJdfQ.n1EzBL916Eip9as1Bajsazzrkb7_bdE0qFbhEl6sDMA_f_WT6IYEjjEEvDvBmL13LE1CorkC1TXdxDUsLvSujn_ouZHXAdEtPyGhkbyqrEk8WBqb8LfZaIi1vP35vf7jH37pSouuRQuvmKYLUNDY5U9wCU9eXNGoqtY03HQ3GZvP3Oqt2avz992TEKfud6hAToSKjY9eIWc_mdrv4adMfPWxHuCjW8QvtO3NMr8fOZnY32-VZXj5EMHLKnfKQlXKZkjhZnWNWI4xpjigGFuQVOYLyCq7OVXuynKR3NsqbzpPPBFiKL5-n2FWQztACc8USjB8YBNVnEie6qu_h_Xnjg");
    if (state.widget.infoOrganizacaoViewModel == null &&
        !state.widget.editarDados) {
      await _buscarDadosOrganizacao();
    } else {
      _popularControllers(state.widget.infoOrganizacaoViewModel);
    }

    if (state.widget.editarDados) {
      Future.delayed(Duration(milliseconds: 1000), () {
        FocusScope.of(state.context).requestFocus(telefoneFocusNode);
      });
    }
  }

  Future<void> showDialogCorPrimaria() {
    if (state.widget.editarDados) {
      return showDialog(
        context: state.context,
        builder: (_) => AlertDialog(
          title: const Text('Escolha a cor primária'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerPrimaria,
              onColorChanged: changeColorPrimaria,
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('Ok'),
              onPressed: () {
                if (corPrimaria != pickerPrimaria) {}
                state.setState(() => corPrimaria = pickerPrimaria);
                Navigator.of(state.context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  Future<void> showDialogCorSecundaria() {
    if (state.widget.editarDados) {
      return showDialog(
        context: state.context,
        builder: (_) => AlertDialog(
          title: const Text('Escolha a cor secundaria'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerSecundaria,
              onColorChanged: changeColorSecundaria,
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('Ok'),
              onPressed: () {
                if (corSecundaria != pickerSecundaria) {}
                state.setState(() => corSecundaria = pickerSecundaria);
                Navigator.of(state.context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  void changeColorPrimaria(Color color) {
    state.setState(() => pickerPrimaria = color);
    print(pickerPrimaria.value);
  }

  void changeColorSecundaria(Color color) {
    state.setState(() => pickerSecundaria = color);
  }

  Future escolherMetodoSelecionarFoto() {
    if (state.widget.editarDados) {
      return showModalBottomSheet<String>(
          context: state.context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          builder: (builder) {
            return new Container(
                height: 130,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: new Column(
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          padding: const EdgeInsets.only(top: 18, bottom: 8),
                          child: new Text(
                            "De onde você quer escolher a foto ?",
                            style: new TextStyle(color: Color(0xff999999)),
                          ),
                        )
                      ],
                    ),
                    new Divider(color: Color(0xffCECECE)),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Expanded(
                            flex: 5,
                            child: new GestureDetector(
                              onTap: () => escolherImagem(ImageSource.camera)
                                  .then((_) => _dialogUtils.dismiss()),
                              child: new Container(
                                color: Colors.transparent,
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Container(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: new Icon(
                                        Icons.camera_alt,
                                        color: MainStyle.get(state.context)
                                            .primaryColor,
                                      ),
                                    ),
                                    new Container(
                                      margin: const EdgeInsets.only(top: 6),
                                      child: new Text(
                                        "Usar Câmera",
                                        style: new TextStyle(
                                            color: Color(0xff999999)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                        new Expanded(
                            flex: 5,
                            child: new GestureDetector(
                                onTap: () => escolherImagem(ImageSource.gallery)
                                    .then((_) => _dialogUtils.dismiss()),
                                child: new Container(
                                  color: Colors.transparent,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Container(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: new Icon(
                                          Icons.add_photo_alternate,
                                          color: MainStyle.get(state.context)
                                              .primaryColor,
                                        ),
                                      ),
                                      new Container(
                                        margin: const EdgeInsets.only(top: 6),
                                        child: new Text(
                                          "Usar Galeria",
                                          style: new TextStyle(
                                              color: Color(0xff999999)),
                                        ),
                                      )
                                    ],
                                  ),
                                )))
                      ],
                    ),
                  ],
                ));
          });
    }
  }

  Future<void> escolherImagem(ImageSource source) async {
    var imagem = await ImagePicker.pickImage(source: source, imageQuality: 70);

    if (imagem != null) {
      var bytes = imagem.readAsBytesSync();

      var base64 = base64Encode(bytes);

      if (state.mounted) {
        state.setState(() {
          imagemPerfil = bytes;
        });
      }
    }
  }

  void onCEPChange(String cep) async {
    if (cep.length == 9) {
      _dialogUtils.showZProgressDialog("Buscando endereço...", 0.5, _globalKey);

      var endereco;

      var conexao = await _testeConexaoService.testarConexao();

      if (conexao == true) {
        endereco = await _enderecoService.buscarEnderecoPorCEP(cep);
        if (endereco != null) {
          _globalKey.currentState
              .refresh(1.0, "Endereço encontrado", success: true);

          if (state.mounted) {
            state.setState(() {
              textEditingControllerEstado.text = endereco.uf;
              textEditingControllerCidade.text = endereco.localidade;
              textEditingControllerBairro.text = endereco.bairro;
              textEditingControllerRua.text = endereco.logradouro;

              focusNodeNumero.requestFocus();
            });
          }
        } else {
          Future.delayed(Duration(milliseconds: 1000), () {
            _globalKey.currentState.refresh(
                1.0, "Não foi possível encontrar o endereço.",
                success: false);
          });
        }
      } else {
        Future.delayed(Duration(milliseconds: 1000), () {
          _globalKey.currentState.refresh(1.0,
              "Você está sem conexão, Não foi possível encontrar o endereço.",
              success: false);
        });
      }

      Future.delayed(new Duration(milliseconds: 1000), () {
        _dialogUtils.dismiss();
      });
    }
  }

  Future<void> _buscarDadosOrganizacao() async {
    var res = await _contasService.buscarDadosOrganizacao(state.widget.idConta);
    if (res != null) {
      infoOrganizacaoViewModel = res;
      _popularControllers(res);
    }
  }

  void _popularControllers(InfoOrganizacaoViewModel infoOrganizacaoViewModel) {
    nomeController.text = infoOrganizacaoViewModel.nome ?? "";
    nomeFantasiaController.text = infoOrganizacaoViewModel.nomeFantasia ?? "";
    textEditingControllerCEP.text = infoOrganizacaoViewModel.cep ?? "";
    textEditingControllerEstado.text = infoOrganizacaoViewModel.estado ?? "";
    textEditingControllerCidade.text = infoOrganizacaoViewModel.cidade ?? "";
    textEditingControllerBairro.text = infoOrganizacaoViewModel.bairro ?? "";
    textEditingControllerRua.text = infoOrganizacaoViewModel.logradouro ?? "";
    textEditingControllerNumero.text = infoOrganizacaoViewModel.numero ?? "";
    complementoController.text = infoOrganizacaoViewModel.complemento ?? "";
    emailController.text = infoOrganizacaoViewModel.email ?? "";
    telefoneController.text = infoOrganizacaoViewModel.telefone ?? "";
    codigoController.text = infoOrganizacaoViewModel.codigoAtivacao ?? "";
    if (infoOrganizacaoViewModel.tipoPessoa == "PJ") {
      cnpjController.text = infoOrganizacaoViewModel.cpfOuCNPJ ?? "";
    } else {
      cpfController.text = infoOrganizacaoViewModel.cpfOuCNPJ ?? "";
    }
  }

  void _atualizarViewModel(InfoOrganizacaoViewModel infoOrganizacaoViewModel) {
    infoOrganizacaoViewModel.nome = nomeController.text;
    infoOrganizacaoViewModel.nomeFantasia = nomeFantasiaController.text;
    infoOrganizacaoViewModel.cep = textEditingControllerCEP.text;
    infoOrganizacaoViewModel.estado = textEditingControllerEstado.text;
    infoOrganizacaoViewModel.cidade = textEditingControllerCidade.text;
    infoOrganizacaoViewModel.bairro = textEditingControllerBairro.text;
    infoOrganizacaoViewModel.logradouro = textEditingControllerRua.text;
    infoOrganizacaoViewModel.numero = textEditingControllerNumero.text;
    infoOrganizacaoViewModel.email = emailController.text;
    infoOrganizacaoViewModel.telefone = telefoneController.text;
    infoOrganizacaoViewModel.codigoAtivacao = codigoController.text;
    infoOrganizacaoViewModel.complemento = complementoController.text;
    if (infoOrganizacaoViewModel.tipoPessoa == "PJ") {
      infoOrganizacaoViewModel.cpfOuCNPJ = cnpjController.text;
    } else {
      infoOrganizacaoViewModel.cpfOuCNPJ = cpfController.text;
    }
  }

  Future<void> editarDadosOrganizacao() async {
    _dialogUtils.showZProgressDialog("Atualizando dados", 0.4, keyProgress);
    _atualizarViewModel(state.widget.infoOrganizacaoViewModel);
    state.widget.infoOrganizacaoViewModel.idConta = state.widget.idConta;

    var res = await _contasService
        .editarDadosOrganizacao(state.widget.infoOrganizacaoViewModel);

    if (res != null) {
      Future.delayed(Duration(milliseconds: 500), () {
        keyProgress.currentState.refresh(1.0, "Dados atualizados com sucesso!");
        Future.delayed(Duration(milliseconds: 1500), () {
          _dialogUtils.dismiss();
        });
      });
    } else {
      Future.delayed(Duration(milliseconds: 500), () {
        keyProgress.currentState.refresh(
            1.0, "Ocorreu um erro ao atualizar os dados.",
            success: false);
        Future.delayed(Duration(milliseconds: 1500), () {
          _dialogUtils.dismiss();
        });
      });
    }
  }
}
