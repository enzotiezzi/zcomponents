import 'package:injector/injector.dart';
import 'package:z_components/infra/entities/z-entity.dart';
import 'package:z_components/infra/interfaces/i-context.dart';
import 'package:z_components_example/entities/pessoa.dart';
import 'package:z_components/infra/abstract-repository.dart';
import 'i-pessoa-repository.dart';

class PessoaRepository extends AbstractRepository<Pessoa> implements IPessoaRepository{
  @override
  Future<Pessoa> findById(int id) async{
    var res = await db.queryFirstAsync("SELECT * FROM PESSOA WHERE ID = ?", arguments: [id]);

    return new Pessoa()..fromMap(res);
  }

  @override
  Future<List<Pessoa>> listarPessoas() async{
    var res = await db.queryMultipleAsync("SELECT * FROM PESSOA");

    return res.map((x) => Pessoa()..fromMap(x)).toList();
  }
}