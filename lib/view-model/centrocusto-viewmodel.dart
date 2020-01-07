class CentroCustoViewModel {
  String idCentroCusto;

  String nome;

  String nomeReduzido;

  String codigo;

  String cep;

  String logradouro;

  String numero;

  String complemento;

  String bairro;

  String cidade;

  String cidadeReduzido;

  String estado;

  String pais;

  String latitude;

  String longitude;

  String status;

  String telefone;

  String email;

  String idResponsavel;

  String nomeResponsavel;

  String nomeResponsavel1;

  String nomeResponsavel2;

  String nomeResponsavel3;

  String nomeResponsavel4;

  String cargo;

  String observacao;

  String dataAtivacao;

  String dataInativacao;

  bool ativarApontamentoOnline;

  String idEmpresa;

  bool rT;

  String idLocal;

  double faturamento;

  double ro;

  String idCliente;

  bool sede;

  String idNivel;

  String tipo;

  String idPai;

  int index;

  bool habilitaApontamentoOnline;

  CentroCustoViewModel({
    this.idCentroCusto: "",
    this.nome: "",
    this.nomeReduzido: "",
    this.codigo: "",
    this.cep: "",
    this.logradouro: "",
    this.numero: "",
    this.complemento: "",
    this.bairro: "",
    this.cidade: "",
    this.cidadeReduzido: "",
    this.estado: "",
    this.pais: "",
    this.latitude: "",
    this.longitude: "",
    this.status: "",
    this.telefone: "",
    this.email: "",
    this.idResponsavel: "",
    this.nomeResponsavel: "",
    this.nomeResponsavel1: "",
    this.nomeResponsavel2: "",
    this.nomeResponsavel3: "",
    this.nomeResponsavel4: "",
    this.cargo: "",
    this.observacao: "",
    this.dataAtivacao: "",
    this.dataInativacao: "",
    this.ativarApontamentoOnline: false,
    this.idEmpresa: "",
    this.rT: false,
    this.idLocal: "",
    this.faturamento: 0,
    this.ro: 0,
    this.idCliente: "",
    this.sede: false,
    this.idNivel: "",
    this.tipo: "",
    this.idPai: "",
    this.index: 0,
    this.habilitaApontamentoOnline: false,
  });

  Map toMap() {
    return {
      "idCentroCusto": this.idCentroCusto,
      "nome": this.nome,
      "nomeReduzido": this.nomeReduzido,
      "codigo": this.codigo,
      "cep": this.cep,
      "logradouro": this.logradouro,
      "numero": this.numero,
      "complemento": this.complemento,
      "bairro": this.bairro,
      "cidade": this.cidade,
      "cidadeReduzido": this.cidadeReduzido,
      "estado": this.estado,
      "pais": this.pais,
      "latitud": this.latitude,
      "longitud": this.longitude,
      "status": this.status,
      "telefone": this.telefone,
      "email": this.email,
      "idResponsavel": this.idResponsavel,
      "nomeResponsavel": this.nomeResponsavel,
      "nomeResponsavel1": this.nomeResponsavel1,
      "nomeResponsavel2": this.nomeResponsavel2,
      "nomeResponsavel3": this.nomeResponsavel3,
      "nomeResponsavel4": this.nomeResponsavel4,
      "cargo": this.cargo,
      "observacao": this.observacao,
      "dataAtivaca": this.dataAtivacao,
      "dataInativaca": this.dataInativacao,
      "ativarApontamentoOnline": this.ativarApontamentoOnline,
      "idEmpresa": this.idEmpresa,
      "rT": this.rT,
      "idLocal": this.idLocal,
      "faturamento": this.faturamento,
      "rO": this.ro,
      "idCliente": this.idCliente,
      "sede": this.sede,
      "idNivel": this.idNivel,
      "tipo": this.tipo,
      "idPai": this.idPai,
      "index": this.index,
      "habilitaApontamentoOnline": this.habilitaApontamentoOnline,
    };
  }

  factory CentroCustoViewModel.fromJson(Map<String, dynamic> json) {
    return new CentroCustoViewModel(
      idCentroCusto: json['idCentroCusto'],
      nome: json['nome'],
      nomeReduzido: json['nomeReduzido'],
      codigo: json['codigo'],
      cep: json['cep'],
      logradouro: json['logradouro'],
      numero: json['numero'],
      complemento: json['complemento'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      cidadeReduzido: json['cidadeReduzido'],
      estado: json['estado'],
      pais: json['pais'],
      latitude: json['latitud'],
      longitude: json['longitud'],
      status: json['status'],
      telefone: json['telefone'],
      email: json['email'],
      idResponsavel: json['idResponsavel'],
      nomeResponsavel: json['nomeResponsavel'],
      nomeResponsavel1: json['nomeResponsavel1'],
      nomeResponsavel2: json['nomeResponsavel2'],
      nomeResponsavel3: json['nomeResponsavel3'],
      nomeResponsavel4: json['nomeResponsavel4'],
      cargo: json['cargo'],
      observacao: json['observacao'],
      dataAtivacao: json['dataAtivaca'],
      dataInativacao: json['dataInativaca'],
      ativarApontamentoOnline: json['ativarApontamentoOnline'],
      idEmpresa: json['idEmpresa'],
      rT: json['rT'],
      idLocal: json['idLocal'],
      faturamento: json['faturamento'],
      ro: json['ro'],
      idCliente: json['idCliente'],
      sede: json['sede'],
      idNivel: json['idNivel'],
      tipo: json['tipo'],
      idPai: json['idPai'],
      index: json['index'],
      habilitaApontamentoOnline: json['habilitaApontamentoOnline'],
    );
  }
}
