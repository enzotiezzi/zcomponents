import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:z_components/api/z-estrutura-empresa/nivel.dart';

abstract class ZEstruturaEmpresaActions {
  Future<void> buscarEstruturaEmpresa(String token);
  void selecionarNo(Node node);
  void filtrarEstruturaEmpresa(String nome);
  void adicionarNivel(Nivel nivel);
}