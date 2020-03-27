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
import 'package:z_components/api/user-info/i-user-info-service.dart';
import 'package:z_components/api/user-info/user-info-service.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/z-identity-server/token-info.dart';
import 'package:z_components/components/z-progress-dialog.dart';
import 'package:z_components/components/z-user-info/z-user-info.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/arquivo-viewmodel.dart';

import '../../i-view.dart';

class ZUserInfoView extends IView<ZUserInfo> {
  var textEditingControllerNome = new TextEditingController();
  var textEditingControllerDataNascimento = new TextEditingController();
  var textEditingControllerTelefone = new TextEditingController();
  var textEditingControllerEmail = new TextEditingController();
  var textEditingControllerCEP = new TextEditingController();
  var textEditingControllerEstado = new TextEditingController();
  var textEditingControllerCidade = new TextEditingController();
  var textEditingControllerBairro = new TextEditingController();
  var textEditingControllerRua = new TextEditingController();
  var textEditingControllerNumero = new TextEditingController();

  var focusNodeNome = new FocusNode();
  var focusNodeDataNascimento = new FocusNode();
  var focusNodeTelefone = new FocusNode();
  var focusNodeEmail = new FocusNode();
  var focusNodeCEP = new FocusNode();
  var focusNodeNumero = new FocusNode();

  IEnderecoService _enderecoService;
  IArquivoService _arquivoService;
  IUserInfoService _userInfoService;

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
    _userInfoService = new UserInfoService(state.widget.token);

    textEditingControllerNome.text = state.widget.userInfo?.nome;
    textEditingControllerTelefone.text = state.widget.userInfo?.telefone;
    textEditingControllerEmail.text = state.widget.userInfo?.email;
    textEditingControllerCEP.text = state.widget.userInfo?.cep;
    textEditingControllerEstado.text = state.widget.userInfo?.estado;
    textEditingControllerCidade.text = state.widget.userInfo?.cidade;
    textEditingControllerBairro.text = state.widget.userInfo?.bairro;
    textEditingControllerRua.text = state.widget.userInfo?.logradouro;
    textEditingControllerNumero.text = state.widget.userInfo?.numero;
  }

  @override
  Future<void> afterBuild() async {
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
      var bytes = imagem.readAsBytesSync();

      var base64 = base64Encode(bytes);

      if (state.mounted) {
        state.setState(() {
          imagemPerfil = bytes;
        });

        _arquivoService.enviarImagem(new ArquivoViewModel(
          nome: "perfil.jpg",
          contentType: "image/jpg",
          descricao: "Imagem de perfil do usuário",
          conteudo: base64,
          tamanho: base64.length.toDouble(),
          container: "teste",
        )).then((idAnexo){
          state.widget.userInfo.idFoto = idAnexo;
          if(state.widget.onChangeProfileImage != null) state.widget.onChangeProfileImage(idAnexo);
        });
      }
    }
  }

  Future<void> submit() async {
    var userInfo = new UserInfo(
      nome: textEditingControllerNome.text,
      bairro: textEditingControllerBairro.text,
      logradouro: textEditingControllerRua.text,
      cep: textEditingControllerCEP.text,
      estado: textEditingControllerEstado.text,
      dataNascimento: textEditingControllerDataNascimento.text,
      cidade: textEditingControllerCidade.text,
      telefone: textEditingControllerTelefone.text,
      email: textEditingControllerEmail.text,
      numero: textEditingControllerNumero.text,
      idFoto: state.widget.userInfo.idFoto
    );

    _dialogUtils.showZProgressDialog("Salvando informações...", 0.7, _globalKey);

    var res = await _userInfoService.editarInformacoes(userInfo);

    if(res)
      _globalKey.currentState.refresh(1.0, "Pronto", success: true);
    else
      _globalKey.currentState.refresh(1.0, "Não foi possível editar as informações", success: false);

    Future.delayed(new Duration(seconds: 1), (){
      _dialogUtils.dismiss();

      if(state.widget.onEditFinish != null) state.widget.onEditFinish(userInfo);
    });
  }
}
