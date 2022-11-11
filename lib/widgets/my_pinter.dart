import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  final double circleRaduis;

  MyPainter(this.circleRaduis);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
              colors: [Colors.purple, Colors.deepOrange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)
          .createShader(Rect.fromCircle(
              center: const Offset(0, 0), radius: circleRaduis));

    canvas.drawCircle(const Offset(0, 0), circleRaduis, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDecoration) {
    return child;
  }
}
