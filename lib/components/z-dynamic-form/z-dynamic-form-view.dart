import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:z_components/components/z-checkbox/z-checkbox.dart';
import 'package:z_components/components/z-collection-item.dart';
import 'package:z_components/components/z-collection.dart';
import 'package:z_components/components/z-dynamic-form/z-dynamic-form.dart';
import 'package:z_components/components/z-inputs/z-input-celular.dart';
import 'package:z_components/components/z-inputs/z-input-cep.dart';
import 'package:z_components/components/z-inputs/z-input-cnpj.dart';
import 'package:z_components/components/z-inputs/z-input-cpf.dart';
import 'package:z_components/components/z-inputs/z-input-data-de-nascimento.dart';
import 'package:z_components/components/z-inputs/z-input-email.dart';
import 'package:z_components/components/z-inputs/z-input-generic.dart';
import 'package:z_components/components/z-inputs/z-input-name.dart';
import 'package:z_components/components/z-radio-group/z-dynamic-form-type.dart';
import 'package:z_components/components/z-radio-group/z-radio-group.dart';
import 'package:z_components/components/z-radio-group/z-radio-item.dart';
import 'package:z_components/components/z-take-photo.dart';
import 'package:z_components/i-view.dart';
import 'package:z_components/view-model/z-checkbox-viewmodel.dart';
import 'package:z_components/view-model/z-dynamic-form-viewmodel.dart';

class ZDynamicFormView extends IView<ZDyanmicForm> {
  Map json;
  int groupvalue = 0;

