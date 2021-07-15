import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:z_components/api/z-estrutura-empresa/nivel.dart';

class ZEstruturaEmpresaCubitModel{
  List<Node> nodes;
  List<Nivel> niveis;
  Node selectedNode;

  ZEstruturaEmpresaCubitModel({this.nodes, this.selectedNode, this.niveis});
}