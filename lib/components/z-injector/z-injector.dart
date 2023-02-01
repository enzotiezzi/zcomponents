import 'package:injector/injector.dart';

class ZInjector {
  static void registerDependency<Object>(Object instance) {
    if (!Injector.appInstance.exists<Object>())
      Injector.appInstance.registerDependency<Object>(() => instance);
  }

  static T getDependency<T>() {
    return Injector.appInstance.get<T>();
  }
}
