class ZBatidaViewModel {
  String? idColaborador;
  String? cpf;
  String? idCentroCusto;
  int? horarioBatida;
  double? latitude;
  double? longitude;
  bool? offline;
  String? dataEnvio;
  String? foto;
  String? idDispositivo;
  bool? valida;
  String? observacao;
  String? ordem;
  String? idBatida;
  String? ticketBatida;
  int? utc;
  bool? origemConectividade;
  String? tipoBatida;
  String? ordemInicial;

  String? ordemSugerido;
  String? ordemTroca;
  String? horarioBatidaCelular;
  String? dataJornada;
  String? horarioBatidaRealizada;

  String? horarioBatidaServidor;
  bool? atualizada;

  ZBatidaViewModel(
      {this.idColaborador,
      this.cpf,
        this.horarioBatidaRealizada,
      this.idCentroCusto,
      this.horarioBatida,
      this.latitude,
      this.longitude,
      this.offline,
      this.dataEnvio,
      this.foto,
      this.idDispositivo,
      this.valida,
      this.observacao,
      this.ordem,
      this.idBatida,
      this.ticketBatida,
      this.utc,
      this.origemConectividade,
      this.tipoBatida,
      this.horarioBatidaCelular,
      this.horarioBatidaServidor,
      this.ordemInicial,
      this.ordemSugerido,
      this.ordemTroca,
      this.atualizada,
      this.dataJornada,
      int? id,
      String? idConta});


}
