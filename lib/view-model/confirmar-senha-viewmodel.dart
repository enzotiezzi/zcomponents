class ConfirmarSenhaViewModel {
  String cpf;
  String pin;

  ConfirmarSenhaViewModel({
    this.cpf,
    this.pin,
  });

  factory ConfirmarSenhaViewModel.fromJson(Map<String, dynamic> json) {
    return new ConfirmarSenhaViewModel(
      cpf: json['cpf'],
      pin: json['pin'],
    );
  }

  Map toMap() {
    return {
      "cpf": this.cpf,
      "pin": this.pin,
    };
  }
}
