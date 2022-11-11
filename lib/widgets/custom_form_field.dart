import 'dart:ui';

import 'package:flutter/material.dart';

enum AuthMode { Signup, Login }

class CustomFormFeild extends StatefulWidget {
  const CustomFormFeild(
      {super.key,
      required this.context,
      required this.icon,
      required this.hintText,
      required this.isPassword,
      required this.isEmail});
  final BuildContext context;
  final IconData icon;
  final String hintText;
  final bool isPassword;
  final bool isEmail;

  @override
  State<CustomFormFeild> createState() => _CustomFormFeildState();
}

class _CustomFormFeildState extends State<CustomFormFeild> {
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  Map<String, String> get authData {
    return {..._authData};
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 15,
          sigmaX: 15,
        ),
        child: Container(
          height: size.width / 6,
          width: size.width / 1,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: size.width / 30),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.05),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextFormField(
            validator: widget.isEmail
                ? (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  }
                : (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
            onSaved: widget.isEmail
                ? (value) {
                    _authData['email'] = value!;
                  }
                : (value) {
                    _authData['password'] = value!;
                  },
            style: TextStyle(color: Colors.white.withOpacity(.8)),
            cursorColor: Colors.white,
            obscureText: widget.isPassword,
            keyboardType: widget.isEmail
                ? TextInputType.emailAddress
                : TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                widget.icon,
                color: Colors.white.withOpacity(.7),
              ),
              border: InputBorder.none,
              hintMaxLines: 1,
              hintText: widget.hintText,
              hintStyle:
                  TextStyle(fontSize: 14, color: Colors.white.withOpacity(.5)),
            ),
          ),
        ),
      ),
    );
  }
}
