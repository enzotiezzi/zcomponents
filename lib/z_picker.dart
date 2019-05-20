import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZPicker extends StatelessWidget {
  Widget zPicker = new Container();
  BuildContext context;

  ZPicker({
    this.context,
  }) {
    if (Platform.isAndroid) {
      _showDatePicker();
    } else {
      showModalBottomSheet(
          context: this.context,
          builder: (BuildContext context) {
            return Container(
                height: 200.0,
                child: CupertinoDatePicker(
                  onDateTimeChanged: (b) {},
                ));
          });
    }
  }

  Future<DateTime> _showDatePicker() async {
    await showDatePicker(
      context: this.context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return zPicker;
  }
}
