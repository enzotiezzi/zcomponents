import 'package:z_components/infra/entities/z-entity.dart';

import 'i-command.dart';

abstract class IContext implements ICommand<ZEntity>{
  Future<Map<String, dynamic>> queryFirstAsync(String query, {List<dynamic> arguments});
  Future<List<Map<String, dynamic>>> queryMultipleAsync(String query, {List<dynamic> arguments});
}