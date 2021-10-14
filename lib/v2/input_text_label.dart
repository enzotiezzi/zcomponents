import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/v2/i_ui_state.dart';
import 'package:z_components/v2/z_icon.dart';
import 'package:z_components/v2/z_theme.dart';

class InputTextLabel extends StatefulWidget {
  final Key key;
  final TextEditingController textEditingController;

  final String label;
  final ZIcon leadingIcon;
  final ZIcon trailingIcon;
  final Widget prefix;
  final Widget sufix;
  final String assist;
  final FormFieldValidator<String> validator;
  final int maxLength;
  final bool showMaxLength;
  final TextInputType textInputType;
  final String placeHolder;

  InputTextLabel(
      {@required this.textEditingController,
      @required this.label,
      this.leadingIcon,
      this.trailingIcon,
      this.prefix,
      this.sufix,
      this.assist,
      this.key,
      this.validator,
      this.maxLength: 16,
      this.showMaxLength: false,
      this.placeHolder,
      this.textInputType: TextInputType.text})
      : assert(textEditingController != null, label != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _InputTextLabel();
}

class _InputTextLabel extends State<InputTextLabel>
    with UIFormState<InputTextLabel> {
  String _assistText = "";

  @override
  void initState() {
    _assistText = widget.assist ?? "";

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
                    child: widget.prefix,
                    flex: 8,
                  ),
                  Expanded(
                    child: Focus(
                      child: TextFormField(
                        controller: widget.textEditingController,
                        maxLength: widget.maxLength,
                        keyboardType: widget.textInputType,
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
                          if (widget.showMaxLength) setState(() {});

                          if (widget.validator != null) {
                            var errorText = widget
                                .validator(widget.textEditingController.text);

                            if (errorText == null) {
                              setUIState(ZUIState.FOCUS);

                              setState(() {
                                _assistText = widget.assist;
                              });
                            }
                          }
                        },
                      ),
                      onFocusChange: (hasFocus) {
                        if (hasFocus && currentUIState != ZUIState.ERROR)
                          setUIState(ZUIState.FOCUS);
                        else {
                          if (widget.validator != null) {
                            var errorText = widget
                                .validator(widget.textEditingController.text);

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
                    child: widget.sufix,
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
    return widget.showMaxLength
        ? "${widget.textEditingController.text.length}/${widget.maxLength}"
        : "";
  }
}
