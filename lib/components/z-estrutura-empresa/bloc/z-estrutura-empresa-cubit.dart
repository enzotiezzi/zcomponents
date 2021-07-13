import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:z_components/api/z-estrutura-empresa/i-estrutura-epresa-service.dart';
import 'package:z_components/api/z-estrutura-empresa/nivel.dart';
import 'package:z_components/api/z-estrutura-empresa/z-estrutura-empresa-service.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/z-estrutura-empresa/bloc/z-estrutura-emprersa-actions.dart';
import 'package:z_components/components/z-estrutura-empresa/bloc/z-estrutura-empresa-cubit-model.dart';

class ZEstruturaEmpresaCubit extends Cubit<ZEstruturaEmpresaCubitModel>
    implements ZEstruturaEmpresaActions {
  final String token;

  TreeViewController _treeViewController;

  IEstruturaEmpresaService _estruturaEmpresaService;

  TreeViewController get treeViewController => _treeViewController;

  ZEstruturaEmpresaCubit({@required this.token})
      : super(new ZEstruturaEmpresaCubitModel(nodes: [], selectedNode: null)) {
    _estruturaEmpresaService = new EstruturaEmpresaService(token);

    _treeViewController = new TreeViewController(children: []);
  }

  @override
  Future<void> buscarEstruturaEmpresa() async {
    var res = await _estruturaEmpresaService.listarNiveis(new SearchOptions());

    if (res != null) {
      var niveis = res.body;
      List<Node<Nivel>> nodes = [];

      _depthConvertion(null, niveis, nodes);

      _treeViewController = new TreeViewController(children: nodes);

      emit(new ZEstruturaEmpresaCubitModel(
        nodes: nodes,
        selectedNode: state.selectedNode
      ));
    }
  }

  void _depthConvertion(
      Node parent, List<Nivel> niveis, List<Node<Nivel>> nodes) {
    for (var i = 0; i < niveis.length; i++) {
      var nivel = niveis[i];

      var node =
          new Node<Nivel>(key: nivel.idNivel, label: nivel.nome, data: nivel, children: []);

      if(parent != null)
        parent.children.add(node);
      else
        nodes.add(node);

      _depthConvertion(node, nivel.niveis, nodes);
    }
  }

  @override
  void selecionarNo(Node node) {
    emit(new ZEstruturaEmpresaCubitModel(
      nodes: state.nodes,
      selectedNode: node
    ));
  }
}
