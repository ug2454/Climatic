import 'package:flutter/widgets.dart';

class NumberLoadingAnimation {
  AnimationController controller;

  AnimationController animationController(
      {TickerProvider obj, double upperBoundValue}) {
    controller = AnimationController(
      vsync: obj,
      duration: Duration(seconds: 1),
      upperBound: upperBoundValue,
    );
    return controller;
  }
}
