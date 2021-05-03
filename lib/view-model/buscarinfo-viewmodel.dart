import 'dart:typed_data';

class BuscarInfo {
  String idUsuario;
  String username;
  String cpf;
  String email;
  String emailSec;
  String nome;
  String nomeReduzido;
  String idPessoa;
  String nomeSocial;
  String telefone;
  String telefoneSec;
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
  Uint8List fotoBase64;
  bool atualizado;
  String idAnexoCartaoValeTransporte;
  String idAnexoCartaoValeTransporte_Verso;
  String anexoCartaoValeTransporteStatus;
  String idAnexoCartaoAlimentacao;
  String idAnexoCartaoAlimentacao_Verso;
  String anexoCartaoAlimentacaoStatus;
  String idAnexoCartaoContaBancaria;
  String idAnexoCartaoContaBancaria_Verso;
  String anexoCartaoContaBancariaStatus;
  String idAnexoComprovanteEndereco;
  String idAnexoComprovanteEndereco_Verso;
  String anexoComprovanteEnderecoStatus;
  String idAnexoRG;
  String idAnexoRG_Verso;
  String anexoRGStatus;
  String idAnexoCPF;
  String idAnexoCPF_Verso;
  String anexoCPFStatus;
  String idAnexoCertidaoNascimentoCasamento;
  String idAnexoCertidaoNascimentoCasamento_Verso;
  String anexoCertidaoNascimentoCasamentoStatus;
  String idAnexoTituloEleitor;
  String idAnexoTituloEleitor_Verso;
  String anexoTituloEleitorStatus;
  String idAnexoPIS;
  String idAnexoPIS_Verso;
  String anexoPISStatus;
  String idAnexoCTPS;
  String idAnexoCTPS_Verso;
  String anexoCTPSStatus;
  String idAnexoEscolaridade;
  String idAnexoEscolaridade_Verso;
  String anexoEscolaridadeStatus;
  String idAnexoCarteiraVacinacao;
  String idAnexoCarteiraVacinacao_Verso;
  String anexoCarteiraVacinacaoStatus;
  String numeroCartaoValeTransporte;
  String numeroCartaoAlimentacao;
  String nomeBanco;
  String numeroBancoAgencia;
  String numeroContaBancaria;
  String numeroInscricaoTituloEleitor;
  String numeroZonaTituloEleitor;
  String numeroSessaoTituloEleitor;
  String numeroPIS;
  String numeroCTPS;
  String rg;

  BuscarInfo(
      {this.idUsuario,
      this.username,
      this.cpf,
      this.emailSec,
      this.email,
      this.nome,
      this.nomeReduzido,
      this.idPessoa,
      this.nomeSocial,
      this.telefone,
      this.telefoneSec,
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
      this.idAnexoCartaoValeTransporte_Verso,
      this.anexoCartaoValeTransporteStatus,
      this.idAnexoCartaoAlimentacao,
      this.idAnexoCartaoAlimentacao_Verso,
      this.anexoCartaoAlimentacaoStatus,
      this.idAnexoCartaoContaBancaria,
      this.idAnexoCartaoContaBancaria_Verso,
      this.anexoCartaoContaBancariaStatus,
      this.idAnexoComprovanteEndereco,
      this.idAnexoComprovanteEndereco_Verso,
      this.anexoComprovanteEnderecoStatus,
      this.idAnexoRG,
      this.idAnexoRG_Verso,
      this.anexoRGStatus,
      this.idAnexoCPF,
      this.idAnexoCPF_Verso,
      this.anexoCPFStatus,
      this.idAnexoCertidaoNascimentoCasamento,
      this.idAnexoCertidaoNascimentoCasamento_Verso,
      this.anexoCertidaoNascimentoCasamentoStatus,
      this.idAnexoTituloEleitor,
      this.idAnexoTituloEleitor_Verso,
      this.anexoTituloEleitorStatus,
      this.idAnexoPIS,
      this.idAnexoPIS_Verso,
      this.anexoPISStatus,
      this.idAnexoCTPS,
      this.idAnexoCTPS_Verso,
      this.anexoCTPSStatus,
      this.idAnexoEscolaridade,
      this.idAnexoEscolaridade_Verso,
      this.anexoEscolaridadeStatus,
      this.idAnexoCarteiraVacinacao,
      this.idAnexoCarteiraVacinacao_Verso,
      this.anexoCarteiraVacinacaoStatus,
      this.atualizado,
      this.numeroCartaoValeTransporte,
      this.numeroCartaoAlimentacao,
      this.nomeBanco,
      this.numeroBancoAgencia,
      this.numeroContaBancaria,
      this.numeroInscricaoTituloEleitor,
      this.numeroZonaTituloEleitor,
      this.numeroSessaoTituloEleitor,
      this.numeroPIS,
      this.numeroCTPS,
      this.rg});

