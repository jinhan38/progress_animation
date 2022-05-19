import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_animation/progress_interface.dart';
import 'dart:math';

import 'package:visibility_detector/visibility_detector.dart';

class CircleProgressWrap extends StatefulWidget {
  Function(ProgressInterface interface) interface;
  Duration duration;
  Widget Function(int progress) progressValue;
  double radius;
  Color circleBaseColor;
  Color circleProgressColor;
  double begin;
  double end;
  double baseStroke;
  double progressStroke;

  CircleProgressWrap({
    required this.interface,
    required this.duration,
    required this.progressValue,
    required this.radius,
    required this.circleBaseColor,
    required this.circleProgressColor,
    required this.begin,
    required this.end,
    required this.baseStroke,
    required this.progressStroke,
    Key? key,
  }) : super(key: key);

  @override
  _CircleProgressWrapState createState() => _CircleProgressWrapState();
}

class _CircleProgressWrapState extends State<CircleProgressWrap>
    with SingleTickerProviderStateMixin, ProgressInterface {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    widget.interface(this);
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: widget.begin, end: widget.end)
        .chain(CurveTween(curve: Curves.decelerate))
        .animate(_animationController);
    _animation.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  start() {
    if (!_animationController.isAnimating && _animationController.value < 100) {
      _animationController.forward();
    }
  }

  @override
  stop() {
    try {
      _animationController.reset();
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    try {
      _animationController.dispose();
    } catch (e) {
      print(e);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.radius * 2 + widget.progressStroke,
      height: widget.radius * 2 + widget.progressStroke,
      child: Center(
        child: CustomPaint(
          foregroundPainter: CircleProgress(
            currentProgress: _animation.value,
            radius: widget.radius,
            circleBaseColor: widget.circleBaseColor,
            circleProgressColor: widget.circleProgressColor,
            baseStroke: widget.baseStroke,
            progressStroke:  widget.progressStroke,
          ),
          child: Center(child: widget.progressValue(_animation.value.round())),
        ),
      ),
    );
  }
}

class CircleProgress extends CustomPainter {
  double currentProgress;
  double radius;
  Color circleBaseColor;
  Color circleProgressColor;
  double baseStroke;
  double progressStroke;

  CircleProgress({
    required this.currentProgress,
    required this.radius,
    required this.circleBaseColor,
    required this.circleProgressColor,
    required this.baseStroke,
    required this.progressStroke,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint circle = Paint();
    circle.strokeWidth = baseStroke;
    circle.color = circleBaseColor;
    circle.style = PaintingStyle.stroke;

    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, circle);
    Paint animationArc = Paint()
      ..strokeWidth = progressStroke
      ..style = PaintingStyle.stroke
      ..color = circleProgressColor
      ..strokeCap = StrokeCap.round;

    double angle = 2 * pi * (currentProgress / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi / 2,
      angle,
      false,
      animationArc,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
