import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class IView<T extends StatefulWidget> {
  final State<T> state;
  bool isInitialized = false;

  IView(this.state);

  Future<void> initView();
  Future<void> afterBuild();

  Future<void> reloadView() async {
    await initView();
  }

  void updateView() {
    state.setState(() {
      isInitialized = true;
    });
  }

  Future<T> navigate(Widget presenter) {
    return Navigator.push(
        state.context, new MaterialPageRoute(builder: (context) => presenter));
  }

  Future<T> navigateReplacement(Widget presenter) {
    return Navigator.pushReplacement(
        state.context, new MaterialPageRoute(builder: (context) => presenter));
  }

  Future<T> navigateNamed(String route) {
    return Navigator.pushNamed(state.context, route);
  }

  Future<T> navigateNamedReplacement(String route) {
    return Navigator.pushReplacementNamed(state.context, route);
  }

  Future<T> navigatorPushNamedAndRemoveUntil(String route, )  {
    return Navigator.pushNamedAndRemoveUntil(state.context,route,
            (Route<dynamic> route) => false);
  }

  void voltar() {
    Navigator.pop(state.context);
  }
}
