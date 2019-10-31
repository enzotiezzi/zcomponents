
abstract class IQuery<T>{
  Future<T> findById(int id);
}