import 'dart:ui';

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.voidCallback, required this.buttonString});
  final Function voidCallback;
  final String buttonString;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: (() => voidCallback()),
          child: Container(
            height: size.width / 8,
            width: size.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.pink.withOpacity(.15),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              buttonString,
              style:
                  TextStyle(color: Colors.white.withOpacity(.8), fontSize: 19),
            ),
          ),
        ),
      ),
    );
  }
}
