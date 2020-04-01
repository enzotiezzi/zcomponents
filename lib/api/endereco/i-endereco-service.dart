import 'package:z_components/view-model/endereco-viewmodel.dart';

abstract class IEnderecoService{
  Future<EnderecoViewModel> buscarEnderecoPorCEP(String cep);
}