import 'package:flutter/material.dart';
import 'package:mask_shifter/mask_shifter.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/styles/main-style.dart';

class ZInputGeneric extends StatefulWidget {
  final Key key;
  String hintText;
  String textMask;
  String titulo;
  bool comMascara;
  TextInputType tipoTeclado;
  FocusNode inputPadraoFocus;
  ValueChanged<String> onChange;
  bool obscureText;

  var controllerInputPadrao = new TextEditingController();
  FocusNode proximoFocus;

  ZInputGeneric({
    this.key,
    this.hintText: "",
    this.onChange,
    this.obscureText: false,
    this.tipoTeclado: TextInputType.text,
    this.comMascara:false,
    @required this.titulo,
    this.textMask,
    @required this.inputPadraoFocus,
    @required this.controllerInputPadrao,
    this.proximoFocus,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZInputGenericState();
}

class _ZInputGenericState extends State<ZInputGeneric> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new  Container(
      color: Colors.white,
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(widget.inputPadraoFocus);
        },
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Expanded(
                  flex: 3,
                  child: new Container(
                    padding: const EdgeInsets.only(
                        top: 12.0, bottom: 12.0, left: 16.0),
                    child: new Text( "${widget.titulo}:",
                        style: MainStyle.get(context).mainStyleTextBaseLine),
                  ),
                ),
                new Expanded(
                  flex: 7,
                  child: new Container(
                    margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                    child: (widget.comMascara == true)
                        ? new TextField(
                      keyboardAppearance: Brightness.light,
                      keyboardType: widget.tipoTeclado,
                      textCapitalization: TextCapitalization.words,
                      focusNode: widget.inputPadraoFocus,
                      obscureText: widget.obscureText,
                      controller: widget.controllerInputPadrao,
                      cursorColor: Color(0xFF2BBAB4),
                      style: MainStyle.get(context)
                          .mainStyleTextBaseLineInput,
                      inputFormatters: [
                        MaskedTextInputFormatterShifter(
                            maskONE: widget.textMask, maskTWO: widget.textMask)
                      ],
                      onSubmitted: (text) {
                        widget.inputPadraoFocus.unfocus();
                        if (widget.proximoFocus != null) {
                          FocusScope.of(context).requestFocus(widget.proximoFocus);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        hintStyle: MainStyle.get(context)
                            .mainStyleTextBaseLineHint,
                      ),
                      onChanged: (text){
                        if (widget.onChange != null) widget.onChange(text);

                      },
                    )
                        : new TextField(
                      keyboardAppearance: Brightness.light,
                      keyboardType: widget.tipoTeclado,
                      textCapitalization: TextCapitalization.words,
                      focusNode: widget.inputPadraoFocus,
                      obscureText: widget.obscureText,
                      controller: widget.controllerInputPadrao,
                      cursorColor: Color(0xFF2BBAB4),
                      style: MainStyle.get(context)
                          .mainStyleTextBaseLineInput,
                      onSubmitted: (text) {
                        widget.inputPadraoFocus.unfocus();
                        if (widget.proximoFocus != null) {
                          FocusScope.of(context).requestFocus(widget.proximoFocus);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        hintStyle: MainStyle.get(context)
                            .mainStyleTextBaseLineHint,
                      ),
                      onChanged: (text){
                        if (widget.onChange != null) widget.onChange(text);

                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
