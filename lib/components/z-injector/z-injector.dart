import 'package:injector/injector.dart';

class ZInjector {
  static void registerDependency<T>(Object instance) {
    if (!Injector.appInstance.exists<T>())
      Injector.appInstance.registerDependency(() => instance, dependencyName: T.runtimeType.toString());
  }

  static T getDependency<T>() {
    return Injector.appInstance.get(dependencyName: T.runtimeType.toString());
  }
}
