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

  Future<T> navigate<T>(Widget presenter) {
    return Navigator.push(
        state.context, PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return presenter;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return  SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: new SlideTransition(
            position: new Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(1.0, 0.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
      },
    ));
  }

  Future<T> navigateSale<T>(Widget presenter) {
    return Navigator.push(
        state.context, PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return presenter;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: child,
        );
      },
    ));
  }

  Future<T> navigateSize<T>(Widget presenter) {
    return Navigator.push(
        state.context, PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return presenter;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return Align(
          child: SizeTransition(
            sizeFactor: animation,
            child: child,
          ),
        );
      },
    ));
  }

  Future<T> navigateFade<T>(Widget presenter) {
    return Navigator.push(
        state.context, PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return presenter;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ));
  }

  Future<T> navigateReplacement<T>(Widget presenter) {
    return Navigator.pushReplacement(
        state.context, PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return presenter;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return  SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: new SlideTransition(
            position: new Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(1.0, 0.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
      },
    ));
  }

  Future<T> navigateNamed<T>(String route) {
    return Navigator.pushNamed(state.context, route);
  }

  Future<T> navigateNamedReplacement<T>(String route) {
    return Navigator.pushReplacementNamed(state.context, route);
  }

  Future<T> navigatorPushNamedAndRemoveUntil<T>(String route, )  {
    return Navigator.pushNamedAndRemoveUntil(state.context,route,
            (Route<dynamic> route) => false);
  }

  void voltar() {
    Navigator.pop(state.context);
  }
}
