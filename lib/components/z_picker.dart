import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/config/z-platform.dart';

class ZPicker {
  final BuildContext? context;
  final ValueChanged<DateTime?>? onTimerDurationChanged;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final SelectableDayPredicate? selectableDayPredicate;
  final DatePickerMode? initialDatePickerMode;
  final Locale? locale;
  final TextDirection? textDirection;
  final TransitionBuilder? builder;
  final CupertinoDatePickerMode? mode;
  final DateTime? initialDateTime;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final int? minimumYear;
  final int? maximumYear;
  final bool? use24hFormat;
  final int? minuteInterval;
  final ZPlatform? zPlatform;

  ZPicker({
    this.context,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.selectableDayPredicate,
    this.initialDatePickerMode = DatePickerMode.day,
    this.locale,
    this.textDirection,
    this.builder,
    this.onTimerDurationChanged,
    this.mode = CupertinoDatePickerMode.dateAndTime,
    this.minimumDate,
    this.maximumDate,
    this.minimumYear = 1,
    this.maximumYear,
    this.use24hFormat = true,
    this.minuteInterval = 1,
    this.initialDateTime,
    this.zPlatform = ZPlatform.isPlatform,
  }) {
    switch (zPlatform) {
      case ZPlatform.isPlatform:
        if (Platform.isAndroid) {
          _showDatePicker();
        } else {
          showModalBottomSheet(
              context: this.context!,
              builder: (BuildContext context) {
                return Container(
                    height: 200.0,
                    child: CupertinoDatePicker(
                      onDateTimeChanged: (date) =>
                          this.onTimerDurationChanged!(date),
                      initialDateTime: this.initialDate,
                      minuteInterval: this.minuteInterval!,
                      mode: this.mode!,
                      maximumDate: this.maximumDate,
                      maximumYear: this.maximumYear,
                      minimumDate: this.minimumDate,
                      minimumYear: this.minimumYear!,
                      use24hFormat: this.use24hFormat!,
                    ));
              });
        }
        break;
      case ZPlatform.isAndroid:
        _showDatePicker();
        break;
      case ZPlatform.isIOS:
        showModalBottomSheet(
            context: this.context!,
            builder: (BuildContext context) {
              return Container(
                  height: 200.0,
                  child: CupertinoDatePicker(
                    onDateTimeChanged: (date) =>
                        this.onTimerDurationChanged!(date),
                    initialDateTime: this.initialDate,
                    minuteInterval: this.minuteInterval!,
                    mode: this.mode!,
                    maximumDate: this.maximumDate,
                    maximumYear: this.maximumYear,
                    minimumDate: this.minimumDate,
                    minimumYear: this.minimumYear!,
                    use24hFormat: this.use24hFormat!,
                  ));
            });
        break;
    }
  }

  Future<DateTime?> _showDatePicker() async {
    onTimerDurationChanged!(await showDatePicker(
        context: this.context!,
        initialDate: this.initialDate!,
        firstDate: this.firstDate!,
        lastDate: this.lastDate!,
        locale: this.locale,
        builder: this.builder,
        initialDatePickerMode: this.initialDatePickerMode!,
        selectableDayPredicate: this.selectableDayPredicate,
        textDirection: this.textDirection));
    return _showDatePicker();
  }
}
