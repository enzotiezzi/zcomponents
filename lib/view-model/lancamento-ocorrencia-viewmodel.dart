import 'package:z_components/infra/db/database-utils.dart';
import 'package:z_components/infra/entities/z-entity.dart';
import 'package:z_components/infra/schema/z-column.dart';
import 'package:z_components/infra/schema/z-table.dart';

class ZLancamentoOcorrenciaViewModel {
  String idLancamento;
  String idOcorrencia;
  String nomeOcorrencia;
  String nomeJustificativa;
  String detalheJustificativa;
  String abreviacao;
  String dataOcorrencia;
  bool automatica;

  ZLancamentoOcorrenciaViewModel(
      {this.idLancamento: "",
      this.idOcorrencia: "",
      this.nomeOcorrencia: "",
      this.nomeJustificativa: "",
      this.detalheJustificativa: "",
      this.abreviacao: "",
      this.dataOcorrencia: "",
      this.automatica: false,
    });
}
