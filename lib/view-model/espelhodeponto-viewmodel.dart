import 'apo-batida-detalhe-viewmodel.dart';
import 'batida-viewmodel.dart';
import 'lancamento-ocorrencia-viewmodel.dart';

class ZEspelhoDePontoViewModel {
  List<ZBatidaViewModel>? listaBatidas;
  List<ZLancamentoOcorrenciaViewModel>? listaOcorrencias;
  String? data;
  String? tOuF;
  String? horaEntradaPrevisto;
  String? horaSaidaPrevisto;
  String? horaIntervaloPrevisto;
  APOBatidaDetalheViewModel? batidaDetalhe;

  ZEspelhoDePontoViewModel(
      {this.data,
      this.listaBatidas,
      this.tOuF: "T",
      this.horaEntradaPrevisto: "",
      this.horaSaidaPrevisto: "",
      this.horaIntervaloPrevisto: "",
      this.listaOcorrencias,
      this.batidaDetalhe});
}
