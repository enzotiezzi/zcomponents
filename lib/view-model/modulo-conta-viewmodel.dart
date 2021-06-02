
import 'package:z_components/view-model/modulo-viewmodel.dart';

class ModuloContaViewModel {
  String idModulo;
  String dataVinculo;
  String dataInativacao;
  bool ativo;
  String status;
  ModuloViewModel modulo;
  String idConta;


  ModuloContaViewModel({
    this.idModulo,
    this.dataVinculo,
    this.dataInativacao,
    this.ativo,
    this.status,
    this.modulo,
    this.idConta
  });

  static  ModuloContaViewModel fromJson(Map<String, dynamic> json) {
    return new ModuloContaViewModel(
      idModulo: json["idModulo"],
      dataVinculo: json["dataVinculo"],
      dataInativacao: json["dataInativacao"],
      ativo: json["ativo"],
      status: json["status"],
      modulo:  ModuloViewModel.fromJson(json['modulo'])
    );
  }

  Map toMap(){
    return {
      "idModulo":this.idModulo,
      "dataVinculo":this.dataVinculo,
      "dataInativacao":this.dataInativacao,
      "status":this.status,
      "ativo":this.ativo,
      "moduloViewModel" :this.modulo
    };
  }
}

