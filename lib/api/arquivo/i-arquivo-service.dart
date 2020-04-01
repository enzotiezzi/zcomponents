import 'package:z_components/view-model/arquivo-viewmodel.dart';
import 'package:z_components/view-model/foto-detalhe-viewmodel.dart';

abstract class IArquivoService{
  Future<String> enviarImagem(ArquivoViewModel arquivoViewModel);

  Future<FotoDetalheViewModel> buscarAnexo(String idAnexo);
}