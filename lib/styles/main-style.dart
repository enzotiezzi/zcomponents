import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:z_components/styles/media-query.dart';

class MainStyle {
  static const Color APP_THEME = const Color(0xFF2BBAB4);

  static _MainStyle get(BuildContext context) => _MainStyle(context: context);

  static Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static Widget styleTextInput(
      BuildContext? context,
      String? title,
      TextInputType? typeKeyboard,
      Function? onTap,
      FocusNode? currentFocus,
      TextEditingController? controller,
      FocusNode? nextFocus,
      Function(String)? onChange,
      bool? mask,
      {String? textMask,
      String? hintText,
      bool? enabled,
      ThemeData? themeData,
      bool? campoObrigatorio}) {
    if (enabled == null) {
      enabled = true;
    }
    return new Container(
      color: Colors.white,
      child: GestureDetector(
        onTap: onTap != null ? onTap() : (){},
        child: new Column(
          children: <Widget>[
            new Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                new Expanded(
                  flex: 4,
                  child: new Container(
                      padding: const EdgeInsets.only(
                          top: 12.0, bottom: 12.0, left: 16.0),
                      child: returnRequiredField(
                          title, themeData, campoObrigatorio)),
                ),
                new Expanded(
                  flex: 7,
                  child: new Container(
                    margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                    child: (mask == true)
                        ? new TextField(
                            enabled: enabled,
                            keyboardAppearance: Brightness.light,
                            keyboardType: typeKeyboard,
                            textCapitalization: TextCapitalization.words,
                            focusNode: currentFocus,
                            controller: controller,
                            cursorColor: themeData!.primaryColor,
                            style: themeData.textTheme.bodyText1
                                ?.copyWith(color: corTexto(themeData, enabled)),
                            inputFormatters: [
                              new MaskTextInputFormatter(mask: textMask)
                            ],
                            onSubmitted: (text) {
                              currentFocus?.unfocus();
                              if (nextFocus != null) {
                                FocusScope.of(context!).requestFocus(nextFocus);
                              }
                            },
                            decoration: InputDecoration(
                              hintText: hintText,
                              hintStyle: themeData.textTheme.bodyText1
                                  ?.copyWith(color: Color(0xFFC7C7C7)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFf0f0f0)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: themeData.primaryColor),
                              ),
                            ),
                            onChanged: onChange,
                          )
                        : new TextField(
                            enabled: enabled,
                            keyboardAppearance: Brightness.light,
                            keyboardType: typeKeyboard,
                            textCapitalization: TextCapitalization.words,
                            focusNode: currentFocus,
                            controller: controller,
                            cursorColor: themeData!.primaryColor,
                            style: themeData.textTheme.bodyText1
                                ?.copyWith(color: corTexto(themeData, enabled)),
                            onSubmitted: (text) {
                              currentFocus?.unfocus();
                              if (nextFocus != null) {
                                FocusScope.of(context!).requestFocus(nextFocus);
                              }
                            },
                            decoration: InputDecoration(
                              hintText: hintText,
                              hintStyle: themeData.textTheme.bodyText1
                                  ?.copyWith(color: Color(0xFFC7C7C7)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFf0f0f0)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: themeData.primaryColor),
                              ),
                            ),
                            onChanged: onChange,
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

Color? corTexto(ThemeData themeData, bool enabled) {
  if (enabled) {
    return themeData.textTheme.bodyText1!.color;
  } else
    return Colors.grey;
}

Widget returnRequiredField(
    String? title, ThemeData? themeData, bool? campoObrigatorio) {
  if (campoObrigatorio != null && campoObrigatorio) {
    return new RichText(
      maxLines: 2,
      text: TextSpan(
        children: <TextSpan>[
          new TextSpan(
            text: title,
            style: themeData?.textTheme.bodyText1
                ?.copyWith(color: Color(0xff999999)),
          ),
          TextSpan(text: "*", style: TextStyle(color: Colors.redAccent))
        ],
      ),
    );
  } else {
    return new Text(title!,
        style:
            themeData?.textTheme.bodyText1?.copyWith(color: Color(0XFF999999)));
  }
}

class _MainStyle {
  BuildContext context;

  Color _primaryColor = new Color(0xff2bbab4);
  Color _secondaryColor = new Color(0xff801f92);

  _MainStyle({required this.context});

  Color get primaryColor => _primaryColor;

  set primaryColor(Color primaryColor) => _primaryColor = primaryColor;

  Color get secondaryColor => _secondaryColor;

  set secondaryColor(Color secondaryColor) => _secondaryColor = secondaryColor;

  Scaffold getDefaultScaffold(String title, Widget body) => new Scaffold(
      backgroundColor: _defaultScaffoldColor,
      appBar: _getDefaultCupertinoNavigationBar("$title"),
      body: body);

  Color get _defaultScaffoldColor => const Color(0xffEFEFF4);

  CupertinoNavigationBar _getDefaultCupertinoNavigationBar(String text) =>
      CupertinoNavigationBar(
        leading: new GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: new Container(
            padding: EdgeInsets.only(right: 20.0),
            color: Colors.transparent,
            child: new Icon(
              Icons.arrow_back_ios,
              size: 20.0,
              color: primaryColor,
            ),
          ),
        ),
        middle: new Text("$text"),
      );

  TextStyle get mainStyleTextBaseLine {
    return new TextStyle(
        color: Color(0xFF999999),
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.1);
  }

  TextStyle get mainStyleTextBaseLineHint {
    return new TextStyle(
        color: Color(0xffc7c7c7),
        letterSpacing: -0.24,
        fontWeight: FontWeight.w400,
        fontSize: MediaQuerySize.get(context).fontSize);
  }

  TextStyle get mainStyleTextBaseLineInput {
    return new TextStyle(
        color: Colors.black,
        letterSpacing: -0.24,
        fontWeight: FontWeight.w400,
        fontSize: MediaQuerySize.get(context).fontSize);
  }

  TextStyle get mainStyleText {
    return new TextStyle(
        color: MediaQuerySize.get(context).color,
        letterSpacing: -0.24,
        fontWeight: FontWeight.w400,
        fontSize: MediaQuerySize.get(context).fontSize);
  }

  TextStyle get mainStyleTextTitle {
    return new TextStyle(
        color: MediaQuerySize.get(context).color,
        letterSpacing: -0.24,
        fontWeight: FontWeight.w500,
        fontSize: MediaQuerySize.get(context).fontSize);
  }

  TextStyle get mainStyleTextWhite {
    return new TextStyle(
        color: Colors.white,
        letterSpacing: -0.24,
        fontWeight: FontWeight.w400,
        fontSize: MediaQuerySize.get(context).fontSize);
  }

  TextStyle get styleTextWhiteUnderline {
    return new TextStyle(
        color: Colors.white,
        letterSpacing: -0.24,
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.w400,
        fontSize: MediaQuerySize.get(context).fontSize);
  }

  TextStyle get titleStyleText {
    return new TextStyle(
        color: MediaQuerySize.get(context).color,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.24,
        fontSize: MediaQuerySize.get(context).tittleFontSize);
  }

  TextStyle get styleButtonText {
    return new TextStyle(
        color: MediaQuerySize.get(context).color,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.07,
        fontSize: MediaQuerySize.get(context).fontSizeButton);
  }

  TextStyle get styleButtonTextWhite {
    return new TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.07,
        fontSize: MediaQuerySize.get(context).fontSizeButton);
  }

  TextStyle get styleInputText {
    return new TextStyle(
        color: MediaQuerySize.get(context).color,
        fontWeight: FontWeight.w400,
        fontSize: MediaQuerySize.get(context).tittleFontSize);
  }

  TextStyle get styleHintTextGrey {
    return new TextStyle(
        color: Color(0xffC7C7CC),
        fontSize: MediaQuerySize.get(context).fontSizeButton);
  }

  TextStyle get styleTittleDialog {
    return new TextStyle(
        color: MediaQuerySize.get(context).color,
        fontWeight: FontWeight.w700,
        fontSize: MediaQuerySize.get(context).styleTittleDialogSize);
  }

  double get marginRightLeft {
    return 16.0;
  }

  Color get color {
    return Color(0xff999999);
  }

  Color get backgroundColor {
    return Color(0xffff0f0f0);
  }

  double get fontSizePadrao {
    return MediaQuerySize.get(context).fontSize;
  }

  double get fontSizeEntradaSaida {
    return MediaQuerySize.get(context).fontSize;
  }

  double get iconSizePadrao {
    return MediaQuerySize.get(context).iconSizePadrao;
  }

  double get sizePin {
    return MediaQuerySize.get(context).sizePin;
  }

  double get fontSizeTermos {
    return MediaQuerySize.get(context).fontSizeTermos;
  }

  double get fontSizeLeadinCancelar {
    return MediaQuerySize.get(context).fontSizeLeadinCancelar;
  }

  double get subTitleFontSize {
    return 12.0;
  }
}
