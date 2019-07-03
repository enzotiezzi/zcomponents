import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-baseline.dart';
import 'package:z_components/components/z-pin-senha.dart';
import 'package:z_components/components/z_button.dart';
import 'package:z_components/config/z-button-type.dart';
import 'package:z_components/config/z-tipo-senha.dart';
import 'package:z_components/config/z-tipos-baseline.dart';

class ZCadastroUsuario extends StatefulWidget {
  Widget zTelaCadastro;

  final Key key;
  final BuildContext context;



  ZCadastroUsuario(
      {this.key,
        this.context,
    });

  @override
  _ZCadastroUsuarioState createState() => _ZCadastroUsuarioState();
}

class _ZCadastroUsuarioState extends State<ZCadastroUsuario> with TickerProviderStateMixin{
  bool _termos = false;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(      backgroundColor: Color(0xffefeff4),

        appBar: CupertinoNavigationBar(

leading: IconButton(onPressed:()=> Navigator.of(context).pop(),
icon:  new Icon(
  Icons.arrow_back_ios,
  size: 20.0,
  color: const Color(0xff2BB9B4),
),splashColor: Colors.transparent,
),
    ),body:
    _body());
  }
  Widget _body(){
    return new Column(children: <Widget>[
      _titulo(),
     new Expanded(child:  _buildBody(),),

    ],);
  }
  Widget _buildBody(){

    return new ListView(children: <Widget>[
      new Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
        padding: EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
        alignment: Alignment.centerLeft,
        child: new Text(
          "DADOS PESSOAIS",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
        ),
      ),
      new ZBaseLine(
        zTipos: ZTipoBaseline.isNomeCompleto,
        context: context,
      ),
      new ZBaseLine(
        zTipos: ZTipoBaseline.isCPF,
        context: context,
      ),
      new ZBaseLine(
        zTipos: ZTipoBaseline.isCelular,
        context: context,
      ),
      new ZBaseLine(
        zTipos: ZTipoBaseline.isEmail,
        context: context,
      ),
      new ZBaseLine(
        zTipos: ZTipoBaseline.isDataNascimento,
        context: context,
      ),
      new Container(
        decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey))),
        padding: EdgeInsets.only(left: 15.0,bottom: 15.0,top: 8),
        alignment: Alignment.centerLeft,
        child: new Text(
          "SEGURANÇA",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
        ),
      ),
      new ZPinSenha(
        context: context, numeroQuadrados: 4, zTipos: ZTipoSenha.isSenha,),
      new ZPinSenha(context: context,
        numeroQuadrados: 4,
        zTipos: ZTipoSenha.isRepetirSenha,),
      new Container(
        child: new GestureDetector(
          onTap: () {
            setState(() {
          _termos = !_termos;
            });
          },
          child: new Container(
              margin: EdgeInsets.only(
                  left: 75.0, right: 75.0, top: 15.0, bottom: 0.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              child: new Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 1,
                  child: new Container(
                    padding: EdgeInsets.all(2),
                    child: new Row(
                      children: <Widget>[
                        new Container(
                            decoration: BoxDecoration(
                                color: (_termos == false)
                                    ? Colors.white
                                    : Color(0xff2BB9B4),
                                border:
                                Border.all(color: Colors.grey.withOpacity(0.6)),
                                shape: BoxShape.circle),
                            height: 25.0,
                            width: 25.0,
                            child: new AnimatedSize(
                              duration: Duration(milliseconds: 5000),
                              curve: Curves.fastOutSlowIn,
                              vsync: this,
                              child: new Icon(Icons.check,
                                  color: Colors.white,
                                  size: (_termos == true) ? 20.0 : 0.0),
                            )),
                        new Container(
                          margin: EdgeInsets.only(left: 4.0),
                          child: new Text(
                            "ACEITO OS TERMOS DE USO",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                                color: const Color(0xff2BB9B4)),
                          ),
                        )
                      ],
                    ),
                  )
              )
          ),
        ),
      ),
      new Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 20.0,top: 40),
        child: ZButton(zButtonType: ZButtonType.isCadastro,
        text: "CADASTRAR USUÁRIO",)
      ),
    ],);
  }
  Widget _titulo() {
    return new Container(
      decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          border: Border(
              bottom:
              BorderSide(width: 3, color: Colors.grey.withOpacity(0.5)))),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 16.0, bottom: 10.0, top: 10.0),
      child: new Text("CADASTRO DE USUÁRIO",
          style: new TextStyle(
            fontSize: 18.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          )),
    );
  }


}
