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
import 'package:z_components/api/teste-conexao/i-teste-conexao-service.dart';
import 'package:z_components/api/teste-conexao/teste-conexao-service.dart';
import 'package:z_components/api/user-info/i-user-info-service.dart';
import 'package:z_components/api/user-info/user-info-service.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/utils/novo_token.dart';
import 'package:z_components/components/z-collection/z-collection-bottomsheet.dart';
import 'package:z_components/components/z-collection/z-collection-item.dart';
import 'package:z_components/components/z-inputs/z-input-celular.dart';
import 'package:z_components/components/z-inputs/z-input-email.dart';
import 'package:z_components/components/z-inputs/z-input-generic.dart';
import 'package:z_components/components/z-inputs/z-input-telefone-fixo.dart';
import 'package:z_components/components/z-progress-dialog.dart';
import 'package:z_components/components/z-tile.dart';
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
  var textEditingControllerTelefoneSec = new TextEditingController();
  var textEditingControllerEmail = new TextEditingController();
  var textEditingControllerCEP = new TextEditingController();
  var textEditingControllerEstado = new TextEditingController();
  var textEditingControllerCidade = new TextEditingController();
  var textEditingControllerBairro = new TextEditingController();
  var textEditingControllerRua = new TextEditingController();
  var textEditingControllerNumero = new TextEditingController();
  var textEditingControllerEmailSec = new TextEditingController();
  var textEditingControllerCPF = new TextEditingController();
  var textEditingControllerNomeReduzido = new TextEditingController();

  var focusNodeNome = new FocusNode();
  var focusNodeDataNascimento = new FocusNode();
  var focusNodeTelefone = new FocusNode();
  var focusNodeTelefoneSec = new FocusNode();
  var focusNodeEmail = new FocusNode();
  var focusNodeCEP = new FocusNode();
  var focusNodeNumero = new FocusNode();
  var focusNodeCPF = new FocusNode();
  var focusNodeNomeReduzido = new FocusNode();
  var focusTelefoneSec = new FocusNode();
  var focusEmailSec = new FocusNode();

  IArquivoService _arquivoService;
  IUserInfoService _userInfoService;
  ITesteConexaoService _testeConexaoService;

  String textoFoto = "";

  String textoTelefone = "ADICIONAR TELEFONE";
  String textoEmail = "ADICIONAR EMAIL";
  String tipoTelSelecionado = "";
  String tipoTelSecSelecionado = "";
  String tipoEmailSelecionado = "";
  String tipoEmailSecSelecionado = "";
  bool flagTel = true;
  bool flagEmail = true;
  bool flagTelSec = false;
  bool flagEmailSec = false;
  Color flagColor = Color(0xFF2BBAB4);
  Color flagColorSec = Color(0xFFE6E6E6);
  Color flagEmailColor = Color(0xFF2BBAB4);
  Color flagEmailColorSec = Color(0xFFE6E6E6);
  bool segundoTel = false;
  bool segundoEmail = false;
  Icon icon = Icon(Icons.add);
  Icon iconEmail = Icon(Icons.add);
  String mascara = "";
  String hint = "";
  String mascaraSec = "";
  String hintSec = "";
  bool preencheuNome = false;
  bool camposObrigatoriosValidados = false;
  bool preencheuEmail = false;
  bool preencheuTelefone = false;

  BuscarInfo _userInfo;

  GlobalKey<ZProgressDialogState> _globalKey =
      new GlobalKey<ZProgressDialogState>();

  DialogUtils _dialogUtils;

  Uint8List imagemPerfil;

  ZUserInfoView(State<ZUserInfo> state) : super(state);

  @override
  Future<void> initView() async {
    _userInfo = new BuscarInfo();
    _dialogUtils = new DialogUtils(state.context);
    _arquivoService = new ArquivoService(NovoToken.newToken);
    _userInfoService = new UserInfoService(NovoToken.newToken);
    _testeConexaoService = new TesteConexaoService();
    if (state.widget.editarAtivo) {
      Future.delayed(Duration(milliseconds: 400), () {
        FocusScope.of(state.context).requestFocus(focusNodeNome);
      });
    }
    await _buscarInfo();
  }

  @override
  Future<void> afterBuild() async {}

  bool validarCamposObrigatorios() {
    if (preencheuNome) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _buscarInfo() async {
    var res = await _userInfoService.buscarInformacoesUsuarioPessoa();
    if (res != null) {
      _userInfo = res;
      _preencherControllers();
      if (state.mounted) {
        state.setState(() {});
      }
    }
  }

  void _preencherControllers() {
    textEditingControllerNome.text = _userInfo?.nome;
    textEditingControllerTelefone.text = _userInfo?.telefone;
    textEditingControllerEmail.text = _userInfo?.email;
    textEditingControllerCPF.text = _userInfo?.username;
    textEditingControllerNomeReduzido.text = _userInfo?.nomeReduzido;
  }

  Future escolherMetodoSelecionarFoto() {
    if (state.widget.editarAtivo) {
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

        var idAnexo = await _arquivoService.enviarImagem(new ArquivoViewModel(
          nome: "perfil.jpg",
          contentType: "image/jpg",
          descricao: "Imagem de perfil do usuário",
          conteudo: base64,
          tamanho: base64.length.toDouble(),
          container: "teste",
        ));

        state.widget.userInfo.idFoto = idAnexo;

        if (state.widget.onChangeProfileImage != null)
          state.widget.onChangeProfileImage(base64);
      }
    }
  }

  Future<void> submit() async {
    var userInfo = new BuscarInfo(
      idUsuario: state.widget.userInfo?.idUsuario,
      username: state.widget.userInfo?.username,
      cpf: state.widget.userInfo?.username,
      idPessoa: state.widget.userInfo?.idPessoa,
      celular: state.widget.userInfo?.celular,
      nome: textEditingControllerNome.text,
      dataNascimento: (textEditingControllerDataNascimento.text != "" &&
              textEditingControllerDataNascimento.text != null)
          ? "${textEditingControllerDataNascimento.text.split("/")[2]}-${textEditingControllerDataNascimento.text.split("/")[1]}-${textEditingControllerDataNascimento.text.split("/")[0]}"
          : null,
      telefone: textEditingControllerTelefone.text,
      email: textEditingControllerEmail.text,
      nomeReduzido: textEditingControllerNomeReduzido.text,
      fotoBase64: (state.widget.userInfo.fotoBase64 == null)
          ? null
          : state.widget.userInfo.fotoBase64,
      idFoto: (state.widget.userInfo.idFoto == "")
          ? null
          : state.widget.userInfo.idFoto,
    );

    _dialogUtils.showZProgressDialog(
        "Salvando informações...", 0.7, _globalKey);

    var res = false;

    var conexao = await _testeConexaoService.testarConexao();

    if (conexao) {
      res = await _userInfoService.editarInformacoes(userInfo);
    }

    if (res) {
      Future.delayed(Duration(milliseconds: 1000), () {
        _globalKey.currentState.refresh(1.0, "Pronto", success: true);
      });
      Future.delayed(new Duration(milliseconds: 2000), () {
        _dialogUtils.dismiss();
        Navigator.of(state.context).pop();

        if (state.widget.onEditFinish != null)
          state.widget.onEditFinish(userInfo);
      });
    } else {
      Future.delayed(Duration(milliseconds: 1000), () {
        _globalKey.currentState.refresh(1.0, "Erro ao criar o usuário", success: false);
      });
      Future.delayed(new Duration(milliseconds: 2000), () {
        _dialogUtils.dismiss();

        if (state.widget.onEditFinish != null)
          state.widget.onEditFinish(userInfo);
      });
    }


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
}
