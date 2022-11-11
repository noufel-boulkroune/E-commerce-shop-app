import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/http_exception.dart';
import 'package:shop_app/widgets/animated_circles.dart';

import '../providers/auth.dart';
import '../widgets/animated_icons.dart';
import '../widgets/custom_button.dart';
import '../widgets/my_pinter.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late AnimationController controller1;
  late AnimationController controller2;

  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;

  @override
  void initState() {
    controller1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

//

    animation1 = Tween<double>(begin: 0.15, end: 0.1).animate(
      CurvedAnimation(parent: controller1, curve: Curves.easeInOut),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });

//

    animation2 = Tween<double>(begin: 0.3, end: 0.4).animate(
      CurvedAnimation(parent: controller1, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() {});
      });

//

    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

//

    animation3 = Tween<double>(begin: 0.41, end: 0.38).animate(
      CurvedAnimation(parent: controller2, curve: Curves.easeInOut),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });

//

    animation4 = Tween<double>(begin: 170, end: 190).animate(
      CurvedAnimation(parent: controller2, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() {});
      });

//

    Timer(const Duration(microseconds: 2500), () {
      controller1.forward();
    });

    controller2.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  //

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xff192028),
        body: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: SizedBox(
                height: size.height,
                child: animatedIcons(
                  size: size,
                  animation1: animation1,
                  animation3: animation3,
                  animation2: animation2,
                ),
                // child: animatedCirles(
                //     size: size,
                //     animation1: animation1,
                //     animation3: animation3,
                //     animation2: animation2,
                //     animation4: animation4),
              ),
            )));
  }
}

//

//
