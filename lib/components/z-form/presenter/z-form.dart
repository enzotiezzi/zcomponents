import 'package:flutter/material.dart';
import 'package:z_components/components/z-form/view/z-form-view.dart';
import 'package:z_components/components/z-form/view/z-form-viewmodel.dart';
import 'package:z_components/components/z-inputs/z-input-generic.dart';

class ZForm extends StatefulWidget {
  List<ZFormViewModel>? viewmodel;
  final Function(List<ZFormViewModel>)? onChange;

  ZForm({this.viewmodel, this.onChange});

  @override
  _ZFormState createState() => _ZFormState();
}

class _ZFormState extends State<ZForm> {
  late ZFormView _view;

  @override
  void initState() {
    _view = ZFormView(this);
    _view.initView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _scanDocumentos();
  }

  Widget _scanDocumentos() {
    return new Column(
      children: _montarListaDinamicaDocumentos(),
    );
  }

  List<Widget> _montarListaDinamicaDocumentos() {
    List<Widget> lista = [];
    for (int i = 0; i < widget.viewmodel!.length; i++) {
      var item = widget.viewmodel![i];
      if (item.tipoValorCampo == "date") {
        lista.add(new Column(
          children: [
            new Container(
              child: new ZInputGeneric(
                campoObrigatorio: item.obrigatorio,
                enabled: item.enabled,
                themeData: Theme.of(context),
                titulo: item.nomeCampo,
                tipoTeclado: TextInputType.number,
                maxLength: item.maxLength,
                comMascara: true,
                textMask: "##/##/####",
                hintText: "DD / MM / AAAA",
                controllerInputPadrao: item.controller,
                onChange: (text) {
                  if (text.length == 10) {
                    var textoSeparado = text.split("/");
                    item.resposta =
                        "${textoSeparado[2]}-${textoSeparado[1]}-${textoSeparado[0]}";
                    widget.onChange!(widget.viewmodel!);
                  }
                }, inputPadraoFocus: new FocusNode(),
              ),
            ),
            new Divider(
              height: 1,
            )
          ],
        ));
      } else if (item.tipoValorCampo == "number") {
        lista.add(new Column(
          children: [
            new Container(
              child: new ZInputGeneric(
                campoObrigatorio: item.obrigatorio,
                enabled: item.enabled,
                themeData: Theme.of(context),
                titulo: item.nomeCampo,
                tipoTeclado: TextInputType.number,
                maxLength: item.maxLength,
                controllerInputPadrao: item.controller,
                onChange: (text) {
                  item.resposta = text.trim();
                  widget.onChange!(widget.viewmodel!);
                }, inputPadraoFocus: new FocusNode(),
              ),
            ),
            new Divider(
              height: 1,
            )
          ],
        ));
      } else if (item.tipoValorCampo == "celular") {
        lista.add(new Column(
          children: [
            new Container(
              child: new ZInputGeneric(
                campoObrigatorio: item.obrigatorio,
                enabled: item.enabled,
                titulo: item.nomeCampo,
                themeData: Theme.of(context),
                comMascara: true,
                tipoTeclado: TextInputType.phone,
                textMask: "(##) #####-####",
                maxLength: item.maxLength,
                hintText: "( ** ) 9 **** - ****",
                controllerInputPadrao: item.controller,
                onChange: (text) {
                  if (text.length == 15) {
                    item.resposta = text.trim();
                    widget.onChange!(widget.viewmodel!);
                    item.controller!.text = item.resposta!;
                  }
                }, inputPadraoFocus: new FocusNode(),
              ),
            ),
            new Divider(
              height: 1,
            )
          ],
        ));
      } else if (item.tipoValorCampo == "cpf") {
        lista.add(new Column(
          children: [
            new Container(
              child: new ZInputGeneric(
                campoObrigatorio: item.obrigatorio,
                enabled: item.enabled,
                themeData: Theme.of(context),
                tipoTeclado: TextInputType.number,
                titulo: item.nomeCampo,
                maxLength: item.maxLength,
                comMascara: true,
                textMask: "###.###.###-##",
                hintText: "000.000.000-00",
                controllerInputPadrao: item.controller,
                onChange: (text) {
                  item.resposta = text.trim();
                  widget.onChange!(widget.viewmodel!);
                }, inputPadraoFocus: new FocusNode(),
              ),
            ),
            new Divider(
              height: 1,
            )
          ],
        ));
      } else if (item.tipoValorCampo == "text") {
        lista.add(new Column(
          children: [
            new Container(
              child: new ZInputGeneric(
                campoObrigatorio: item.obrigatorio,
                enabled: item.enabled,
                titulo: item.nomeCampo,
                themeData: Theme.of(context),
                maxLength: item.maxLength,
                controllerInputPadrao: item.controller,
                onChange: (text) {
                  item.resposta = text.trim();
                  widget.onChange!(widget.viewmodel!);
                }, inputPadraoFocus: new FocusNode(),
              ),
            ),
            new Divider(
              height: 1,
            )
          ],
        ));
      } else if (item.tipoValorCampo == "textarea") {
        lista.add(new Column(
          children: [
            new Container(
              child: new ZInputGeneric(
                campoObrigatorio: item.obrigatorio,
                enabled: item.enabled,
                titulo: item.nomeCampo,
                tipoTeclado: TextInputType.text,
                themeData: Theme.of(context),
                maxLength: item.maxLength,
                controllerInputPadrao: item.controller,
                onChange: (text) {
                  item.resposta = text.trim();
                  widget.onChange!(widget.viewmodel!);
                }, inputPadraoFocus: new FocusNode(),
              ),
            ),
            new Divider(
              height: 1,
            )
          ],
        ));
      } else {
        lista.add(new Column(
          children: [
            new Container(
              child: new ZInputGeneric(
                campoObrigatorio: item.obrigatorio,
                enabled: item.enabled,
                themeData: Theme.of(context),
                titulo: item.nomeCampo,
                maxLength: item.maxLength,
                controllerInputPadrao: item.controller,
                onChange: (text) {
                  item.resposta = text.trim();
                  widget.onChange!(widget.viewmodel!);
                },
                inputPadraoFocus: new FocusNode(),
              ),
            ),
            new Divider(
              height: 1,
            )
          ],
        ));
      }
    }
    return lista;
  }
}
