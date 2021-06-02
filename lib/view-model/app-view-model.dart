
import 'package:z_components/view-model/modulo-viewmodel.dart';

class AppViewModel {
  String idApp;
  String nome;
  String versao;
  String dataVersao;
  String projectKeyFirebase;
  String idModulo;
  ModuloViewModel modulo;
  String nomeExibicao;

  AppViewModel(
      {
        this.idApp,
        this.nome,
        this.versao,
        this.dataVersao,
        this.projectKeyFirebase,
        this.idModulo,
        this.modulo,
        this.nomeExibicao
      });

  static AppViewModel fromJson(Map<String,dynamic> json){
    return new AppViewModel(
      idApp: json['idApp'],
      nome: json['nome'],
      versao: json['versao'],
      dataVersao: json['dataVersao'],
      projectKeyFirebase: json['projectKeyFirebase'],
      idModulo: json['idModulo'],
      modulo: ModuloViewModel.fromJson(json['modulo']),
      nomeExibicao: json['nomeExibicao']
    );
  }

  Map toMap(){
   return{
    "idApp":this.idApp,
    "nome": this.nome,
    "versao":this.versao,
    "dataVersao":this.dataVersao,
    "projectKeyFirebase":this.projectKeyFirebase,
    "idModulo":this.idModulo,
    "modulo":this.modulo,
    "nomeExibicao":this.nomeExibicao
   };
  }
}