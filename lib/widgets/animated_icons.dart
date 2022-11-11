import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/auth_screen.dart';
import 'auth_card.dart';

class animatedIcons extends StatelessWidget {
  const animatedIcons({
    Key? key,
    required this.size,
    required this.animation1,
    required this.animation3,
    required this.animation2,
  }) : super(key: key);

  final Size size;
  final Animation<double> animation1;
  final Animation<double> animation3;
  final Animation<double> animation2;

  @override
  Widget build(BuildContext context) {
    const svgColor = 0xFFCE28AD;
    ;
    return Stack(children: [
      //

      Positioned(
        top: size.height * (animation1.value),
        left: size.width * (animation1.value) - 30,
        // bottom: .20,
        child: SvgPicture.asset(
          "assets/svgs/asset1.svg",
          color: Color(svgColor),
          height: 60,
        ),
      ),

      Positioned(
        top: size.height * (animation1.value * 2.3),
        left: size.width * (animation1.value) - 30,
        //bottom: .20,
        child: SvgPicture.asset(
          "assets/svgs/Asset 2.svg",
          color: Color(svgColor),
          height: 55,
        ),
      ),

      Positioned(
        top: size.height * (animation1.value * 4.32),
        left: size.width * (animation1.value) - 30,
        //bottom: .20,
        child: SvgPicture.asset(
          "assets/svgs/Asset 3.svg",
          color: Color(svgColor),
          height: 45,
        ),
      ),

      Positioned(
        top: size.height * (animation1.value * 6.3),
        left: size.width * (animation1.value) - 30,
        //    bottom: .20,
        child: SvgPicture.asset(
          "assets/svgs/Asset 13.svg",
          color: Color(svgColor),
          height: 50,
        ),
      ),

////
//////
//////
      ///
      ///
      ///
//

      Positioned(
        top: size.height * (animation1.value * 1.5),
        left: size.width * (animation3.value * 0.4) + 105,
        // bottom: .20,
        child: SvgPicture.asset(
          "assets/svgs/Asset 12.svg",
          color: Color(svgColor),
          height: 60,
        ),
      ),

      Positioned(
        top: size.height * (animation1.value * 3.2),
        left: size.width * (animation3.value * 0.4) + 105,
        //bottom: .20,
        child: SvgPicture.asset(
          "assets/svgs/Asset 10.svg",
          color: Color(svgColor),
          height: 60,
        ),
      ),

      Positioned(
        top: size.height * (animation1.value * 5.5),
        left: size.width * (animation3.value * 0.4) + 105,
        //bottom: .20,
        child: SvgPicture.asset(
          "assets/svgs/Asset 11.svg",
          color: Color(svgColor),
          height: 60,
        ),
      ),

      Positioned(
        top: size.height * (animation1.value * 7.5),
        left: size.width * (animation3.value * 0.4) + 105,
        //    bottom: .20,
        child: SvgPicture.asset(
          "assets/svgs/Asset 9.svg",
          color: Color(svgColor),
          height: 60,
        ),
      ),
      //
      //

      //

      Positioned(
        top: size.height * animation1.value,
        left: size.width * (animation2.value * 0.6) + size.width - 170,
        // bottom: .20,
        child: SvgPicture.asset(
          "assets/svgs/Asset 4.svg",
          color: Color(svgColor),
          height: 50,
        ),
      ),

      Positioned(
        top: size.height * (animation1.value * 2.3),
        left: size.width * (animation2.value * 0.6) + size.width - 155,
        //bottom: .20,
        child: SvgPicture.asset(
          "assets/svgs/Asset 14.svg",
          color: Color(svgColor),
          height: 60,
        ),
      ),

      Positioned(
        top: size.height * (animation1.value * 4.3),
        left: size.width * (animation2.value * 0.6) + size.width - 150,
        //bottom: .20,
        child: SvgPicture.asset(
          "assets/svgs/Asset 15.svg",
          color: Color(svgColor),
          height: 50,
        ),
      ),

      Positioned(
        top: size.height * (animation1.value * 6.3),
        left: size.width * (animation2.value * 0.6) + size.width - 170,
        //    bottom: .20,
        child: SvgPicture.asset(
          "assets/svgs/Asset 16.svg",
          color: Color(svgColor),
          height: 50,
        ),
      ),
      // SvgPicture.asset("assets/svgs/asset1.svg",
      //     color: Colors.pink),
      // child: Image.asset(
      //   "assets/images/Rainy-Copy.jpg",
      //   fit: BoxFit.cover,
      // ),

      //
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: AuthCard(),
      )

      //
    ]);
  }
}
