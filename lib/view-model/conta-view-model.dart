import 'package:flutter/material.dart';
import 'package:z_components/styles/main-style.dart';

class ContaViewModel {
  String? idConta;
  String? nome;
  String? nomeFantasia;
  Color? corPrimaria;
  Color? corSecundaria;
  String? logo;
  bool? ativo;

  ContaViewModel(
      {this.idConta,
      this.nome,
      this.nomeFantasia,
      this.ativo,
      this.corPrimaria,
      this.corSecundaria,
      this.logo});

  factory ContaViewModel.fromJson(Map<String, dynamic> json) {
    return new ContaViewModel(
        idConta: json["idConta"],
        nome: json["nome"],
        nomeFantasia: json["nomeFantasia"],
        ativo: json["ativo"],
        corPrimaria: json["corPrimaria"] != null ? MainStyle.hexToColor(json["corPrimaria"]) : new Color(0xFF2BBAB4),
        corSecundaria:json["corSecundaria"]  != null ? MainStyle.hexToColor(json["corSecundaria"]) : new Color(0xFF801F92),
        logo: json["logo"]);
  }
}
