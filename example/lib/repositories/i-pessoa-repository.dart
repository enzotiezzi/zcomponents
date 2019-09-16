import 'package:z_components/infra/interfaces/i-command.dart';
import 'package:z_components/infra/interfaces/i-query.dart';
import 'package:z_components_example/entities/pessoa.dart';

abstract class IPessoaRepository implements ICommand<Pessoa>, IQuery<Pessoa>{
  Future<List<Pessoa>> listarPessoas();
}