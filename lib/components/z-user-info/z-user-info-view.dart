import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:z_components/api/arquivo/arquivo-service.dart';
import 'package:z_components/api/arquivo/i-arquivo-service.dart';
import 'package:z_components/api/endereco/endereco-service.dart';
import 'package:z_components/api/endereco/i-endereco-service.dart';
import 'package:z_components/api/identity-server/i-identity-server.dart';
import 'package:z_components/api/token-parser.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/z-identity-server/token-info.dart';
import 'package:z_components/components/z-injector/z-injector.dart';
import 'package:z_components/components/z-progress-dialog.dart';
import 'package:z_components/components/z-user-info/z-user-info.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/arquivo-viewmodel.dart';

import '../../i-view.dart';

class ZUserInfoView extends IView<ZUserInfo> {
  var textEditingControllerNome = new TextEditingController();
  var textEditingControllerTelefone = new TextEditingController();
  var textEditingControllerEmail = new TextEditingController();
  var textEditingControllerCEP = new TextEditingController();
  var textEditingControllerEstado = new TextEditingController();
  var textEditingControllerCidade = new TextEditingController();
  var textEditingControllerBairro = new TextEditingController();
  var textEditingControllerRua = new TextEditingController();
  var textEditingControllerNumero = new TextEditingController();

  var focusNodeNome = new FocusNode();
  var focusNodeTelefone = new FocusNode();
  var focusNodeEmail = new FocusNode();
  var focusNodeCEP = new FocusNode();
  var focusNodeNumero = new FocusNode();

  IEnderecoService _enderecoService;
  IArquivoService _arquivoService;

  UserInfo _userInfo;

  IIdentityServer _identityServer;

  GlobalKey<ZProgressDialogState> _globalKey =
      new GlobalKey<ZProgressDialogState>();

  DialogUtils _dialogUtils;

  Uint8List imagemPerfil;

  ZUserInfoView(State<ZUserInfo> state) : super(state);

  @override
  Future<void> initView() {
    _userInfo = new UserInfo();
    _dialogUtils = new DialogUtils(state.context);
    _enderecoService = new EnderecoService();
    _arquivoService = new ArquivoService(state.widget.token);
  }

  @override
  Future<void> afterBuild() async {
    _dialogUtils.showZProgressDialog("Buscando informações", 0.3, _globalKey);

    await _identityServer.setUserInfo();
    var userInfo = _identityServer.getUserInfo();

    _globalKey.currentState.refresh(1.0, "Pronto", success: true);

    Future.delayed(new Duration(seconds: 1), () {
      _dialogUtils.dismiss();

      if (userInfo != null) {
        if (state.mounted) {
          state.setState(() {
            _userInfo = userInfo;
          });
        }
      }
    });
  }

  void onCEPChange(String cep) async {
    if (cep.length == 9) {
      _dialogUtils.showZProgressDialog("Buscando endereço...", 0.5, _globalKey);

      var endereco = await _enderecoService.buscarEnderecoPorCEP(cep);

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
        _globalKey.currentState.refresh(
            1.0, "Não foi possível encontrar o endereço, tenta novamente",
            success: false);
      }

      Future.delayed(new Duration(seconds: 1), () {
        _dialogUtils.dismiss();
      });
    }
  }

  Future escolherMetodoSelecionarFoto() {
    return showModalBottomSheet(
        context: state.context,
        builder: (context) {
          return new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  "De onde você quer escolher a foto ?",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new IconButton(
                            icon: new Icon(Icons.image,
                                color: MainStyle.get(context).primaryColor),
                            onPressed: () => escolherImagem(ImageSource.gallery)
                                .then((_) => _dialogUtils.dismiss())),
                        new Text("Galeria")
                      ],
                    ),
                    new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new IconButton(
                            icon: new Icon(Icons.camera_alt,
                                color: MainStyle.get(context).primaryColor),
                            onPressed: () => escolherImagem(ImageSource.camera)
                                .then((_) => _dialogUtils.dismiss())),
                        new Text("Câmera")
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  Future<void> escolherImagem(ImageSource source) async {
    var imagem = await ImagePicker.pickImage(source: source, imageQuality: 70);

    if (imagem != null) {
      var base64 = base64Encode(imagem.readAsBytesSync());

      var res = await _arquivoService.enviarImagem(new ArquivoViewModel(
        nome: "perfil.jpg",
        contentType: "image/jpg",
        descricao: "Imagem de perfil do usuário",
        conteudo: base64,
        tamanho: base64.length.toDouble(),
        container: "teste",
      ));

      if (res != null) {
        var anexo = await _arquivoService.buscarAnexo(res);

        if (anexo != null) {
          if (state.mounted) {
            state.setState(() {
              imagemPerfil = base64Decode(anexo.conteudo);
            });
          }
        }
      }
    }
  }
}
