import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_shifter/mask_shifter.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/config/z-dialog.dart';

class ZHoraUmCampo extends StatefulWidget {
  _ZHoraUmCampoState state;
  String titulo;

  ZHoraUmCampo({Key key,
  @required this.titulo

  }) : super(key: key);

  @override
  _ZHoraUmCampoState createState() {
    state = new _ZHoraUmCampoState();

    return state;
  }
}

class _ZHoraUmCampoState extends State<ZHoraUmCampo> {
  bool dMaisUm = false;

  bool _visibles = false;

  FocusNode _focusEntrada;
  FocusNode _focusSaida;
  FocusNode _focusIntervalo;

  String _horaEntrada;
  String _minutoEntrada;
  int _intHoraEntrada = 0;
  int _intMinutoEntrada;



  @override
  void initState() {
    super.initState();
    _focusEntrada = FocusNode();
    _focusSaida = FocusNode();
    _focusIntervalo = FocusNode();
    _focusSaida.addListener(() {

    });
  }

  void dismiss() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                child: new Text(widget.titulo),
              ),
            ],
          ),
        ),
        new Container(
          margin: const EdgeInsets.only(bottom: 5),
          padding: EdgeInsets.only(top: 5, bottom: 5),
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(
                const Radius.circular(5.0)),
          ),
          child: new Container(
            width: 100,
              child: new TextField(textAlign: TextAlign.center,
                onSubmitted: (term) {
                  _fieldFocusChange(
                      context, _focusEntrada, _focusSaida);
                },
                inputFormatters: [
                  MaskedTextInputFormatterShifter(
                      maskONE: "XX:XX", maskTWO: "XX:XX"),
                  BlacklistingTextInputFormatter(
                      RegExp("[/\\\\,.-]")),
                ],
                focusNode: _focusEntrada,
                keyboardType: TextInputType.number,
                //controller: _binding.controllerHorarioInicio,
                decoration:
                InputDecoration.collapsed(hintText: ""),
                onChanged: (text) {
                  _horaEntrada = text.substring(0, 2);
                  _minutoEntrada = text.substring(3, 5);
                  _intHoraEntrada = int.parse(_horaEntrada);
                  _intMinutoEntrada = int.parse(_minutoEntrada);
                  if (text.length == 5) {
                    if (_intHoraEntrada > 23 &&
                        _intMinutoEntrada > 59) {
                      showAlertDialogNew("Horario Inválido!",
                          "Por favor insira um valor de hora entre 00 e 23 e um minuto de 00 a 59.");
                    } else if (_intHoraEntrada > 23 &&
                        _intMinutoEntrada < 59) {
                      showAlertDialogNew("Hora Inválida!",
                          "Por favor insira um valor de hora entre 00 e 23.");
                    } else if (_intHoraEntrada < 24 &&
                        _intMinutoEntrada > 59) {
                      showAlertDialogNew("Minuto Inválido!",
                          "Por favor insira um valor de minuto entre 00 e 59.");
                    } else {
                      _fieldFocusChange(
                          context, _focusEntrada, _focusSaida);
                    }
                  }
                },
              )),
        ),
      ],
    );
  }

  void showAlertDialogNew(String title, String message) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => ZAlertDialog(
          zDialog: ZDialog.erro,
          child: new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    margin: const EdgeInsets.all(8),
                    child: new Text(
                      title,
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  )
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    margin: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 16),
                    child: new Text(
                      message,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          color: const Color(0xff707070), fontSize: 13),
                    ),
                  )
                ],
              ),
              new Divider(
                color: const Color(0xffdbdbdb),
              ),
              new Container(
                child: new InkWell(
                  borderRadius:
                  new BorderRadius.all(const Radius.circular(20.0)),
                  splashColor: const Color(0xffe6e6e6),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: new Container(
                    padding: const EdgeInsets.all(12),
                    child: new Text(
                      "ENTENDI",
                      style: new TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                margin: const EdgeInsets.only(bottom: 8),
              )
            ],
          ),
        ));
  }


  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
