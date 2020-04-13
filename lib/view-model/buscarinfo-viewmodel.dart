class BuscarInfo {
  String idUsuario;
  String username;
  String cpf;
  String email;
  String nome;
  String idPessoa;
  String nomeSocial;
  String telefone;
  String celular;
  String dataNascimento;
  String logradouro;
  String numero;
  String complemento;
  String bairro;
  String cidade;
  String estado;
  String cep;
  String idFoto;
  String fotoBase64;
  bool atualizado;
  String idAnexoCartaoValeTransporte;
  String idAnexoCartaoValeTransporteVerso;
  String anexoCartaoValeTransporteStatus;
  String idAnexoCartaoAlimentacao;
  String idAnexoCartaoAlimentacaoVerso;
  String anexoCartaoAlimentacaoStatus;
  String idAnexoCartaoContaBancaria;
  String idAnexoCartaoContaBancariaVerso;
  String anexoCartaoContaBancariaStatus;
  String idAnexoComprovanteEndereco;
  String idAnexoComprovanteEnderecoVerso;
  String anexoComprovanteEnderecoStatus;
  String idAnexoRG;
  String idAnexoRGVerso;
  String anexoRGStatus;
  String idAnexoCPF;
  String idAnexoCPFVerso;
  String anexoCPFStatus;
  String idAnexoCertidaoNascimentoCasamento;
  String idAnexoCertidaoNascimentoCasamentoVerso;
  String anexoCertidaoNascimentoCasamentoStatus;
  String idAnexoTituloEleitor;
  String idAnexoTituloEleitorVerso;
  String anexoTituloEleitorStatus;
  String idAnexoPIS;
  String idAnexoPISVerso;
  String anexoPISStatus;
  String idAnexoCTPS;
  String idAnexoCTPSVerso;
  String anexoCTPSStatus;
  String idAnexoEscolaridade;
  String idAnexoEscolaridadeVerso;
  String anexoEscolaridadeStatus;
  String idAnexoCarteiraVacinacao;
  String idAnexoCarteiraVacinacaoVerso;
  String anexoCarteiraVacinacaoStatus;

  BuscarInfo({
    this.idUsuario,
    this.username,
    this.cpf,
    this.email,
    this.nome,
    this.idPessoa,
    this.nomeSocial,
    this.telefone,
    this.celular,
    this.dataNascimento,
    this.logradouro,
    this.numero,
    this.complemento,
    this.bairro,
    this.cidade,
    this.estado,
    this.cep,
    this.idFoto,
    this.fotoBase64,
    this.idAnexoCartaoValeTransporte,
    this.idAnexoCartaoValeTransporteVerso,
    this.anexoCartaoValeTransporteStatus,
    this.idAnexoCartaoAlimentacao,
    this.idAnexoCartaoAlimentacaoVerso,
    this.anexoCartaoAlimentacaoStatus,
    this.idAnexoCartaoContaBancaria,
    this.idAnexoCartaoContaBancariaVerso,
    this.anexoCartaoContaBancariaStatus,
    this.idAnexoComprovanteEndereco,
    this.idAnexoComprovanteEnderecoVerso,
    this.anexoComprovanteEnderecoStatus,
    this.idAnexoRG,
    this.idAnexoRGVerso,
    this.anexoRGStatus,
    this.idAnexoCPF,
    this.idAnexoCPFVerso,
    this.anexoCPFStatus,
    this.idAnexoCertidaoNascimentoCasamento,
    this.idAnexoCertidaoNascimentoCasamentoVerso,
    this.anexoCertidaoNascimentoCasamentoStatus,
    this.idAnexoTituloEleitor,
    this.idAnexoTituloEleitorVerso,
    this.anexoTituloEleitorStatus,
    this.idAnexoPIS,
    this.idAnexoPISVerso,
    this.anexoPISStatus,
    this.idAnexoCTPS,
    this.idAnexoCTPSVerso,
    this.anexoCTPSStatus,
    this.idAnexoEscolaridade,
    this.idAnexoEscolaridadeVerso,
    this.anexoEscolaridadeStatus,
    this.idAnexoCarteiraVacinacao,
    this.idAnexoCarteiraVacinacaoVerso,
    this.anexoCarteiraVacinacaoStatus,
    this.atualizado
  });


  factory BuscarInfo.fromJson(Map<String, dynamic> json) {
    return new BuscarInfo(
      idUsuario: json["idUsuario"],
      username: json["username"],
      cpf: json["cpf"],
      email: json["email"],
      nome: json["nome"],
      idPessoa: json["idPessoa"],
      nomeSocial: json["nomeSocial"],
      telefone: json["telefone"],
      celular: json["celular"],
      dataNascimento: json["dataNascimento"],
      logradouro: json["logradouro"],
      numero: json["numero"],
      complemento: json["complemento"],
      bairro: json["bairro"],
      cidade: json["cidade"],
      estado: json["estado"],
      cep: json["cep"],
      idFoto: json["idFoto"],
      fotoBase64: json["fotoBase64"],
      idAnexoCartaoValeTransporte: json["idAnexoCartaoValeTransporte"],
      idAnexoCartaoValeTransporteVerso:
          json["idAnexoCartaoValeTransporteVerso"],
      anexoCartaoValeTransporteStatus: json["anexoCartaoValeTransporteStatus"],
      idAnexoCartaoAlimentacao: json["idAnexoCartaoAlimentacao"],
      idAnexoCartaoAlimentacaoVerso: json["idAnexoCartaoAlimentacaoVerso"],
      anexoCartaoAlimentacaoStatus: json["anexoCartaoAlimentacaoStatus"],
      idAnexoCartaoContaBancaria: json["idAnexoCartaoContaBancaria"],
      idAnexoCartaoContaBancariaVerso: json["idAnexoCartaoContaBancariaVerso"],
      anexoCartaoContaBancariaStatus: json["anexoCartaoContaBancariaStatus"],
      idAnexoComprovanteEndereco: json["idAnexoComprovanteEndereco"],
      idAnexoComprovanteEnderecoVerso: json["idAnexoComprovanteEnderecoVerso"],
      anexoComprovanteEnderecoStatus: json["anexoComprovanteEnderecoStatus"],
      idAnexoRG: json["idAnexoRG"],
      idAnexoRGVerso: json["idAnexoRGVerso"],
      anexoRGStatus: json["anexoRGStatus"],
      idAnexoCPF: json["idAnexoCPF"],
      idAnexoCPFVerso: json["idAnexoCPFVerso"],
      anexoCPFStatus: json["anexoCPFStatus"],
      idAnexoCertidaoNascimentoCasamento:
          json["idAnexoCertidaoNascimentoCasamento"],
      idAnexoCertidaoNascimentoCasamentoVerso:
          json["idAnexoCertidaoNascimentoCasamentoVerso"],
      anexoCertidaoNascimentoCasamentoStatus:
          json["anexoCertidaoNascimentoCasamentoStatus"],
      idAnexoTituloEleitor: json["idAnexoTituloEleitor"],
      idAnexoTituloEleitorVerso: json["idAnexoTituloEleitorVerso"],
      anexoTituloEleitorStatus: json["anexoTituloEleitorStatus"],
      idAnexoPIS: json["idAnexoPIS"],
      idAnexoPISVerso: json["idAnexoPISVerso"],
      anexoPISStatus: json["anexoPISStatus"],
      idAnexoCTPS: json["idAnexoCTPS"],
      idAnexoCTPSVerso: json["idAnexoCTPSVerso"],
      anexoCTPSStatus: json["anexoCTPSStatus"],
      idAnexoEscolaridade: json["idAnexoEscolaridade"],
      idAnexoEscolaridadeVerso: json["idAnexoEscolaridadeVerso"],
      anexoEscolaridadeStatus: json["anexoEscolaridadeStatus"],
      idAnexoCarteiraVacinacao: json["idAnexoCarteiraVacinacao"],
      idAnexoCarteiraVacinacaoVerso: json["idAnexoCarteiraVacinacaoVerso"],
      anexoCarteiraVacinacaoStatus: json["anexoCarteiraVacinacaoStatus"],
    );
  }

  Map toMap() {
    return {
      "idUsuario": idUsuario,
      "username": username,
      "cpf": cpf,
      "email": email,
      "nome": nome,
      "idPessoa": idPessoa,
      "nomeSocial": nomeSocial,
      "telefone": telefone,
      "celular": celular,
      "dataNascimento": dataNascimento,
      "logradouro": logradouro,
      "numero": numero,
      "complemento": complemento,
      "bairro": bairro,
      "cidade": cidade,
      "estado": estado,
      "cep": cep,
      "idFoto": idFoto,
      "fotoBase64": fotoBase64,
      "IDANEXOCARTAOVALETRANSPORTE": idAnexoCartaoValeTransporte,
      "IDANEXOCARTAOVALETRANSPORTEVERSO": idAnexoCartaoValeTransporteVerso,
      "ANEXOCARTAOVALETRANSPORTESTATUS": anexoCartaoValeTransporteStatus,
      "IDANEXOCARTAOALIMENTACAO": idAnexoCartaoAlimentacao,
      "IDANEXOCARTAOALIMENTACAOVERSO": idAnexoCartaoAlimentacaoVerso,
      "ANEXOCARTAOALIMENTACAOSTATUS": anexoCartaoAlimentacaoStatus,
      "IDANEXOCARTAOCONTABANCARIA": idAnexoCartaoContaBancaria,
      "IDANEXOCARTAOCONTABANCARIAVERSO": idAnexoCartaoContaBancariaVerso,
      "ANEXOCARTAOCONTABANCARIASTATUS": anexoCartaoContaBancariaStatus,
      "IDANEXOCOMPROVANTEENDERECO": idAnexoComprovanteEndereco,
      "IDANEXOCOMPROVANTEENDERECOVERSO": idAnexoComprovanteEnderecoVerso,
      "ANEXOCOMPROVANTEENDERECOSTATUS": anexoComprovanteEnderecoStatus,
      "IDANEXORG": idAnexoRG,
      "IDANEXORGVERSO": idAnexoRGVerso,
      "ANEXORGSTATUS": anexoRGStatus,
      "IDANEXOCPF": idAnexoCPF,
      "IDANEXOCPFVERSO": idAnexoCPFVerso,
      "ANEXOCPFSTATUS": anexoCPFStatus,
      "IDANEXOCERTIDAONASCIMENTOCASAMENTO": idAnexoCertidaoNascimentoCasamento,
      "IDANEXOCERTIDAONASCIMENTOCASAMENTOVERSO":
          idAnexoCertidaoNascimentoCasamentoVerso,
      "ANEXOCERTIDAONASCIMENTOCASAMENTOSTATUS":
          anexoCertidaoNascimentoCasamentoStatus,
      "IDANEXOTITULOELEITOR": idAnexoTituloEleitor,
      "IDANEXOTITULOELEITORVERSO": idAnexoTituloEleitorVerso,
      "ANEXOTITULOELEITORSTATUS": anexoTituloEleitorStatus,
      "IDANEXOPIS": idAnexoPIS,
      "IDANEXOPISVERSO": idAnexoPISVerso,
      "ANEXOPISSTATUS": anexoPISStatus,
      "IDANEXOCTPS": idAnexoCTPS,
      "IDANEXOCTPSVERSO": idAnexoCTPSVerso,
      "ANEXOCTPSSTATUS": anexoCTPSStatus,
      "IDANEXOESCOLARIDADE": idAnexoEscolaridade,
      "IDANEXOESCOLARIDADEVERSO": idAnexoEscolaridadeVerso,
      "ANEXOESCOLARIDADESTATUS": anexoEscolaridadeStatus,
      "IDANEXOCARTEIRAVACINACAO": idAnexoCarteiraVacinacao,
      "IDANEXOCARTEIRAVACINACAOVERSO": idAnexoCarteiraVacinacaoVerso,
      "ANEXOCARTEIRAVACINACAOSTATUS": anexoCarteiraVacinacaoStatus,
    };
  }
}
