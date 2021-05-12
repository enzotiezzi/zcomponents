import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_shifter/mask_shifter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/styles/main-style.dart';

class ZInputGeneric extends StatefulWidget {
  final Key key;
  final ThemeData themeData;
  String hintText;
  String textMask;
  String titulo;
  bool comMascara;
  TextInputType tipoTeclado;
  FocusNode inputPadraoFocus;
  ValueChanged<String> onChange;
  bool obscureText;
  bool enabled;
  final bool campoObrigatorio;
  int maxLength;

  var controllerInputPadrao = new TextEditingController();
  FocusNode proximoFocus;

  ZInputGeneric(
      {this.key,
      this.hintText: "",
      this.onChange,
      this.obscureText: false,
      this.tipoTeclado: TextInputType.text,
      this.comMascara: false,
      @required this.themeData,
      @required this.titulo,
      this.textMask,
      @required this.inputPadraoFocus,
      @required this.controllerInputPadrao,
      this.proximoFocus,
      this.maxLength,
      this.enabled,
      this.campoObrigatorio = false})
      : super(key: key);

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
    return new Container(
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(widget.inputPadraoFocus);
        },
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Expanded(
                  flex: 4,
                  child: new Container(
                    padding: const EdgeInsets.only(
                        top: 12.0, bottom: 12.0, left: 16.0),
                    child: _returnRequiredField(),
                  ),
                ),
                new Expanded(
                  flex: 7,
                  child: new Container(
                    margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                    child: (widget.comMascara == true)
                        ? new TextField(
                            enabled: widget.enabled,
                            keyboardAppearance: Brightness.light,
                            keyboardType: widget.tipoTeclado,
                            textCapitalization: TextCapitalization.words,
                            focusNode: widget.inputPadraoFocus,
                            obscureText: widget.obscureText,
                            controller: widget.controllerInputPadrao,
                            cursorColor: Color(0xFF801F92),
                            style: widget.themeData.textTheme.bodyText1,
                            inputFormatters: [
                              MaskTextInputFormatter(
                                mask: widget.textMask,
                              ),
                              LengthLimitingTextInputFormatter(widget.maxLength??1000),
                            ],
                            onSubmitted: (text) {
                              widget.inputPadraoFocus.unfocus();
                              if (widget.proximoFocus != null) {
                                FocusScope.of(context)
                                    .requestFocus(widget.proximoFocus);
                              }
                            },
                            decoration: InputDecoration(
                              hintText: widget.hintText,
                              hintStyle: widget.themeData.textTheme.bodyText1
                                  .copyWith(color: Color(0xFFC7C7C7)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFf0f0f0)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF801F92)),
                              ),
                            ),
                            onChanged: (text) {
                              if (widget.onChange != null)
                                widget.onChange(text);

                            },
                          )
                        : new TextField(
                            enabled: widget.enabled,
                            keyboardAppearance: Brightness.light,
                            keyboardType: widget.tipoTeclado,
                            textCapitalization: TextCapitalization.words,
                            focusNode: widget.inputPadraoFocus,
                            obscureText: widget.obscureText,
                            controller: widget.controllerInputPadrao,
                            cursorColor: Color(0xFF801F92),
                            style: widget.themeData.textTheme.bodyText1,
                            maxLengthEnforcement: MaxLengthEnforcement.none,
                            onSubmitted: (text) {
                              widget.inputPadraoFocus.unfocus();
                              if (widget.proximoFocus != null) {
                                FocusScope.of(context)
                                    .requestFocus(widget.proximoFocus);
                              }
                            },  inputFormatters: [
                      LengthLimitingTextInputFormatter(widget.maxLength??1000),
                    ],
                            decoration: InputDecoration(
                              hintText: widget.hintText,
                              hintStyle: widget.themeData.textTheme.bodyText1
                                  .copyWith(color: Color(0xFFC7C7C7)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFf0f0f0)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF801F92)),
                              ),
                            ),
                            onChanged: (text) {
                              if (widget.onChange != null)
                                widget.onChange(text);
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

  Widget _returnRequiredField() {
    if (widget.campoObrigatorio) {
      return new RichText(
        maxLines: 2,
        text: TextSpan(
          children: <TextSpan>[
            new TextSpan(
              text: "${widget.titulo}",
              style: widget.themeData.textTheme.bodyText1
                  .copyWith(color: Color(0xff999999)),
            ),
            TextSpan(text: "*", style: TextStyle(color: Colors.redAccent))
          ],
        ),
      );
    } else {
      return RichText(
          maxLines: 2,
          text: TextSpan(children: <TextSpan>[
            new TextSpan(
              text: "${widget.titulo}",
              style: widget.themeData.textTheme.bodyText1
                  .copyWith(color: Color(0xff999999)),
            )
          ]));
    }
  }
}
