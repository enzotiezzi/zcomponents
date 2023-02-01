import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ZInputGeneric extends StatefulWidget {
  final Key? key;
  final ThemeData? themeData;
  String? hintText;
  String? textMask;
  String? titulo;
  bool? comMascara;
  bool? barrarEntradaDeNumeros;
  TextInputType? tipoTeclado;
  FocusNode? inputPadraoFocus;
  ValueChanged<String>? onChange;
  bool? obscureText;
  bool? enabled;
  final bool? campoObrigatorio;
  int? maxLength;

  TextEditingController? controllerInputPadrao;
  FocusNode? proximoFocus;

  ZInputGeneric(
      {this.key,
      this.hintText: "",
      this.onChange,
      this.obscureText: false,
      this.tipoTeclado: TextInputType.text,
      this.comMascara: false,
      this.barrarEntradaDeNumeros: false,
      @required this.themeData,
      @required this.titulo,
      this.textMask,
      @required this.inputPadraoFocus,
      @required this.controllerInputPadrao,
      this.proximoFocus,
      this.maxLength,
      this.enabled: true,
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
                            obscureText: widget.obscureText!,
                            controller: widget.controllerInputPadrao,
                            cursorColor: widget.themeData!.primaryColor,
                            style: widget.themeData!.textTheme.bodyText1
                                !.copyWith(
                                    color: corTexto(
                                        widget.themeData!, widget.enabled!)),
                            inputFormatters: _retornaListaDeFormatacoes(),
                            onSubmitted: (text) {
                              if (widget.inputPadraoFocus != null)
                                widget.inputPadraoFocus!.unfocus();
                              if (widget.proximoFocus != null) {
                                FocusScope.of(context)
                                    .requestFocus(widget.proximoFocus);
                              }
                            },
                            decoration: InputDecoration(
                              hintText: widget.hintText,
                              hintStyle: widget.themeData!.textTheme.bodyText1!
                                  .copyWith(color: Color(0xFFC7C7C7)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFf0f0f0)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: widget.themeData!.primaryColor),
                              ),
                            ),
                            onChanged: (text) {
                              if (widget.onChange != null)
                                widget.onChange!(text);
                            },
                          )
                        : new TextField(
                            enabled: widget.enabled,
                            keyboardAppearance: Brightness.light,
                            keyboardType: widget.tipoTeclado,
                            textCapitalization: TextCapitalization.words,
                            focusNode: widget.inputPadraoFocus,
                            obscureText: widget.obscureText!,
                            controller: widget.controllerInputPadrao,
                            cursorColor: widget.themeData!.primaryColor,
                            style: widget.themeData!.textTheme.bodyText1
                                !.copyWith(
                                    color: corTexto(
                                        widget.themeData!, widget.enabled!)),
                            maxLengthEnforcement: MaxLengthEnforcement.none,
                            onSubmitted: (text) {
                              if (widget.inputPadraoFocus != null)
                                widget.inputPadraoFocus?.unfocus();
                              if (widget.proximoFocus != null) {
                                FocusScope.of(context)
                                    .requestFocus(widget.proximoFocus);
                              }
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                  widget.maxLength ?? 1000),
                            ],
                            decoration: InputDecoration(
                              hintText: widget.hintText,
                              hintStyle: widget.themeData!.textTheme.bodyText1
                                  !.copyWith(color: Color(0xFFC7C7C7)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFf0f0f0)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: widget.themeData!.primaryColor),
                              ),
                            ),
                            onChanged: (text) {
                              if (widget.onChange != null)
                                widget.onChange!(text);
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

  List<TextInputFormatter> _retornaListaDeFormatacoes() {
    if(widget.barrarEntradaDeNumeros!){
      return [
        new FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
        new MaskTextInputFormatter(
          mask: widget.textMask,
        ),
        new LengthLimitingTextInputFormatter(
            widget.maxLength ?? 1000),
      ];
    }else{
      return [
        new MaskTextInputFormatter(
          mask: widget.textMask,
        ),
        new LengthLimitingTextInputFormatter(
            widget.maxLength ?? 1000),
      ];
    }
  }

  Color corTexto(ThemeData themeData, bool enabled) {
    if (enabled) {
      return themeData.textTheme.bodyText1!.color!;
    } else
      return Colors.grey;
  }

  Widget _returnRequiredField() {
    if (widget.campoObrigatorio!) {
      return new RichText(
        maxLines: 2,
        text: TextSpan(
          children: <TextSpan>[
            new TextSpan(
              text: "${widget.titulo}",
              style: widget.themeData!.textTheme.bodyText1
                  !.copyWith(color: Color(0xff999999)),
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
              style: widget.themeData!.textTheme.bodyText1!
                  .copyWith(color: Color(0xff999999)),
            )
          ]));
    }
  }
}
