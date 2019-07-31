import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_shifter/mask_shifter.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/config/z-dialog.dart';

class ZHora extends StatefulWidget {
  final TextEditingController controllerHoraEntrada;
  final TextEditingController controllerHoraSaida;
  final TextEditingController controllerIntervalo;

  ZHora({Key key,this.controllerHoraEntrada,this.controllerHoraSaida,this.controllerIntervalo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HoraState();
  }

class _HoraState extends State<ZHora> {
  bool dMaisUm = false;

  bool _visibles = false;

  bool okEntrada = true;
  bool okSaida = true;
  bool okIntervalo = true;

  FocusNode _focusEntrada;
  FocusNode _focusSaida;
  FocusNode _focusIntervalo;

  String _horaEntrada;
  String _minutoEntrada;
  int _intHoraEntrada = 0;
  int _intMinutoEntrada;
  
  String horarioInteiroEntrada;
  String horarioInteiroSaida;
  String horarioInteiroIntervalo;

  String _horaSaida;
  String _minutoSaida;
  int _intHoraSaida = 0;
  int _intMinutoSaida;

  Color colorHoraEntrada = Colors.grey;
  Color colorHoraSaida = Colors.grey;
  Color colorIntervalo = Colors.grey;

  String _horaIntervalo;
  String _minutoIntervalo;
  int _intHoraIntervalo;
  int _intMinutoIntervalo;
  //bool _visible = true;

  @override
  void initState() {
    super.initState();
    if(widget.controllerHoraEntrada.text != "" && widget.controllerIntervalo.text != "" && widget.controllerHoraSaida.text != ""){
      ajustarHorarioInicioPadrao(widget.controllerHoraEntrada.text);
      ajustarHoraFimPadrao(widget.controllerHoraSaida.text);
      ajustarHoraIntervaloPadrao(widget.controllerIntervalo.text);
      ajustarDmaisUm();
    }

    _focusEntrada = FocusNode();
    _focusSaida = FocusNode();
    _focusIntervalo = FocusNode();
    _focusEntrada.addListener(() {
      if (!_focusEntrada.hasFocus && horarioInteiroEntrada.length < 5) {
        showAlertDialogNew("Campo Incompleto!","Por Favor, termine de digitar o horário de entrada.");
        _fieldFocusChange(context, _focusEntrada, _focusEntrada);
      }
    });
    _focusSaida.addListener(() {

      if (!_focusSaida.hasFocus && horarioInteiroSaida.length < 5) {
        showAlertDialogNew("Campo Incompleto!","Por Favor, termine de digitar o horário de saída.");
        _fieldFocusChange(context, _focusSaida, _focusSaida);
      }
  /*    else if(horarioInteiroEntrada == null)
        {
          showAlertDialogNewAlert("OPS!","Por Favor, digite primeiro o horario de entrada.");
          _fieldFocusChange(context, _focusEntrada, _focusEntrada);

        }*/
    });
    _focusIntervalo.addListener(() {
      if (!_focusIntervalo.hasFocus && horarioInteiroIntervalo.length < 5) {
        showAlertDialogNew("Campo Incompleto!","Por Favor, termine de digitar o horário de intervalo.");
        _fieldFocusChange(context, _focusIntervalo, _focusIntervalo);
      }
    /*  else if(horarioInteiroEntrada == null || horarioInteiroSaida == null)
      {
        showAlertDialogNewAlert("OPS!","Por Favor, digite primeiro o horario de entrada.");
        _fieldFocusChange(context, _focusEntrada, _focusEntrada);

      }*/
    });
    _focusSaida.addListener(() {
      if (_intHoraEntrada > _intHoraSaida && _intHoraSaida != 0) {
        setState(() {
          _visibles = true;
        });
      } else {
        setState(() {
          _visibles = false;
        });
      }
    });
  }

 /* void dismiss() {
    setState(() {
      this._visible = false;
    });
  }
*/
/*  void show() {
    setState(() {
      this._visible = true;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          margin: EdgeInsets.only(top: 30),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
             new Expanded(
               child:  new Container(
                 alignment: Alignment.center,
               child: new Text("Hora Entrada:"),
             ),),
             new Expanded(
               child: new Container(
                 alignment: Alignment.center,
               child:
               new Text("Hora Saída:"),
             ),),
            new Expanded(
              child:   new Container(
                alignment: Alignment.center,
                child: new Text("Hora Intervalo:"),
            ),)
            ],
          ),
        ),
        new Container(
          margin: EdgeInsets.only(top: 5, bottom: 20),
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Expanded(
                  child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Expanded(
                        child: new Container(
                          margin: EdgeInsets.only(left: 10),
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          decoration: new BoxDecoration(
                            border: new Border.all(color: colorHoraEntrada ,width: (okEntrada == true)? 1 : 2),
                            color: Colors.white,
                            borderRadius: new BorderRadius.all(
                                const Radius.circular(5.0)),
                          ),
                          child: new Container(
                              child: new TextField(
                                keyboardAppearance: Brightness.light,
                                textAlign: TextAlign.center,
                                controller: widget.controllerHoraEntrada,
                                onSubmitted: (term) {
                                  _fieldFocusChange(
                                      context, _focusEntrada, _focusEntrada);
                                },
                                inputFormatters: [
                                  MaskedTextInputFormatterShifter(
                                      maskONE: "XX:XX", maskTWO: "XX:XX"),
                                  BlacklistingTextInputFormatter(RegExp("[/\\\\,.-]")),
                                  BlacklistingTextInputFormatter(RegExp(" ")),
                                ],
                                focusNode: _focusEntrada,
                                keyboardType: TextInputType.number,
                                //controller: _binding.controllerHorarioInicio,
                                decoration:
                                    InputDecoration.collapsed(hintText: ""),
                                onChanged: (text) {
                                  text = widget.controllerHoraEntrada.text;
                                  ajustarHorarioInicio(text);
                                },
                              )),
                        ),
                      ),
                      new Expanded(
                        child: new Container(
                            margin: EdgeInsets.only(right: 5, left: 5),
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            decoration: new BoxDecoration(
                              border: new Border.all(color: colorHoraSaida ,width: (okSaida == true)?1: 2),
                              color: Colors.white,
                              borderRadius: new BorderRadius.all(
                                  const Radius.circular(5.0)),
                            ),
                            child: new Stack(
                              children: <Widget>[
                                new Container(
                                  margin: _visibles ? const EdgeInsets.only(right: 10): const EdgeInsets.only(right: 0),
                                    child: new TextField(
                                      keyboardAppearance: Brightness.light,
                                      onSubmitted: (term) {
                                        _fieldFocusChange(
                                            context, _focusSaida, _focusSaida);
                                      },
                                      textAlign: TextAlign.center,
                                      controller: widget.controllerHoraSaida,
                                      inputFormatters: [
                                        MaskedTextInputFormatterShifter(
                                            maskONE: "XX:XX", maskTWO: "XX:XX"),
                                        BlacklistingTextInputFormatter(RegExp("[/\\\\,.-]")),
                                        BlacklistingTextInputFormatter(RegExp(" ")),
                                      ],
                                      focusNode: _focusSaida,
                                      keyboardType: TextInputType.number,
                                      //controller: _binding.controllerFim,
                                      decoration: InputDecoration.collapsed(
                                          hintText: ""),
                                      onChanged: (text) {
                                        text = widget.controllerHoraSaida.text;
                                       ajustarHoraFim(text);
                                      },
                                    )),
                                new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          AnimatedOpacity(
                                            duration: Duration(milliseconds: 200),
                                            opacity: _visibles ? 1 : 0,
                                            child: new Container(
                                              margin:
                                              const EdgeInsets.only(right: 2),
                                              decoration: new BoxDecoration(
                                                  color: const Color(0xff2bbab4),
                                                  borderRadius:
                                                  new BorderRadius.all(
                                                      const Radius.circular(
                                                          5.0))),
                                              width: 28,
                                              height: 18,
                                              child: new Center(
                                                child: new Text(
                                                  "d+1",
                                                  style: new TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10),
                                                ),
                                              ),
                                            ),
                                          )

                                        ],
                                      )

                              ],
                            )),
                      ),
                      new Expanded(
                        child: new Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          decoration: new BoxDecoration(
                            border: new Border.all(color: colorIntervalo ,width:(okIntervalo == true)? 1:2),
                            color: Colors.white,
                            borderRadius: new BorderRadius.all(
                                const Radius.circular(5.0)),
                          ),
                          child: new Container(
                             // margin: EdgeInsets.only(left: 30.0),
                              child: new TextField(
                                keyboardAppearance: Brightness.light,
                                textAlign: TextAlign.center,
                                onSubmitted: (term) {
                                  _fieldFocusChange(
                                      context, _focusIntervalo, _focusIntervalo);
                                },
                                controller: widget.controllerIntervalo,
                                focusNode: _focusIntervalo,
                                inputFormatters: [
                                  MaskedTextInputFormatterShifter(
                                      maskONE: "XX:XX", maskTWO: "XX:XX"),
                                  BlacklistingTextInputFormatter(RegExp("[/\\\\,.-]")),
                                  BlacklistingTextInputFormatter(RegExp(" ")),
                                ],
                                keyboardType: TextInputType.number,
                                // controller: _binding.controllerIntervalo,
                                decoration:
                                    InputDecoration.collapsed(hintText: ""),
                                onChanged: (text) {
                                  text = widget.controllerIntervalo.text;
                                  ajustarHoraIntervalo(text);
                                },
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              )),
            ],
          ),
        ),
      ],
    );
  }
  void ajustarHorarioInicio(String text)
  {
    horarioInteiroEntrada = text;
    _horaEntrada = text.substring(0, 2);
    _minutoEntrada = text.substring(3, 5);
    _intHoraEntrada = int.parse(_horaEntrada);
    _intMinutoEntrada = int.parse(_minutoEntrada);
    if (text.length == 5) {
      if (_intHoraEntrada > 23 &&
          _intMinutoEntrada > 59) {
        showAlertDialogNew("Horario Inválido!", "Por favor insira um valor de hora entre 00 e 23 e um minuto de 00 a 59.");
        _fieldFocusChange(context, _focusEntrada, _focusEntrada);
        okEntrada = false;
        setState(() {
          colorHoraEntrada = const Color(0xffE53629);
        });

      } else if (_intHoraEntrada > 23 &&
          _intMinutoEntrada < 59) {
        showAlertDialogNew("Hora Inválida!", "Por favor insira um valor de hora entre 00 e 23.");
        _fieldFocusChange(context, _focusEntrada, _focusEntrada);
        okEntrada = false;
        setState(() {
          colorHoraEntrada = const Color(0xffE53629);
        });

      } else if (_intHoraEntrada < 24 &&
          _intMinutoEntrada > 59) {
        showAlertDialogNew("Minuto Inválido!", "Por favor insira um valor de minuto entre 00 e 59.");
        _fieldFocusChange(context, _focusEntrada, _focusEntrada);
        okEntrada = false;
        setState(() {
          colorHoraEntrada = const Color(0xffE53629);
        });

      } else {
        _fieldFocusChange(
            context, _focusEntrada, _focusSaida);
        okEntrada = true;
        setState(() {
          colorHoraEntrada = Colors.grey;
          horarioTrabalhado();
          ajustarDmaisUm();
        });
      }
    }
  }
  void ajustarHorarioInicioPadrao(String text)
  {

    horarioInteiroEntrada = text;
    _horaEntrada = text.substring(0, 2);
    _minutoEntrada = text.substring(3, 5);
    _intHoraEntrada = int.parse(_horaEntrada);
    _intMinutoEntrada = int.parse(_minutoEntrada);
    if (text.length == 5) {
      if (_intHoraEntrada > 23 &&
          _intMinutoEntrada > 59) {
        okEntrada = false;
        setState(() {
          colorHoraEntrada = const Color(0xffE53629);
        });

      } else if (_intHoraEntrada > 23 &&
          _intMinutoEntrada < 59) {
        okEntrada = false;
        setState(() {
          colorHoraEntrada = const Color(0xffE53629);
        });

      } else if (_intHoraEntrada < 24 &&
          _intMinutoEntrada > 59) {
        okEntrada = false;
        setState(() {
          colorHoraEntrada = const Color(0xffE53629);
        });

      } else {
        okEntrada = true;
        setState(() {
          colorHoraEntrada = Colors.grey;
        });
      }
    }
  }
  void ajustarHoraFim(String text){
    horarioInteiroSaida = text;
    _horaSaida = text.substring(0, 2);
    _minutoSaida = text.substring(3, 5);
    _intHoraSaida = int.parse(_horaSaida);
    _intMinutoSaida = int.parse(_minutoSaida);

    if (text.length == 5) {
      if (_intHoraSaida > 23 &&
          _intMinutoSaida > 59) {
        showAlertDialogNew(
            "Horario Inválido!",
            "Por favor insira um valor de hora entre 00 e 23 e um minuto de 00 a 59.");
        _fieldFocusChange(context, _focusSaida, _focusSaida);
        okSaida = false;
        setState(() {
          colorHoraSaida = const Color(0xffE53629);
        });
      } else if (_intHoraSaida > 23 &&
          _intMinutoSaida < 59) {
        showAlertDialogNew("Hora Inválida!",
            "Por favor insira um valor de hora entre 00 e 23.");
        _fieldFocusChange(context, _focusSaida, _focusSaida);
        okSaida = false;

        setState(() {
          colorHoraSaida = const Color(0xffE53629);
        });

      } else if (_intHoraSaida < 23 &&
          _intMinutoSaida > 59) {
        showAlertDialogNew(
            "Minuto Inválido!",
            "Por favor insira um valor de minuto entre 00 e 59.");
        _fieldFocusChange(context, _focusSaida, _focusSaida);
        okSaida = false;

        setState(() {
          colorHoraSaida = const Color(0xffE53629);
        });

      } else {
        _fieldFocusChange(context,
            _focusSaida, _focusIntervalo);
        okSaida = true;

        setState(() {
          colorHoraSaida = Colors.grey;
          horarioTrabalhado();
        });
      }
    }
  }
  void ajustarHoraFimPadrao(String text){
    horarioInteiroSaida = text;
    _horaSaida = text.substring(0, 2);
    _minutoSaida = text.substring(3, 5);
    _intHoraSaida = int.parse(_horaSaida);
    _intMinutoSaida = int.parse(_minutoSaida);

    if (text.length == 5) {
      if (_intHoraSaida > 23 &&
          _intMinutoSaida > 59) {
        okSaida = false;
        setState(() {
          colorHoraSaida = const Color(0xffE53629);
        });
      } else if (_intHoraSaida > 23 &&
          _intMinutoSaida < 59) {
        okSaida = false;

        setState(() {
          colorHoraSaida = const Color(0xffE53629);
        });

      } else if (_intHoraSaida < 23 &&
          _intMinutoSaida > 59) {
        okSaida = false;

        setState(() {
          colorHoraSaida = const Color(0xffE53629);
        });

      } else {
        okSaida = true;
        setState(() {
          colorHoraSaida = Colors.grey;
        });
      }
    }
  }
  void ajustarHoraIntervalo(String text){
    horarioInteiroIntervalo = text;
    _horaIntervalo = text.substring(0, 2);
    _minutoIntervalo = text.substring(3, 5);
    _intHoraIntervalo = int.parse(_horaIntervalo);
    _intMinutoIntervalo =
        int.parse(_minutoIntervalo);

    if (text.length == 5) {
      if (_intHoraIntervalo > 23 &&
          _intMinutoIntervalo > 59) {
        showAlertDialogNew("Horario Inválido!",
            "Por favor insira um valor de hora entre 00 e 23 e um minuto de 00 a 59.");
        _fieldFocusChange(context, _focusIntervalo, _focusIntervalo);
        okIntervalo = false;
        setState(() {
          colorIntervalo = const Color(0xffE53629);
        });
      } else if (_intHoraIntervalo > 23 &&
          _intMinutoIntervalo < 59) {
        showAlertDialogNew("Hora Inválida!",
            "Por favor insira um valor de hora entre 00 e 23.");
        _fieldFocusChange(context, _focusIntervalo, _focusIntervalo);
        okIntervalo = false;

        setState(() {
          colorIntervalo = const Color(0xffE53629);
        });
      } else if (_intHoraIntervalo < 23 &&
          _intMinutoIntervalo > 59) {
        showAlertDialogNew("Minuto Inválido!",
            "Por favor insira um valor de minuto entre 00 e 59.");
        _fieldFocusChange(context, _focusIntervalo, _focusIntervalo);
        okIntervalo = false;

        setState(() {
          colorIntervalo = const Color(0xffE53629);
        });
      } else {
        horarioTrabalhado();
      }
    }
  }
  void ajustarHoraIntervaloPadrao(String text){
    horarioInteiroIntervalo = text;
    _horaIntervalo = text.substring(0, 2);
    _minutoIntervalo = text.substring(3, 5);
    _intHoraIntervalo = int.parse(_horaIntervalo);
    _intMinutoIntervalo =
        int.parse(_minutoIntervalo);

    if (text.length == 5) {
      if (_intHoraIntervalo > 23 &&
          _intMinutoIntervalo > 59) {
        okIntervalo = false;
        setState(() {
          colorIntervalo = const Color(0xffE53629);
        });
      } else if (_intHoraIntervalo > 23 &&
          _intMinutoIntervalo < 59) {
        okIntervalo = false;

        setState(() {
          colorIntervalo = const Color(0xffE53629);
        });
      } else if (_intHoraIntervalo < 23 &&
          _intMinutoIntervalo > 59) {
        okIntervalo = false;
        setState(() {
          colorIntervalo = const Color(0xffE53629);
        });
      } else {
        horarioTrabalhadoPadrao();
      }
    }

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

  void showAlertDialogNewAlert(String title, String message) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => ZAlertDialog(
              zDialog: ZDialog.alert,
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

  void horarioTrabalhado() {
    var _horarioTrabalhado;
    if (_intHoraEntrada > _intHoraSaida) {
      _horarioTrabalhado = 24 - _intHoraEntrada;
      _horarioTrabalhado = _horarioTrabalhado + _intHoraSaida;
      print(_horarioTrabalhado);
      if (_intHoraIntervalo >= _horarioTrabalhado) {
        showAlertDialogNew("Erro de Jornada!",
            "O intervalo não pode ser maior que a jornada trabalhada.");
        okIntervalo = false;

        setState(() {
          colorIntervalo = const Color(0xffE53629);
        });
        _fieldFocusChange(context,
            _focusIntervalo, _focusIntervalo);
      }
      else{
        FocusScope.of(context)
            .requestFocus(new FocusNode());
        okIntervalo = true;

        setState(() {
          colorIntervalo = Colors.grey;
        });
      }
    } else {
      _horarioTrabalhado = _intHoraSaida - _intHoraEntrada;
      print(_horarioTrabalhado);
      if (_intHoraIntervalo >= _horarioTrabalhado) {
        showAlertDialogNew("Erro de Jornada!",
            "O intervalo não pode ser maior que a jornada trabalhada.");
        okIntervalo = false;

        setState(() {
          colorIntervalo = const Color(0xffE53629);
        });
        _fieldFocusChange(context,
            _focusIntervalo, _focusIntervalo);
      }
      else{
        FocusScope.of(context)
            .requestFocus(new FocusNode());
        okIntervalo = true;

        setState(() {
          colorIntervalo = Colors.grey;
        });
      }
    }
  }
  void horarioTrabalhadoPadrao() {
    var _horarioTrabalhado;
    if (_intHoraEntrada > _intHoraSaida) {
      _horarioTrabalhado = 24 - _intHoraEntrada;
      _horarioTrabalhado = _horarioTrabalhado + _intHoraSaida;
      print(_horarioTrabalhado);
      if (_intHoraIntervalo >= _horarioTrabalhado) {
        okIntervalo = false;
        setState(() {
          colorIntervalo = const Color(0xffE53629);
        });
        _fieldFocusChange(context,
            _focusIntervalo, _focusIntervalo);
      }
      else{
        okIntervalo = true;
        setState(() {
          colorIntervalo = Colors.grey;
        });
      }
    } else {
      _horarioTrabalhado = _intHoraSaida - _intHoraEntrada;
      print(_horarioTrabalhado);
      if (_intHoraIntervalo >= _horarioTrabalhado) {
        okIntervalo = false;
        setState(() {
          colorIntervalo = const Color(0xffE53629);
        });
      }
      else{
        okIntervalo = true;
        setState(() {
          colorIntervalo = Colors.grey;
        });
      }
    }
  }
  void ajustarDmaisUm(){
    if (_intHoraEntrada > _intHoraSaida && _intHoraSaida != 0) {
      setState(() {
        _visibles = true;
      });
    } else {
      setState(() {
        _visibles = false;
      });
    }
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
