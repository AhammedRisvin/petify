import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Routes {
  // static final key = GlobalKey<NavigatorState>();
  // static final ctx = GlobalKey<ScaffoldMessengerState>();

  static push(
      {required var screen,
      required VoidCallback exit,
      required BuildContext context}) {
    Navigator.of(context)
        .push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 100),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            pageBuilder: (context, animation, secondaryAnimation) {
              return screen;
            },
          ),
        )
        .whenComplete(() => exit());
  }

  static back({required BuildContext context}) {
    Navigator.of(context).pop();
  }

  static pushReplace({required var screen, required BuildContext context}) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 100),
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return screen;
        },
      ),
    );
  }

  static pushRemoveUntil({required var screen, required BuildContext context}) {
    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {

    // },), predicate)
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 100),
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return screen;
        },
      ),
      (route) => true,
      // (route) => false,
    );
  }

  static void pushNamed(coParentDetailScreen) {}
}
