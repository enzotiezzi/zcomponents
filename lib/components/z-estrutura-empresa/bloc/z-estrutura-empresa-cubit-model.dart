import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:z_components/api/z-estrutura-empresa/nivel.dart';

class ZEstruturaEmpresaCubitModel {
  List<Node>? nodes;
  List<Nivel>? niveis;
  Node? selectedNode;
  bool? isLoading;

  ZEstruturaEmpresaCubitModel(
      {this.nodes, this.selectedNode, this.niveis, this.isLoading});

  ZEstruturaEmpresaCubitModel patchState(
      {List<Node>? nodes,
      Node? selectedNode,
      List<Nivel>? niveis,
      bool? isLoading}) {
    return new ZEstruturaEmpresaCubitModel(
      isLoading: isLoading ?? this.isLoading,
      niveis: niveis ?? this.niveis,
      nodes: nodes ?? this.nodes,
      selectedNode: selectedNode ?? this.selectedNode
    );
  }
}