  factory BuscarInfo.fromJson(Map<String, dynamic> json) {
    return new BuscarInfo(
        idUsuario: json["idUsuario"],
        username: json["username"],
        cpf: json["cpf"],
        email: json["email"],
        emailSec: json["emailSec"],
        telefoneSec: json["telefoneSec"],
        nome: json["nome"],
        nomeReduzido: json["nomeReduzido"],
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
        idAnexoCartaoValeTransporte_Verso:
            json["idAnexoCartaoValeTransporte_Verso"],
        anexoCartaoValeTransporteStatus:
            json["anexoCartaoValeTransporteStatus"],
        idAnexoCartaoAlimentacao: json["idAnexoCartaoAlimentacao"],
        idAnexoCartaoAlimentacao_Verso: json["idAnexoCartaoAlimentacao_Verso"],
        anexoCartaoAlimentacaoStatus: json["anexoCartaoAlimentacaoStatus"],
        idAnexoCartaoContaBancaria: json["idAnexoCartaoContaBancaria"],
        idAnexoCartaoContaBancaria_Verso:
            json["idAnexoCartaoContaBancaria_Verso"],
        anexoCartaoContaBancariaStatus: json["anexoCartaoContaBancariaStatus"],
        idAnexoComprovanteEndereco: json["idAnexoComprovanteEndereco"],
        idAnexoComprovanteEndereco_Verso:
            json["idAnexoComprovanteEndereco_Verso"],
        anexoComprovanteEnderecoStatus: json["anexoComprovanteEnderecoStatus"],
        idAnexoRG: json["idAnexoRG"],
        idAnexoRG_Verso: json["idAnexoRG_Verso"],
        anexoRGStatus: json["anexoRGStatus"],
        idAnexoCPF: json["idAnexoCPF"],
        idAnexoCPF_Verso: json["idAnexoCPF_Verso"],
        anexoCPFStatus: json["anexoCPFStatus"],
        idAnexoCertidaoNascimentoCasamento:
            json["idAnexoCertidaoNascimentoCasamento"],
        idAnexoCertidaoNascimentoCasamento_Verso:
            json["idAnexoCertidaoNascimentoCasamento_Verso"],
        anexoCertidaoNascimentoCasamentoStatus:
            json["anexoCertidaoNascimentoCasamentoStatus"],
        idAnexoTituloEleitor: json["idAnexoTituloEleitor"],
        idAnexoTituloEleitor_Verso: json["idAnexoTituloEleitor_Verso"],
        anexoTituloEleitorStatus: json["anexoTituloEleitorStatus"],
        idAnexoPIS: json["idAnexoPIS"],
        idAnexoPIS_Verso: json["idAnexoPIS_Verso"],
        anexoPISStatus: json["anexoPISStatus"],
        idAnexoCTPS: json["idAnexoCTPS"],
        idAnexoCTPS_Verso: json["idAnexoCTPS_Verso"],
        anexoCTPSStatus: json["anexoCTPSStatus"],
        idAnexoEscolaridade: json["idAnexoEscolaridade"],
        idAnexoEscolaridade_Verso: json["idAnexoEscolaridade_Verso"],
        anexoEscolaridadeStatus: json["anexoEscolaridadeStatus"],
        idAnexoCarteiraVacinacao: json["idAnexoCarteiraVacinacao"],
        idAnexoCarteiraVacinacao_Verso: json["idAnexoCarteiraVacinacao_Verso"],
        anexoCarteiraVacinacaoStatus: json["anexoCarteiraVacinacaoStatus"],
        numeroCartaoValeTransporte: json["numeroCartaoValeTransporte"],
        numeroCartaoAlimentacao: json["numeroCartaoAlimentacao"],
        nomeBanco: json["nomeBanco"],
        numeroBancoAgencia: json["numeroBancoAgencia"],
        numeroContaBancaria: json["numeroContaBancaria"],
        numeroInscricaoTituloEleitor: json["numeroInscricaoTituloEleitor"],
        numeroZonaTituloEleitor: json["numeroZonaTituloEleitor"],
        numeroSessaoTituloEleitor: json["numeroSessaoTituloEleitor"],
        numeroPIS: json["numeroPis"],
        numeroCTPS: json["numeroCtps"],
        rg: json["rg"]);
  }

