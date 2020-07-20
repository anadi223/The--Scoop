import 'package:flutter/cupertino.dart';

class AnimationController {
  var duration;
  var debugLabel;
  var lowerBound;
  var upperBound;

  AnimationController({
    double value,
    this.duration,
    this.debugLabel,
    this.lowerBound: 0.0,
    this.upperBound: 1.0,
    @required TickerProvider vsync,
  });
}