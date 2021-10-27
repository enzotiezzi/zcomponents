import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/v2/z_icon.dart';
import 'package:z_components/v2/z_input_field/z_input_field.dart';
import 'package:z_components/v2/z_text.dart';

class ZInpuFieldPassword extends ZInputField {
  final Key key;

  // BASE
  final String label;
  final TextEditingController textEditingController;
  final String placeHolder;
  final bool mandatory;

  // OPTIONAL
  final bool clearable;
  final String supportingText;

  // OTHER
  final FormFieldValidator<String> validations;

  ZInpuFieldPassword({
    this.key,

    @required this.label,
    @required this.textEditingController,
    @required this.placeHolder,
    this.mandatory: false,

    this.clearable,
    this.supportingText,
    this.validations,
  })  : assert(textEditingController != null),
        assert(label != null),
        assert(placeHolder != null),
        super(
          key: key,

          label: label,
          textEditingController: textEditingController,
          placeHolder: placeHolder,
          mandatory: mandatory,

          clearable: clearable,
          supportingText: supportingText,
          leadingIcon: ZIcon(Icons.lock),
          trailingIcon: ZIcon(Icons.visibility),

          validations: validations,

          textInputType: TextInputType.text,
          password: true);
}
