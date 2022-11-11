import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/auth_screen.dart';
import 'auth_card.dart';
import 'my_pinter.dart';

class animatedCirles extends StatelessWidget {
  const animatedCirles({
    Key? key,
    required this.size,
    required this.animation1,
    required this.animation3,
    required this.animation2,
    required this.animation4,
  }) : super(key: key);

  final Size size;
  final Animation<double> animation1;
  final Animation<double> animation3;
  final Animation<double> animation2;
  final Animation<double> animation4;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: size.height * (animation1.value + 0.52),
        left: size.width * .21,
        bottom: .20,
        child: CustomPaint(
          painter: MyPainter(50),
        ),
      ),

      Positioned(
        top: size.height * 0.98,
        left: size.width * .1,
        bottom: .20,
        child: CustomPaint(
          painter: MyPainter(animation4.value - 30),
        ),
      ),

      Positioned(
        top: size.height * 0.5,
        left: size.width * (animation2.value + 0.4),
        bottom: .20,
        child: CustomPaint(
          painter: MyPainter(30),
        ),
      ),

      Positioned(
        top: size.height * animation3.value,
        left: size.width * (animation1.value + 0.1),
        bottom: .20,
        child: CustomPaint(
          painter: MyPainter(70),
        ),
      ),

      Positioned(
        top: size.height * .1,
        left: size.width * 0.8,
        bottom: .20,
        child: CustomPaint(
          painter: MyPainter(animation4.value * 0.9),
        ),
      ),

      //
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: AuthCard(),
      )

      //
    ]);
  }
}
