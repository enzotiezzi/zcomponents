import 'package:flutter_treeview/flutter_treeview.dart';

abstract class ZEstruturaEmpresaActions {
  Future<void> buscarEstruturaEmpresa();
  void selecionarNo(Node node);
  void filtrarEstruturaEmpresa(String nome);
}