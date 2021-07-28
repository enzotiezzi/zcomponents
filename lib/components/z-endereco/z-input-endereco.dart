import 'package:flutter/material.dart';
import 'package:z_components/components/z-endereco/z-input-campos-endereco.dart';

class ZInputEndereco extends StatefulWidget {
  final bool campoObrigatorio;
  final ThemeData themeData;
  final TextEditingController cepController;
  final TextEditingController logradouroController;
  final TextEditingController numeroController;
  final TextEditingController complementoController;
  final TextEditingController bairroController;
  final TextEditingController cidadeController;
  final TextEditingController estadoController;

  ZInputEndereco({
    this.campoObrigatorio=false,
    @required this.themeData,
    @required this.cepController,
    @required this.logradouroController,
    @required this.numeroController,
    @required this.complementoController,
    @required this.bairroController,
    @required this.cidadeController,
    @required this.estadoController,
    }
    );
  @override
  _ZInputEnderecoState createState() => _ZInputEnderecoState();
}

class _ZInputEnderecoState extends State<ZInputEndereco> {
  String endereco;
  String _anterior = "Selecione seu endereço";
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Column(
        children: [
          new Container(
            height: 39,
            color: Colors.white,
            padding: EdgeInsets.only(left: 16.0, right: 14),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _returnRequiredField(),
                new Flexible(
                    flex: 65,
                    fit: FlexFit.tight,
                    child: new Text(
                      (endereco == null || endereco.isEmpty &&
                          _anterior.contains("Selecione"))
                          ? _anterior
                          : endereco,
                      style:  _retornaCorTexto(),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )),
                new Flexible(
                  flex: 10,
                  fit: FlexFit.tight,
                  child: new Icon(
                    Icons.keyboard_arrow_right,
                    color: _retornaCorIcon(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      onTap: ()async{
        final resultado  = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context)=> ZInputCamposEndereco(
                    themeData: widget.themeData,
                  cepController: widget.cepController,
                  numeroController: widget.numeroController,
                  logradouroController: widget.logradouroController,
                  estadoController: widget.estadoController,
                  complementoController: widget.complementoController,
                  cidadeController: widget.cidadeController,
                  bairroController: widget.bairroController,
                    )
            )
        );
        print("endereço");
        print(resultado);
        setState(() {
          endereco = resultado;
        });
      },
    );
  }

  Color _retornaCorIcon(){
    if(endereco == null || endereco.isEmpty && _anterior.contains("Selecione")){
      return widget.themeData.primaryColor;
    }
    else{
      return Colors.black;
    }
  }

  TextStyle _retornaCorTexto(){
    if(endereco == null || endereco.isEmpty && _anterior.contains("Selecione")){
      return widget.themeData.textTheme.bodyText1.copyWith(color: widget.themeData.primaryColor);
    }
    else{
      return widget.themeData.textTheme.bodyText1.copyWith(color: Colors.black);
    }
  }

  Widget _returnRequiredField() {
    if (widget.campoObrigatorio) {
      return Flexible(
        flex: 45,
        fit: FlexFit.tight,
        child: new RichText(
          maxLines: 2,
          text: TextSpan(
            children: <TextSpan>[
              new TextSpan(
                text: "Endereço",
                style: widget.themeData.textTheme.bodyText1
                    .copyWith(color: Color(0xff999999)),
              ),
              TextSpan(text: "*", style: TextStyle(color: Colors.redAccent))
            ],
          ),
        ),
      );
    } else {
      return Flexible(
        flex: 45,
        fit: FlexFit.tight,
        child: RichText(
          maxLines: 2,
          text: TextSpan(
            children: <TextSpan>[
              new TextSpan(
                text: "Endereço",
                style: widget.themeData.textTheme.bodyText1
                    .copyWith(color: Color(0xff999999)),
              ),
            ],
          ),
        ),
      );
    }
  }
}
