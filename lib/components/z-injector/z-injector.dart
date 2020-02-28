import 'package:injector/injector.dart';

class ZInjector {
  static final Injector _injector = Injector.appInstance;

  static void registerDependency<T>(Object instance) {
    if (!_injector.exists(dependencyName: T.toString()))
      _injector.registerDependency<T>((_) => instance);
  }

  static T getDependency<T>() {
    return _injector.getDependency<T>();
  }
}
