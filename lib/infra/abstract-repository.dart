import 'package:injector/injector.dart';
import 'package:z_components/infra/entities/z-entity.dart';
import 'package:z_components/infra/interfaces/i-command.dart';

import 'interfaces/i-context.dart';

class AbstractRepository<T extends ZEntity> implements ICommand<T> {
  IContext _context = Injector.appInstance.getDependency<IContext>();

  @override
  Future<int> delete(T entity) {
    return _context.delete(entity);
  }

  @override
  Future<int> insert(T entity) {
    return _context.insert(entity);
  }

  @override
  Future<int> update(T entity) {
    return _context.update(entity);
  }
}