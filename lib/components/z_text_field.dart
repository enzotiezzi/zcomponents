import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:z_components/config/z-mask.dart';
import 'package:z_components/config/z-platform.dart';
import 'package:mask_shifter/mask_shifter.dart';

class ZTextField extends StatelessWidget {
  Widget _zTextField;

  final TextStyle placeholderStyle;
  final TextEditingController controller;
  final FocusNode focusNode;
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final bool autofocus;
  final bool obscureText;
  final bool autocorrect;
  final int maxLines;
  final int minLines;
  final bool expands;
  static const int noMaxLength = -1;
  final int maxLength;
  final bool maxLengthEnforced;
  final ValueChanged<String> onChanged;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onSubmitted;
  var inputFormatters = List<TextInputFormatter>();
  final bool enabled;
  final double cursorWidth;
  final Radius cursorRadius;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final DragStartBehavior dragStartBehavior;
  final GestureTapCallback onTap;
  final InputCounterWidgetBuilder buildCounter;
  final ScrollPhysics scrollPhysics;
  final EdgeInsetsGeometry padding;
  final String placeholder;
  final Widget prefix;
  final OverlayVisibilityMode prefixMode;
  final Widget suffix;
  final OverlayVisibilityMode suffixMode;
  final OverlayVisibilityMode clearButtonMode;
  final BoxDecoration decorationCupertino;
  final ZPlatform zPlatform;
  final ZMask zMask;

  ZTextField(
      {this.keyboardType,
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
      this.placeholderStyle = const TextStyle(fontWeight: FontWeight.w300, color: const Color(0xFFC2C2C2)),
      this.prefix,
      this.prefixMode = OverlayVisibilityMode.always,
      this.suffix,
      this.suffixMode = OverlayVisibilityMode.always,
      this.clearButtonMode = OverlayVisibilityMode.never,
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
      this.zPlatform = ZPlatform.isPlatform,
      this.zMask = ZMask.isPadrao,
      })
      : super(key: key) {
    switch(zMask){
      case ZMask.isPadrao:
    break;
      case ZMask.isTelefone:
        inputFormatters.add(MaskedTextInputFormatterShifter(maskONE: "(XX) XXXXX-XXXX", maskTWO: "(XX) XXXXX-XXXX"));
        inputFormatters.add(BlacklistingTextInputFormatter(RegExp("[,]:")));
        break;
      case ZMask.isCPF:
        inputFormatters.add(MaskedTextInputFormatterShifter(maskONE: "XXX.XXX.XXX-XX", maskTWO: "XXX.XXX.XXX-XX"));
        inputFormatters.add(BlacklistingTextInputFormatter(RegExp("[, ]:")));
        break;
      case ZMask.isData:
        inputFormatters.add(MaskedTextInputFormatterShifter(maskONE: "XX/XX/XXXX", maskTWO: "XX/XX/XXXX"));
        inputFormatters.add(BlacklistingTextInputFormatter(RegExp("[, ]:")));
        break;
      case ZMask.isCNPJ:
        inputFormatters.add(MaskedTextInputFormatterShifter(maskONE: "XX.XXX.XXX/XXXX-XX", maskTWO: "XX.XXX.XXX/XXXX-XX"));
        inputFormatters.add(BlacklistingTextInputFormatter(RegExp("[, ]:")));
        break;
      case ZMask.isCEP:
        inputFormatters.add(MaskedTextInputFormatterShifter(maskONE: "XXXXX-XXX", maskTWO: "XXXXX-XXX"));
        inputFormatters.add(BlacklistingTextInputFormatter(RegExp("[, ]:")));
        break;
    }

    switch (zPlatform) {
      case ZPlatform.isPlatform:
        if (Platform.isAndroid) {
          _zTextField = new TextField(
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
          _zTextField = CupertinoTextField(
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
            padding: const EdgeInsets.all(6.0),
            clearButtonMode: OverlayVisibilityMode.never,
            placeholder: this.placeholder,
            placeholderStyle: this.placeholderStyle,
            prefix: this.prefix,
            prefixMode: OverlayVisibilityMode.always,
            suffix: this.suffix,
            suffixMode: this.suffixMode,
          );
        }
        break;
      case ZPlatform.isAndroid:
        _zTextField = new TextField(
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
        break;
      case ZPlatform.isIOS:
        _zTextField = CupertinoTextField(
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
          padding: const EdgeInsets.all(6.0),
          clearButtonMode: OverlayVisibilityMode.never,
          placeholder: this.placeholder,
          placeholderStyle: this.placeholderStyle,
          prefix: this.prefix,
          prefixMode: OverlayVisibilityMode.always,
          suffix: this.suffix,
          suffixMode: this.suffixMode,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _zTextField;
  }
}
