import 'package:flutter/material.dart';
import 'package:hive_app/home.dart';

class ScaleRoute extends PageRouteBuilder {
  List<Color> colors = [
    const Color(0xFFF7D8BA), //
    const Color(0xFFACDDDE), //

    const Color(0xFFE1BEE7), //

    const Color(0xFFCFD8DC), //
    const Color(0xFF607D8B), //
    const Color(0xFFFFFF8D), //
    const Color(0xFFFFCDD2), // red
    const Color(0xFFCE93D8), // purple
    const Color(0xFFC5CAE9), // indigo
    const Color(0xFFBBDEFB), // blue
    const Color(0xFFB2EBF2), // cyan
    const Color(0xFFB2DFDB), // teal
    const Color(0xFFE8F5E9), // green
    const Color(0xFFF0F4C3), // lime
    const Color(0xFFFFF176), // yellow
    const Color(0xFFFFB74D), // orange
    const Color(0xFF90A4AE), // blue  grey
    const Color(0xFFFF8A65), // deep orange
    const Color(0xFFff5733),
    const Color(0xFFffbd33),

    const Color(0xFF33ffbd),
  ];
  final Widget page;
  ScaleRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
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
          ),
        );
}