  ZDynamicFormView(State<ZDyanmicForm> state) : super(state);

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    return null;
  }

  @override
  Future<void> initView() {
    json = new Map();
  }

  Widget buildDynamicForm() {
    var widgets = state.widget.fields.map<Widget>((x) {
      switch (x.tipo) {
        case ZDynamicFormType.SELECT:
          return _buildSelect(x);
          break;
        case ZDynamicFormType.CPF:
          return _buildCPF(x);
          break;
        case ZDynamicFormType.EMAIL:
          return _buildEmail(x);
          break;
        case ZDynamicFormType.DATE:
          return _buildDate(x);
          break;
        case ZDynamicFormType.NUMBER:
          return _buildNumber(x);
          break;
        case ZDynamicFormType.PASSWORD:
          return _buildPassword(x);
          break;
        case ZDynamicFormType.RADIO:
          return _buildRadio(x);
          break;
        case ZDynamicFormType.CHECKBOX:
          return _buildCheckbox(x);
          break;
        case ZDynamicFormType.CEP:
          return _buildCEP(x);
          break;
        case ZDynamicFormType.TELEPHONE:
          return _buildTelephone(x);
          break;
        case ZDynamicFormType.CNPJ:
          return _buildCNPJ(x);
          break;
        case ZDynamicFormType.NAME:
          return _buildName(x);
          break;
        case ZDynamicFormType.TEXT:
          return _buildText(x);
          break;
      }

      return new Container();
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: new ListView(
        shrinkWrap: true,
        children: widgets,
      ),
    );
  }

  Widget _buildSelect(ZDynamicFormViewModel item) {
    return new ZCollection(
      titulo: item.label,
      lista: item.opcoes
          .split('|')
          .map((x) =>
              new ZCollectionItem(chave: item.nomeCampo, titulo: x, valor: x))
          .toList(),
      onChange: (value) => json[item.nomeCampo] = value,
    );
  }

  Widget _buildCPF(ZDynamicFormViewModel item) {
    TextEditingController textEditingController = new TextEditingController();
    FocusNode focusNode = new FocusNode();
    return new ZInputCPF(
      controllerCpf: textEditingController,
      cpfFocus: focusNode,
      onChange: (value) => json[item.nomeCampo] = value,
    );
  }

  Widget _buildEmail(ZDynamicFormViewModel item) {
    TextEditingController textEditingController = new TextEditingController();
    FocusNode focusNode = new FocusNode();
    return new ZInputEmail(
      emailFocus: focusNode,
      controllerEmail: textEditingController,
      onChange: (value) => json[item.nomeCampo] = value,
    );
  }

  Widget _buildDate(ZDynamicFormViewModel item) {
    TextEditingController textEditingController = new TextEditingController();
    FocusNode focusNode = new FocusNode();
    return new ZInputDataNascimento(
      dataFocus: focusNode,
      controllerData: textEditingController,
      onChange: (value) => json[item.nomeCampo] = value,
    );
  }

  Widget _buildNumber(ZDynamicFormViewModel item) {
    TextEditingController textEditingController = new TextEditingController();
    FocusNode focusNode = new FocusNode();
    return new ZInputGeneric(
      titulo: item.label,
      inputPadraoFocus: focusNode,
      controllerInputPadrao: textEditingController,
      onChange: (value) => json[item.nomeCampo] = value,
      tipoTeclado: TextInputType.number,
    );
  }

  Widget _buildPassword(ZDynamicFormViewModel item) {
    TextEditingController textEditingController = new TextEditingController();
    FocusNode focusNode = new FocusNode();
    return new ZInputGeneric(
      titulo: item.label,
      inputPadraoFocus: focusNode,
      controllerInputPadrao: textEditingController,
      onChange: (value) => json[item.nomeCampo] = value,
      tipoTeclado: TextInputType.visiblePassword,
      obscureText: true,
    );
  }

  Widget _buildRadio(ZDynamicFormViewModel item) {
    return new ZRadioGroup(
      title: item.label,
      itens: item.opcoes
          .split('|')
          .map((x) => new ZRadioItem(
                description: x,
                value: x,
              ))
          .toList(),
      groupValue: groupvalue++,
      onChange: (value) => json[item.nomeCampo] = value,
    );
  }

  Widget _buildCheckbox(ZDynamicFormViewModel item) {
    return new ZCheckBox(
      listaDescricao: item.opcoes
          .split('|')
          .map((x) => new ZCheckBoxViewModel(
                descricao: x,
                value: x,
              ))
          .toList(),
      title: item.label,
      onChange: (value) => json[item.nomeCampo] = value,
    );
  }

  Widget _buildCEP(ZDynamicFormViewModel item) {
    TextEditingController textEditingController = new TextEditingController();
    FocusNode focusNode = new FocusNode();
    return new ZInputCEP(
      cepFocus: focusNode,
      controllerCep: textEditingController,
      onChange: (value) => json[item.nomeCampo] = value,
    );
  }

  Widget _buildTelephone(ZDynamicFormViewModel item) {
    TextEditingController textEditingController = new TextEditingController();
    FocusNode focusNode = new FocusNode();
    return new ZInputCelular(
      celularFocus: focusNode,
      controllerCelular: textEditingController,
      onChange: (value) => json[item.nomeCampo] = value,
    );
  }

  Widget _buildCNPJ(ZDynamicFormViewModel item) {
    TextEditingController textEditingController = new TextEditingController();
    FocusNode focusNode = new FocusNode();
    return new ZInputCNPJ(
      cnpjFocus: focusNode,
      controllerCNPJ: textEditingController,
      onChange: (value) => json[item.nomeCampo] = value,
    );
  }

  Widget _buildName(ZDynamicFormViewModel item) {
    TextEditingController textEditingController = new TextEditingController();
    FocusNode focusNode = new FocusNode();
    return new ZInputName(
      nomeFocus: focusNode,
      controllerNome: textEditingController,
      onChange: (value) => json[item.nomeCampo] = value,
    );
  }

  Widget _buildText(ZDynamicFormViewModel item){
    TextEditingController textEditingController = new TextEditingController();
    FocusNode focusNode = new FocusNode();
    return new ZInputGeneric(
      titulo: item.label,
      inputPadraoFocus: focusNode,
      controllerInputPadrao: textEditingController,
      onChange: (value) => json[item.nomeCampo] = value,
      tipoTeclado: TextInputType.visiblePassword,
      obscureText: false,
    );
  }
}
