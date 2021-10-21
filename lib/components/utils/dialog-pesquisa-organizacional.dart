import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/view-model/dialog-pesquisa-orgazinacional-viewmodel.dart';

class DialogIntroducaoPesquisaOrganizacional extends StatefulWidget {
  final DialogPesquisaOrgazinacionalViewModel
      dialogPesquisaOrgazinacionalViewModel;

  const DialogIntroducaoPesquisaOrganizacional({
    this.dialogPesquisaOrgazinacionalViewModel,
  });

  @override
  _DialogIntroducaoPesquisaOrganizacionalState createState() =>
      _DialogIntroducaoPesquisaOrganizacionalState();
}

class _DialogIntroducaoPesquisaOrganizacionalState extends State<DialogIntroducaoPesquisaOrganizacional> {
  @override
  Widget build(BuildContext context) {
    return new Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return new Stack(
      children: <Widget>[
        new Container(
          padding: const EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: const EdgeInsets.only(top: Constants.avatarRadius),
          decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: new BorderRadius.circular(Constants.padding),
              boxShadow: [
                new BoxShadow(
                    color: Colors.black, offset: Offset(0, 2), blurRadius: 10),
              ]),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Text(widget.dialogPesquisaOrgazinacionalViewModel.titulo,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center),
              new SizedBox(
                height: 15,
              ),
              new Text(
                widget.dialogPesquisaOrgazinacionalViewModel.descricaoCentral,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              new SizedBox(
                height: 22,
              ),
              new FlatButton(
                  onPressed: () {
                    widget.dialogPesquisaOrgazinacionalViewModel
                        .onTapBotaoConfirmar();
                  },
                  child: new Text(
                    widget.dialogPesquisaOrgazinacionalViewModel
                        .textoBotaoConfirmar,
                    style:
                        const TextStyle(fontSize: 15, color: Color(0xff2BBAB4)),
                  )),
              new Divider(
                height: 1,
              ),
              new FlatButton(
                  onPressed: () {
                    widget.dialogPesquisaOrgazinacionalViewModel
                        .onTapBotaoCancelar();
                  },
                  child: new Text(
                    widget.dialogPesquisaOrgazinacionalViewModel
                        .textoBotaoCancelar,
                    style:
                        const TextStyle(fontSize: 15, color: Color(0xff2BBAB4)),
                  )),
            ],
          ),
        ),
        new Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: new CircleAvatar(
            backgroundColor: const Color(0xff2BBAB4),
            radius: Constants.avatarRadius,
            child: new ClipRRect(
                borderRadius: const BorderRadius.all(
                    Radius.circular(Constants.avatarRadius)),
                child:
                    new Icon(Icons.analytics, size: 40, color: Colors.white)),
          ),
        ),
      ],
    );
  }
}

class Constants {
  Constants._();

  static const double padding = 15;
  static const double avatarRadius = 40;
}
