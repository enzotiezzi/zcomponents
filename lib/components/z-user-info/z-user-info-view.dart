import 'package:flutter/cupertino.dart';
import 'package:z_components/api/token-parser.dart';
import 'package:z_components/components/z-identity-server/token-info.dart';
import 'package:z_components/components/z-user-info/z-user-info.dart';

import '../../i-view.dart';

class ZUserInfoView extends IView<ZUserInfo>{
  var textEditingControllerNome = new TextEditingController();
  var textEditingControllerTelefone = new TextEditingController();
  var textEditingControllerEmail = new TextEditingController();

  var focusNodeNome = new FocusNode();
  var focusNodeTelefone = new FocusNode();
  var focusNodeEmail = new FocusNode();

  TokenInfo _tokenInfo;

  ZUserInfoView(State<ZUserInfo> state) : super(state);

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    return null;
  }

  @override
  Future<void> initView() {
    _tokenInfo = TokenInfo.fromJson(TokenParser.parseJwt(state.widget.token));

    textEditingControllerNome.text = _tokenInfo.nome;
    textEditingControllerEmail.text = _tokenInfo.email;
    textEditingControllerTelefone.text = _tokenInfo.telefone;
  }
}