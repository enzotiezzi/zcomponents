import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ZTextField extends StatelessWidget {
  Widget zTextField;

  TextStyle placeholderStyle;

  TextEditingController controller;

  FocusNode focusNode;

  InputDecoration decoration;

  TextInputType keyboardType;

  TextInputAction textInputAction;

  TextCapitalization textCapitalization;

  TextStyle style;

  StrutStyle strutStyle;

  TextAlign textAlign;

  TextDirection textDirection;

  bool autofocus;

  bool obscureText;

  bool autocorrect;

  int maxLines;

  int minLines;

  bool expands;

  static const int noMaxLength = -1;

  int maxLength;

  bool maxLengthEnforced;

  ValueChanged<String> onChanged;

  VoidCallback onEditingComplete;

  ValueChanged<String> onSubmitted;

  List<TextInputFormatter> inputFormatters;

  bool enabled;

  double cursorWidth;

  Radius cursorRadius;

  Color cursorColor;

  Brightness keyboardAppearance;

  EdgeInsets scrollPadding;

  bool enableInteractiveSelection;

  DragStartBehavior dragStartBehavior;

  bool get selectionEnabled {
    return enableInteractiveSelection ?? !obscureText;
  }

  GestureTapCallback onTap;

  InputCounterWidgetBuilder buildCounter;

  ScrollPhysics scrollPhysics;

  EdgeInsetsGeometry padding;

  String placeholder;

  Widget prefix;

  OverlayVisibilityMode prefixMode;

  Widget suffix;

  OverlayVisibilityMode suffixMode;

  OverlayVisibilityMode clearButtonMode;

  final BoxDecoration decorationCupertino;

  ZTextField({
    this.decorationCupertino = const BoxDecoration(
      border: Border(
          top: BorderSide(
            color: CupertinoColors.lightBackgroundGray,
            style: BorderStyle.solid,
            width: 0.0,
          ),
          bottom: BorderSide(
            color: CupertinoColors.lightBackgroundGray,
            style: BorderStyle.solid,
            width: 0.0,
          ),
          left: BorderSide(
            color: CupertinoColors.lightBackgroundGray,
            style: BorderStyle.solid,
            width: 0.0,
          ),
          right: BorderSide(
            color: CupertinoColors.lightBackgroundGray,
            style: BorderStyle.solid,
            width: 0.0,
          )),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    Key key,
    this.controller,
    this.focusNode,
    this.decoration,
    this.padding = const EdgeInsets.all(6.0),
    this.placeholder,
    this.placeholderStyle = const TextStyle(
        fontWeight: FontWeight.w300, color: const Color(0xFFC2C2C2)),
    this.prefix,
    this.prefixMode = OverlayVisibilityMode.always,
    this.suffix,
    this.suffixMode = OverlayVisibilityMode.always,
    this.clearButtonMode = OverlayVisibilityMode.never,
    TextInputType keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforced = true,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorRadius = const Radius.circular(2.0),
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    this.scrollPhysics,
    this.textDirection,
    this.enableInteractiveSelection,
    this.onTap,
    this.buildCounter,
  })  : assert(textAlign != null),
        assert(autofocus != null),
        assert(obscureText != null),
        assert(autocorrect != null),
        assert(maxLengthEnforced != null),
        assert(scrollPadding != null),
        assert(dragStartBehavior != null),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          'minLines can\'t be greater than maxLines',
        ),
        assert(expands != null),
        assert(
          !expands || (maxLines == null && minLines == null),
          'minLines and maxLines must be null when expands is true.',
        ),
        assert(maxLength == null ||
            maxLength == TextField.noMaxLength ||
            maxLength > 0),
        keyboardType = keyboardType ??
            (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        super(key: key) {
    if (Platform.isAndroid) {
      zTextField = new TextField(
        onChanged: this.onChanged,
        style: this.style,
        decoration: this.decoration,
        enabled: this.enabled,
        onTap: this.onTap,
        controller: this.controller,
        keyboardType: this.keyboardType,
        onSubmitted: this.onSubmitted,
        focusNode: this.focusNode,
        inputFormatters: this.inputFormatters,
        maxLength: this.maxLength,
        obscureText: this.obscureText,
        textAlign: this.textAlign,
        autocorrect: this.autocorrect,
        autofocus: this.autofocus,
        buildCounter: this.buildCounter,
        cursorColor: this.cursorColor,
        cursorRadius: this.cursorRadius,
        cursorWidth: this.cursorWidth,
        dragStartBehavior: this.dragStartBehavior,
        enableInteractiveSelection: this.enableInteractiveSelection,
        expands: this.expands,
        key: this.key,
        keyboardAppearance: this.keyboardAppearance,
        maxLengthEnforced: this.maxLengthEnforced,
        maxLines: this.maxLines,
        minLines: this.minLines,
        onEditingComplete: this.onEditingComplete,
        scrollPadding: this.scrollPadding,
        scrollPhysics: this.scrollPhysics,
        strutStyle: this.strutStyle,
        textCapitalization: this.textCapitalization,
        textDirection: this.textDirection,
        textInputAction: this.textInputAction,
      );
    } else {
      CupertinoTextField(
        onChanged: this.onChanged,
        style: this.style,
        enabled: this.enabled,
        controller: this.controller,
        keyboardType: this.keyboardType,
        onSubmitted: this.onSubmitted,
        focusNode: this.focusNode,
        inputFormatters: this.inputFormatters,
        maxLength: this.maxLength,
        obscureText: this.obscureText,
        textAlign: TextAlign.start,
        autocorrect: this.autocorrect,
        autofocus: this.autofocus,
        cursorColor: this.cursorColor,
        cursorRadius: this.cursorRadius,
        cursorWidth: this.cursorWidth,
        dragStartBehavior: this.dragStartBehavior,
        expands: this.expands,
        key: this.key,
        keyboardAppearance: this.keyboardAppearance,
        maxLengthEnforced: this.maxLengthEnforced,
        maxLines: this.maxLines,
        minLines: this.minLines,
        onEditingComplete: this.onEditingComplete,
        scrollPadding: this.scrollPadding,
        scrollPhysics: this.scrollPhysics,
        strutStyle: this.strutStyle,
        textCapitalization: TextCapitalization.none,
        textInputAction: this.textInputAction,
        decoration: this.decorationCupertino,
        padding:  const EdgeInsets.all(6.0),
        clearButtonMode: OverlayVisibilityMode.never,
        placeholder: this.placeholder,
        placeholderStyle: this.placeholderStyle,
        prefix: this.prefix,
        prefixMode: OverlayVisibilityMode.always,
        suffix: this.suffix,
        suffixMode: this.suffixMode,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return zTextField;
  }
}
