import 'package:z_components/infra/entities/z-entity.dart';

abstract class IQuery<T>{
  Future<T> findById(int id);
}