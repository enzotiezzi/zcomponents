import 'package:flutter/cupertino.dart';
import 'package:z_components/v2/z_icon.dart';
import 'package:z_components/v2/z_input_field/z_input_field.dart';
import 'package:z_components/v2/z_text.dart';

class ZInpuFieldNumber extends ZInputField {
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
  final double minNumber;
  final double maxNumber;
  final String mask;
  final FormFieldValidator<String> validations;

  const ZInpuFieldNumber({
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

    this.minNumber,
    this.maxNumber,
    this.mask,
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
          characterCounter: characterCounter,
          leadingIcon: leadingIcon,
          trailingIcon: trailingIcon,
          preffix: preffix,
          suffix: suffix,
          multiLine: multiLine,

          minNumber: minNumber,
          maxNumber: maxNumber,
          mask: mask,
          validations: validations,
          textInputType: TextInputType.number);
}
