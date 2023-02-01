class ZTreeViewViewModel {
  String? idNivel;
  String? idNivelPai;
  String? nome;
  bool? aberto;
  int? index;
  int? indexAuxiliar;
  bool? jaPassou;
  bool? select;
  int? possiveisBuscas;
  String? caminho;
  List<ZTreeViewViewModel>? filhos = [];

  ZTreeViewViewModel({
    this.nome,
    this.index,
    this.indexAuxiliar,
    this.aberto,
    this.idNivel,
    this.idNivelPai,
    this.jaPassou,
    this.filhos,
    this.possiveisBuscas,
    this.caminho,
    this.select: false,
  });

  ZTreeViewViewModel.clone(ZTreeViewViewModel source)
      : this.idNivel = source.idNivel,
        this.nome = source.nome,
        this.idNivelPai = source.idNivelPai,
        this.filhos = source.filhos
            ?.map((item) => new ZTreeViewViewModel.clone(item))
            .toList(),
        this.aberto = source.aberto,
        this.jaPassou = source.jaPassou,
        this.select = source.select,
        this.index = source.index,
        this.indexAuxiliar = source.indexAuxiliar;
}
