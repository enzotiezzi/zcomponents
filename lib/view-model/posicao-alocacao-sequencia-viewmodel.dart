class PosicaoAlocacaoSequenciaViewModel {
  String idPosicaoAlocacaoSequencia;
  String idPosicaoAlocacao;
  int sequencia;
  String horaInicio;
  String horaFim;
  String horaIntervalo;
  String toF;
  String apelido;

  PosicaoAlocacaoSequenciaViewModel(
      {this.idPosicaoAlocacaoSequencia: "",
      this.idPosicaoAlocacao: "",
      this.sequencia: 0,
      this.horaInicio: "",
      this.horaFim: "",
      this.horaIntervalo: "",
      this.apelido: "",
      this.toF: ""});

  Map toMap() {
    return {
      "sequencia": sequencia,
      "horaInicio": horaInicio,
      "horaFim": horaFim,
      "horaIntervalo": horaIntervalo,
      "toF": toF,
      "apelido": apelido
    };
  }

  factory PosicaoAlocacaoSequenciaViewModel.fromJson(
      Map<String, dynamic> json) {
    return new PosicaoAlocacaoSequenciaViewModel(
        idPosicaoAlocacao: json["idPosicaoAlocacao"],
        horaIntervalo: json["horaIntervalo"],
        horaFim: json["horaFim"],
        horaInicio: json["horaInicio"],
        apelido: json["apelido"],
        idPosicaoAlocacaoSequencia: json["idPosicaoAlocacaoSequencia"],
        sequencia: json["sequencia"],
        toF: json["toF"]);
  }
}
