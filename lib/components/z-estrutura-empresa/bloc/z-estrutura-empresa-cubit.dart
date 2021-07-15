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
  TextEditingController _searchTextController = new TextEditingController();

  IEstruturaEmpresaService _estruturaEmpresaService;

  TreeViewController get treeViewController => _treeViewController;

  TextEditingController get searchTextController => _searchTextController;

  ZEstruturaEmpresaCubit({@required this.token})
      : super(new ZEstruturaEmpresaCubitModel(
            nodes: [], selectedNode: null, niveis: [])) {
    _estruturaEmpresaService = new EstruturaEmpresaService(token);

    _treeViewController = new TreeViewController(children: []);
  }

  @override
  Future<void> buscarEstruturaEmpresa() async {
    var searchOptions = new SearchOptions();

    searchOptions.orders
        .add(new OrderByExpression(propertyName: "Nome", orientation: "ASC"));

    var res = await _estruturaEmpresaService.listarNiveis(searchOptions);

    if (res != null) {
      var niveis = res.body;
      List<Node<Nivel>> nodes = [];

      _depthConvertion(null, niveis, nodes);

      _treeViewController = new TreeViewController(children: nodes);

      emit(new ZEstruturaEmpresaCubitModel(
          nodes: nodes, selectedNode: state.selectedNode, niveis: niveis));
    }
  }

  void _depthConvertion(
      Node parent, List<Nivel> niveis, List<Node<Nivel>> nodes) {
    for (var i = 0; i < niveis.length; i++) {
      var nivel = niveis[i];

      var node = new Node<Nivel>(
          key: nivel.idNivel, label: nivel.nome, data: nivel, children: []);

      if (parent != null)
        parent.children.add(node);
      else
        nodes.add(node);

      _depthConvertion(node, nivel.niveis, nodes);
    }
  }

  void _depthSearch(
      Node parent, List<Nivel> niveis, List<Node<Nivel>> nodes, String filter) {
    for (var i = 0; i < niveis.length; i++) {
      var nivel = niveis[i];

      found = false;
      _depthFilterSearch(filter, nivel);

      var node = new Node<Nivel>(
          key: nivel.idNivel, label: nivel.nome, data: nivel, children: []);

      if (nivel.nome.toLowerCase().contains(filter.toLowerCase()) ||
          found) {
        if (parent != null)
          parent.children.add(node);
        else
          nodes.add(node);
      }

      _depthSearch(node, nivel.niveis, nodes, filter);
    }
  }

  bool found = false;
  void _depthFilterSearch(String filter, Nivel nivel) {
    if (nivel.nome.toLowerCase().contains(filter.toLowerCase())) found = true;

    if (!found) {
      for (var i = 0; i < nivel.niveis.length; i++) {
        var nivelAtual = nivel.niveis[i];

        _depthFilterSearch(filter, nivelAtual);
      }
    }
  }

  @override
  void selecionarNo(Node node) {
    emit(new ZEstruturaEmpresaCubitModel(
        nodes: state.nodes, selectedNode: node, niveis: state.niveis));
  }

  @override
  void filtrarEstruturaEmpresa(String nome) {
    List<Node<Nivel>> nodes = [];

    _depthSearch(null, state.niveis, nodes, nome);

    _treeViewController = new TreeViewController(children: nodes);

    emit(new ZEstruturaEmpresaCubitModel(
        selectedNode: state.selectedNode, niveis: state.niveis, nodes: nodes));
  }
}
