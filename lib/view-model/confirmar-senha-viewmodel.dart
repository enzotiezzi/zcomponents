class ConfirmarSenhaViewModel {
  String pin;

  ConfirmarSenhaViewModel({
    this.pin,
  });

  factory ConfirmarSenhaViewModel.fromJson(Map<String, dynamic> json) {
    return new ConfirmarSenhaViewModel(
      pin: json['pin'],
    );
  }

  Map toMap() {
    return {
      "pin": this.pin,
    };
  }
}
