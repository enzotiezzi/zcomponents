import 'package:z_components/infra/interfaces/i-command.dart';
import 'package:z_components/infra/interfaces/i-query.dart';
import 'package:z_components_example/entities/monstro.dart';

abstract class IMonstroRepository implements ICommand<Monstro>, IQuery<Monstro>{
  
}