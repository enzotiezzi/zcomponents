import 'package:injector/injector.dart';

class ZInjector {
  static void registerDependency<T>(Object instance) {
    if (!Injector.appInstance.exists<T>())
      Injector.appInstance.registerDependency<T>(() => instance);
  }

  static T getDependency<T>() {
    return Injector.appInstance.call<T>();
  }
}
