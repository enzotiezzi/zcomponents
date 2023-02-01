import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:z_components/api/z-estrutura-empresa/i-estrutura-epresa-service.dart';
import 'package:z_components/api/z-estrutura-empresa/nivel.dart';
import 'package:z_components/api/z-estrutura-empresa/z-estrutura-empresa-service.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/z-estrutura-empresa/bloc/z-estrutura-emprersa-actions.dart';
import 'package:z_components/components/z-estrutura-empresa/bloc/z-estrutura-empresa-cubit-model.dart';

class ZEstruturaEmpresaCubit extends Cubit<ZEstruturaEmpresaCubitModel>
    implements ZEstruturaEmpresaActions {
  bool carregou = false;

  late TreeViewController _treeViewController;
  TextEditingController _searchTextController = new TextEditingController();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  late IEstruturaEmpresaService _estruturaEmpresaService;

  TreeViewController get treeViewController => _treeViewController;

  TextEditingController get searchTextController => _searchTextController;

  Node? get selectedNode => state.selectedNode;

  ZEstruturaEmpresaCubit()
      : super(new ZEstruturaEmpresaCubitModel(
            nodes: [], selectedNode: null, niveis: [], isLoading: true)) {
    _treeViewController = new TreeViewController(children: []);
  }

  @override
  Future<void> buscarEstruturaEmpresa(String token) async {
    carregou = true;
    var searchOptions = new SearchOptions();

    searchOptions.orders
        ?.add(new OrderByExpression(propertyName: "Nome", orientation: "ASC"));

    emit(state.patchState(isLoading: true));
    _estruturaEmpresaService = new EstruturaEmpresaService(token);

    var res = await _estruturaEmpresaService.listarNiveis(searchOptions);

    emit(state.patchState(isLoading: false));

    if (res != null) {
      var niveis = res.body;

      List<Node<Nivel>> nodes = [];

      _depthConvertion(null, niveis!, nodes);

      _treeViewController = new TreeViewController(children: nodes);

      emit(state.patchState(
          nodes: nodes,
          selectedNode: state.selectedNode,
          niveis: niveis,
          isLoading: false));
    }
  }

  void _depthConvertion(
      Node? parent, List<Nivel> niveis, List<Node<Nivel>> nodes) {
    for (var i = 0; i < niveis.length; i++) {
      var nivel = niveis[i];

      var node = new Node<Nivel>(
          key: nivel.idNivel!, label: nivel.nome!, data: nivel, children: []);

      if (parent != null)
        parent.children.add(node);
      else
        nodes.add(node);

      _depthConvertion(node, nivel.niveis!, nodes);
    }
  }

  void _depthSearch(
      Node? parent, List<Nivel> niveis, List<Node<Nivel>> nodes, String filter) {
    for (var i = 0; i < niveis.length; i++) {
      var nivel = niveis[i];

      foundNodeInDepth = false;
      _depthFilterSearch(filter, nivel.niveis!);

      var node = new Node<Nivel>(
          key: nivel.idNivel!,
          label: nivel.nome!,
          data: nivel,
          children: [],
          expanded: true);

      if (nivel.nome!.toLowerCase().contains(filter.toLowerCase()) &&
          !foundNodeInDepth) {
        _adicionarNiveisAoNo(node, nivel.niveis!);

        if (parent != null)
          parent.children.add(node);
        else
          nodes.add(node);
      } else {
        if (nivel.nome!.toLowerCase().contains(filter.toLowerCase()) ||
            foundNodeInDepth) {
          if (parent != null)
            parent.children.add(node);
          else
            nodes.add(node);
        }
      }

      _depthSearch(node, nivel.niveis!, nodes, filter);
    }
  }

  bool foundNodeInDepth = false;

  void _depthFilterSearch(String filter, List<Nivel> niveis) {
    if (!foundNodeInDepth) {
      for (var i = 0; i < niveis.length; i++) {
        var nivelAtual = niveis[i];

        if (nivelAtual.nome!.toLowerCase().contains(filter.toLowerCase()))
          foundNodeInDepth = true;

        _depthFilterSearch(filter, nivelAtual.niveis!);
      }
    }
  }

  @override
  void selecionarNo(Node node) {
    emit(state.patchState(
      selectedNode: node,
    ));
  }

  @override
  void filtrarEstruturaEmpresa(String nome) {
    List<Node<Nivel>> nodes = [];

    _depthSearch(null, state.niveis!, nodes, nome);

    _treeViewController = new TreeViewController(children: nodes);

    emit(state.patchState(
        selectedNode: state.selectedNode,
        niveis: state.niveis,
        nodes: nodes,
        isLoading: false));
  }

  Future<Null> refresh(String token) async {
    await buscarEstruturaEmpresa(token);

    Future.delayed(new Duration(milliseconds: 1500), () {
      refreshController.refreshCompleted();
    });
    emit(state);
  }

  @override
  void adicionarNivel(Nivel nivel) {
    _adicionarNivelFilho(nivel, state.selectedNode!.data as Nivel, state.niveis!);

    emit(state.patchState(niveis: state.niveis));
    filtrarEstruturaEmpresa(state.selectedNode!.label);
  }

  void _adicionarNivelFilho(
      Nivel nivelFilho, Nivel nivelPai, List<Nivel> niveis) {
    for (var i = 0; i < niveis.length; i++) {
      var nivel = niveis[i];

      if (nivel.idNivel == nivelPai.idNivel) {
        nivelPai.niveis?.add(nivelFilho);
        searchTextController.text = nivelFilho.nome!;
      } else {
        _adicionarNivelFilho(nivelFilho, nivelPai, nivel.niveis!);
      }
    }
  }

  void _adicionarNiveisAoNo(Node<Nivel> parentNode, List<Nivel> niveis) {
    for (var i = 0; i < niveis.length; i++) {
      var nivel = niveis[i];

      var node = new Node<Nivel>(
          key: nivel.idNivel!,
          label: nivel.nome!,
          data: nivel,
          children: [],
          expanded: true);

      parentNode.children.add(node);

      _adicionarNiveisAoNo(node, nivel.niveis!);
    }
  }
}