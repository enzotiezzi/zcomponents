
abstract class ICommand<T> {
  Future<int> insert(T entity);

  Future<int> update(T entity);

  Future<int> delete(T entity);
}