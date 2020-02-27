import 'package:injector/injector.dart';
import 'package:z_components/components/z-injector/z-injector.dart';
import 'package:z_components/infra/entities/z-entity.dart';
import 'package:z_components/infra/interfaces/i-command.dart';

import 'interfaces/i-context.dart';

class AbstractRepository<T extends ZEntity> implements ICommand<T> {
  IContext db = ZInjector.getDependency<IContext>();

  @override
  Future<int> delete(T entity) {
    return db.delete(entity);
  }

  @override
  Future<int> insert(T entity) {
    return db.insert(entity);
  }

  @override
  Future<int> update(T entity) {
    return db.update(entity);
  }
}
