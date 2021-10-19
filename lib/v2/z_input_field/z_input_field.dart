import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/v2/i_ui_state.dart';
import 'package:z_components/v2/z_icon.dart';
import 'package:z_components/v2/z_text.dart';
import 'package:z_components/v2/z_theme.dart';

class ZInputField extends StatefulWidget {
  final Key key;

  // BASE
  final String label;
  final TextEditingController textEditingController;
  final String placeHolder;
  final bool mandatory;

  // OPTIONAL
  final bool clearable;
  final String supportingText;
  final bool characterCounter;
  final ZIcon leadingIcon;
  final ZIcon trailingIcon;
  final ZText preffix;
  final ZText suffix;
  final bool multiLine;

  // OTHER
  final int minLength;
  final int maxLength;
  final double minNumber;
  final double maxNumber;
  final String minDate;
  final String maxDate;
  final String mask;
  final FormFieldValidator<String> validations;

  final TextInputType textInputType;
  final bool password;

  const ZInputField({
    this.key,

    @required this.label,
    @required this.textEditingController,
    @required this.placeHolder,
    this.mandatory: false,

    this.clearable,
    this.supportingText,
    this.characterCounter: false,
    this.leadingIcon,
    this.trailingIcon,
    this.preffix,
    this.suffix,
    this.multiLine: false,

    this.minLength: 1,
    this.maxLength: 16,
    this.minNumber,
    this.maxNumber,
    this.minDate,
    this.maxDate,
    this.mask,
    this.validations,

    this.textInputType: TextInputType.text,
    this.password: false
  })  : assert(textEditingController != null, label != null),
        assert(placeHolder != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _InputTextLabel();
}

class _InputTextLabel extends State<ZInputField>
    with UIFormState<ZInputField> {
  String _assistText = "";

  @override
  void initState() {
    _assistText = widget.supportingText ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(2.0),
              child: new Row(
                children: [
                  Expanded(
                      child: new Text(
                    widget.label,
                    style: TextStyle(color: currentColor),
                    textAlign: TextAlign.start,
                  ))
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: currentColor),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Row(
                children: [
                  Expanded(
                    child: widget.leadingIcon,
                    flex: 8,
                  ),
                  Expanded(
                    child: widget.preffix,
                    flex: 8,
                  ),
                  Expanded(
                    child: Focus(
                      child: TextFormField(
                        controller: widget.textEditingController,
                        maxLength: widget.maxLength,
                        keyboardType: widget.textInputType,
                        obscureText: widget.password,
                        decoration: InputDecoration(
                            hintText: widget.placeHolder,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            counterText: ""),
                        onChanged: (value) {
                          // APENAS PARA ATUALIZAR NÚMERO DE CARACTERES
                          if (widget.characterCounter) setState(() {});

                          if (widget.validations != null) {
                            var errorText = widget
                                .validations(widget.textEditingController.text);

                            if (errorText == null) {
                              setUIState(ZUIState.FOCUSED);

                              setState(() {
                                _assistText = widget.supportingText;
                              });
                            }
                          }
                        },
                      ),
                      onFocusChange: (hasFocus) {
                        if (hasFocus && currentUIState != ZUIState.ERROR)
                          setUIState(ZUIState.FOCUSED);
                        else {
                          if (widget.validations != null) {
                            var errorText = widget
                                .validations(widget.textEditingController.text);

                            if (errorText != null) {
                              setUIState(ZUIState.ERROR);

                              setState(() {
                                _assistText = errorText;
                              });
                            }
                          } else {
                            setUIState(ZUIState.ACTIVE);
                          }
                        }
                      },
                    ),
                    flex: 68,
                  ),
                  Expanded(
                    child: widget.suffix,
                    flex: 8,
                  ),
                  Expanded(
                    child: widget.trailingIcon,
                    flex: 8,
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Expanded(
                      flex: 90,
                      child: new Text(
                        _assistText,
                        style: TextStyle(color: currentColor),
                      )),
                  Expanded(
                      flex: 10,
                      child: Text(
                        _buildMaxLengthString(),
                        style: TextStyle(color: currentColor),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  String _buildMaxLengthString() {
    return widget.characterCounter
        ? "${widget.textEditingController.text.length}/${widget.maxLength}"
        : "";
  }
}
