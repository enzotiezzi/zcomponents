import 'package:z_components/i-serializable.dart';

class ZLogViewModel implements ISerializable {
  String? user;
  String? errorMessage;
  String? when;
  String? app;
  String? payload;
  String? method;

  ZLogViewModel(
      {this.user,
      this.errorMessage,
      this.when,
      this.app,
      this.payload,
      this.method});

  @override
  Map toMap() {
    return {
      "user": this.user,
      "errorMessage": this.errorMessage,
      "when": this.when,
      "app": this.app,
      "payload": this.payload,
      "method": this.method
    };
  }
}
