import 'dart:convert';
import 'dart:typed_data';
import 'package:airplane_mode_detection/airplane_mode_detection.dart';
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
import 'package:z_components/components/z-progress-dialog.dart';
import 'package:z_components/components/z-user-info/z-user-info.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/arquivo-viewmodel.dart';
import 'package:z_components/view-model/buscarinfo-viewmodel.dart';
import '../../i-view.dart';
import '../z-alert-dialog.dart';

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

  BuscarInfo _userInfo;

  IIdentityServer _identityServer;

  GlobalKey<ZProgressDialogState> _globalKey =
      new GlobalKey<ZProgressDialogState>();

  DialogUtils _dialogUtils;

  Uint8List imagemPerfil;

  ZUserInfoView(State<ZUserInfo> state) : super(state);

  @override
  Future<void> initView() {
    _userInfo = new BuscarInfo();
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
    if (state.widget.userInfo.dataNascimento != null) {
      textEditingControllerDataNascimento.text =
          _montarData(state.widget.userInfo.dataNascimento);
    }
  }

  @override
  Future<void> afterBuild() async {
    if (state.widget.userInfo.fotoBase64.length > 0) {
      if (state.mounted) {
        state.setState(() {
          imagemPerfil =state.widget.userInfo.fotoBase64;
        });
      }
    }
  }

  void onCEPChange(String cep) async {
    if (cep.length == 9) {
      _dialogUtils.showZProgressDialog("Buscando endereço...", 0.5, _globalKey);

      var endereco;
      String modoAviao = await AirplaneModeDetection.detectAirplaneMode();

      if (modoAviao == "ON"){
        Future.delayed(Duration(milliseconds: 1000), () {
          _globalKey.currentState.refresh(
              1.0, "Você está com modo avião ativo, Não foi possível encontrar o endereço.",
              success: false);
        });
      } else {
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
                1.0, "Sem conexão, Não foi possível encontrar o endereço.",
                success: false);
          });
        }
      }

      Future.delayed(new Duration(seconds: 1), () {
        _dialogUtils.dismiss();
      });
    }
  }

  Future escolherMetodoSelecionarFoto() {
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

  Future<void> escolherImagem(ImageSource source) async {
    var imagem = await ImagePicker.pickImage(source: source, imageQuality: 70);

    if (imagem != null) {
      var bytes = imagem.readAsBytesSync();

      var base64 = base64Encode(bytes);

      if (state.mounted) {
        state.setState(() {
          imagemPerfil = bytes;
        });

        _arquivoService
            .enviarImagem(new ArquivoViewModel(
          nome: "perfil.jpg",
          contentType: "image/jpg",
          descricao: "Imagem de perfil do usuário",
          conteudo: base64,
          tamanho: base64.length.toDouble(),
          container: "teste",
        ))
            .then((idAnexo) {
          state.widget.userInfo.idFoto = idAnexo;
          if (state.widget.onChangeProfileImage != null)
            state.widget.onChangeProfileImage(base64);
        });
      }
    }
  }

  Future<void> submit() async {
    var userInfo = new BuscarInfo(
      idUsuario: state.widget.userInfo?.idUsuario,
      username: state.widget.userInfo?.username,
      cpf: state.widget.userInfo?.cpf,
      nomeSocial: state.widget.userInfo?.nomeSocial,
      idPessoa: state.widget.userInfo?.idPessoa,
      complemento: state.widget.userInfo?.complemento,
      celular: state.widget.userInfo?.celular,
      nome: textEditingControllerNome.text,
      bairro: textEditingControllerBairro.text,
      logradouro: textEditingControllerRua.text,
      cep: textEditingControllerCEP.text,
      estado: textEditingControllerEstado.text,
      dataNascimento: (textEditingControllerDataNascimento.text == "")
          ? null
          : "${textEditingControllerDataNascimento.text.split("/")[2]}-${textEditingControllerDataNascimento.text.split("/")[1]}-${textEditingControllerDataNascimento.text.split("/")[0]}",
      cidade: textEditingControllerCidade.text,
      telefone: textEditingControllerTelefone.text,
      email: textEditingControllerEmail.text,
      numero: textEditingControllerNumero.text,
      fotoBase64: (state.widget.userInfo.fotoBase64 == "")
          ? null
          : state.widget.userInfo.fotoBase64,
      idFoto: (state.widget.userInfo.idFoto == "")
          ? null
          : state.widget.userInfo.idFoto,
      anexoCartaoAlimentacaoStatus:
          state.widget.userInfo.anexoCartaoAlimentacaoStatus,
      anexoCartaoContaBancariaStatus:
          state.widget.userInfo.anexoCartaoContaBancariaStatus,
      anexoCartaoValeTransporteStatus:
          state.widget.userInfo.anexoCartaoValeTransporteStatus,
      anexoCarteiraVacinacaoStatus:
          state.widget.userInfo.anexoCarteiraVacinacaoStatus,
      anexoCertidaoNascimentoCasamentoStatus:
          state.widget.userInfo.anexoCertidaoNascimentoCasamentoStatus,
      anexoComprovanteEnderecoStatus:
          state.widget.userInfo.anexoComprovanteEnderecoStatus,
      anexoCPFStatus: state.widget.userInfo.anexoCPFStatus,
      anexoCTPSStatus: state.widget.userInfo.anexoCTPSStatus,
      anexoEscolaridadeStatus: state.widget.userInfo.anexoEscolaridadeStatus,
      anexoPISStatus: state.widget.userInfo.anexoPISStatus,
      anexoRGStatus: state.widget.userInfo.anexoRGStatus,
      anexoTituloEleitorStatus: state.widget.userInfo.anexoTituloEleitorStatus,
      idAnexoCartaoAlimentacao: state.widget.userInfo.idAnexoCartaoAlimentacao,
      idAnexoCartaoAlimentacao_Verso:
          state.widget.userInfo.idAnexoCartaoAlimentacao_Verso,
      idAnexoCartaoContaBancaria:
          state.widget.userInfo.idAnexoCartaoContaBancaria,
      idAnexoCartaoContaBancaria_Verso:
          state.widget.userInfo.idAnexoCartaoContaBancaria_Verso,
      idAnexoCartaoValeTransporte:
          state.widget.userInfo.idAnexoCartaoValeTransporte,
      idAnexoCartaoValeTransporte_Verso:
          state.widget.userInfo.idAnexoCartaoValeTransporte_Verso,
      idAnexoCarteiraVacinacao: state.widget.userInfo.idAnexoCarteiraVacinacao,
      idAnexoCarteiraVacinacao_Verso:
          state.widget.userInfo.idAnexoCarteiraVacinacao_Verso,
      idAnexoCertidaoNascimentoCasamento:
          state.widget.userInfo.idAnexoCertidaoNascimentoCasamento,
      idAnexoCertidaoNascimentoCasamento_Verso:
          state.widget.userInfo.idAnexoCertidaoNascimentoCasamento_Verso,
      idAnexoComprovanteEndereco:
          state.widget.userInfo.idAnexoComprovanteEndereco,
      idAnexoComprovanteEndereco_Verso:
          state.widget.userInfo.idAnexoComprovanteEndereco_Verso,
      idAnexoCPF: state.widget.userInfo.idAnexoCPF,
      idAnexoCPF_Verso: state.widget.userInfo.idAnexoCPF_Verso,
      idAnexoCTPS: state.widget.userInfo.idAnexoCTPS,
      idAnexoCTPS_Verso: state.widget.userInfo.idAnexoCTPS_Verso,
      idAnexoEscolaridade: state.widget.userInfo.idAnexoEscolaridade,
      idAnexoEscolaridade_Verso:
          state.widget.userInfo.idAnexoEscolaridade_Verso,
      idAnexoPIS: state.widget.userInfo.idAnexoPIS,
      idAnexoPIS_Verso: state.widget.userInfo.idAnexoPIS_Verso,
      idAnexoRG: state.widget.userInfo.idAnexoRG,
      idAnexoRG_Verso: state.widget.userInfo.idAnexoRG_Verso,
      idAnexoTituloEleitor: state.widget.userInfo.idAnexoTituloEleitor,
      idAnexoTituloEleitor_Verso:
          state.widget.userInfo.idAnexoTituloEleitor_Verso,
    );

    _dialogUtils.showZProgressDialog(
        "Salvando informações...", 0.7, _globalKey);

    var res = false;
    String modoAviao = await AirplaneModeDetection.detectAirplaneMode();

    if (modoAviao == "OFF") {
      res = await _userInfoService.editarInformacoes(userInfo);
    }

    if (res) {
      userInfo.atualizado = true;
    } else {
      userInfo.atualizado = false;
    }

    Future.delayed(Duration(milliseconds: 1000), () {
      _globalKey.currentState.refresh(1.0, "Pronto", success: true);
    });
    Future.delayed(new Duration(seconds: 1), () {
      _dialogUtils.dismiss();

      if (state.widget.onEditFinish != null)
        state.widget.onEditFinish(userInfo);
    });
  }

  void showAlertDialogNew(String title, String message) async {
    showDialog(
      context: state.context,
      builder: (BuildContext context) => ZAlertDialog(
        zDialog: ZDialog.alert,
        child: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.all(8),
                  child: new Text(title,
                      style: MainStyle.get(context).styleTittleDialog),
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  margin:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: new Text(
                    message,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        color: const Color(0xff707070),
                        fontSize: MainStyle.get(context).fontSizeEntradaSaida),
                  ),
                )
              ],
            ),
            new Divider(
              color: const Color(0xffdbdbdb),
            ),
            new Container(
              child: new InkWell(
                borderRadius: new BorderRadius.all(const Radius.circular(20.0)),
                splashColor: const Color(0xffe6e6e6),
                onTap: () {
                  Navigator.pop(context);
                },
                child: new Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: new Text(
                    "ENTENDI",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                            MainStyle.get(context).fontSizeLeadinCancelar),
                  ),
                ),
              ),
              margin: const EdgeInsets.only(bottom: 8),
            )
          ],
        ),
      ),
    );
  }

  String _montarData(String data) {
    if (data != null) {
      DateTime date = DateTime.parse(data);
      return "${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year}";
    } else {
      return "";
    }
  }
}