  Map toMap() {
    return {
      "idUsuario": idUsuario,
      "username": username,
      "cpf": cpf,
      "email": email,
      "emailSec":emailSec,
      "telefoneSec":telefoneSec,
      "nome": nome,
      "nomeReduzido": nomeReduzido,
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
      "idAnexoCartaoValeTransporte": idAnexoCartaoValeTransporte,
      "idAnexoCartaoValeTransporte_Verso": idAnexoCartaoValeTransporte_Verso,
      "anexoCartaoValeTransporteStatus": anexoCartaoValeTransporteStatus,
      "idAnexoCartaoAlimentacao": idAnexoCartaoAlimentacao,
      "idAnexoCartaoAlimentacao_Verso": idAnexoCartaoAlimentacao_Verso,
      "anexoCartaoAlimentacaoStatus": anexoCartaoAlimentacaoStatus,
      "idAnexoCartaoContaBancaria": idAnexoCartaoContaBancaria,
      "idAnexoCartaoContaBancaria_Verso": idAnexoCartaoContaBancaria_Verso,
      "anexoCartaoContaBancariaStatus": anexoCartaoContaBancariaStatus,
      "idAnexoComprovanteEndereco": idAnexoComprovanteEndereco,
      "idAnexoComprovanteEndereco_Verso": idAnexoComprovanteEndereco_Verso,
      "anexoComprovanteEnderecoStatus": anexoComprovanteEnderecoStatus,
      "idAnexoRG": idAnexoRG,
      "idAnexoRG_Verso": idAnexoRG_Verso,
      "anexoRGStatus": anexoRGStatus,
      "idAnexoCPF": idAnexoCPF,
      "idAnexoCPF_Verso": idAnexoCPF_Verso,
      "anexoCPFStatus": anexoCPFStatus,
      "idAnexoCertidaoNascimentoCasamento": idAnexoCertidaoNascimentoCasamento,
      "idAnexoCertidaoNascimentoCasamento_Verso":
          idAnexoCertidaoNascimentoCasamento_Verso,
      "anexoCertidaoNascimentoCasamentoStatus":
          anexoCertidaoNascimentoCasamentoStatus,
      "idAnexoTituloEleitor": idAnexoTituloEleitor,
      "idAnexoTituloEleitor_Verso": idAnexoTituloEleitor_Verso,
      "anexoTituloEleitorStatus": anexoTituloEleitorStatus,
      "idAnexoPIS": idAnexoPIS,
      "idAnexoPIS_Verso": idAnexoPIS_Verso,
      "anexoPISStatus": anexoPISStatus,
      "idAnexoCTPS": idAnexoCTPS,
      "idAnexoCTPS_Verso": idAnexoCTPS_Verso,
      "anexoCTPSStatus": anexoCTPSStatus,
      "idAnexoEscolaridade": idAnexoEscolaridade,
      "idAnexoEscolaridade_Verso": idAnexoEscolaridade_Verso,
      "anexoEscolaridadeStatus": anexoEscolaridadeStatus,
      "idAnexoCarteiraVacinacao": idAnexoCarteiraVacinacao,
      "idAnexoCarteiraVacinacao_Verso": idAnexoCarteiraVacinacao_Verso,
      "anexoCarteiraVacinacaoStatus": anexoCarteiraVacinacaoStatus,
      "numeroCartaoValeTransporte": numeroCartaoValeTransporte,
      "numeroCartaoAlimentacao": numeroCartaoAlimentacao,
      "nomeBanco": nomeBanco,
      "numeroBancoAgencia": numeroBancoAgencia,
      "numeroContaBancaria": numeroContaBancaria,
      "numeroInscricaoTituloEleitor": numeroInscricaoTituloEleitor,
      "numeroZonaTituloEleitor": numeroZonaTituloEleitor,
      "numeroSessaoTituloEleitor": numeroSessaoTituloEleitor,
      "numeroPis": numeroPIS,
      "numeroCtps": numeroCTPS,
      "rg": rg
    };
  }
}
