import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/v2/i_ui_state.dart';
import 'package:z_components/v2/z_theme.dart';

class InputTextLabel extends StatefulWidget {
  final Key key;
  final TextEditingController textEditingController;

  final String label;
  final Widget leading;
  final Widget trailing;
  final Widget prefix;
  final Widget sufix;
  final String assist;
  final FormFieldValidator<String> validator;

  InputTextLabel(
      {@required this.textEditingController,
      @required this.label,
      this.leading,
      this.trailing,
      this.prefix,
      this.sufix,
      this.assist,
      this.key,
      this.validator})
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
                    child: widget.leading,
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
                        decoration: InputDecoration(
                          hintText: "Input Text",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        onChanged: (value) {
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
                    flex: 86,
                  ),
                  Expanded(
                    child: widget.sufix,
                    flex: 8,
                  ),
                  Expanded(
                    child: widget.trailing,
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
                        "0/20",
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
}
