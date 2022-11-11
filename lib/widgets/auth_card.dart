import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/custom_button.dart';

import '../models/http_exception.dart';
import '../providers/auth.dart';
import '../screens/auth_screen.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();

  // late final Animation<double> _opacityAnimation;
  // late final AnimationController _controller;
  // var containerHeight;

  @override
//  void initState() {
  //   super.initState();
  //   _controller =
  //      AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  //  _opacityAnimation = Tween(
  //     begin: 0,
  //     end: 1,
//).animate(_controller) as Animation<double>;
  // _opacityAnimation.addListener(() {
  //   setState(() {});
  // });
//  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
//}

  AuthMode _authMode = AuthMode.Login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _showErrorDialog(String errorMessage) {
    showDialog(
        barrierColor: Colors.white.withOpacity(0.3),
        context: context,
        builder: ((context) {
          return AlertDialog(
            backgroundColor: Colors.black.withOpacity(0.8),
            title: Text(
              "Autontication filed",
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              errorMessage,
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          );
        }));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        // Log user in

        await Provider.of<Auth>(context, listen: false)
            .login(_authData["email"]!, _authData["password"]!);
      } else {
        // Sign user up

        await Provider.of<Auth>(context, listen: false)
            .signup(_authData["email"]!, _authData["password"]!, true);
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      // _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      // _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //

          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.only(top: size.height * .1),
              child: Text(
                "MyShop",
                style: TextStyle(
                  color: Colors.white.withOpacity(.7),
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  wordSpacing: 4,
                ),
              ),
            ),
          ),

          //

          ClipRRect(
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
                  color: Colors.pink.withOpacity(.15),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                  style: TextStyle(color: Colors.white.withOpacity(.8)),
                  cursorColor: Colors.white,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                      top: 15,
                      left: 40,
                    ),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.white.withOpacity(.7),
                    ),
                    border: InputBorder.none,
                    hintMaxLines: 1,
                    hintText: "E-Mail",
                    hintStyle: TextStyle(
                        fontSize: 14, color: Colors.white.withOpacity(.5)),
                  ),
                ),
              ),
            ),
          ),

          //

          const SizedBox(
            height: 20,
          ),

          //

          ClipRRect(
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
                  color: Colors.pink.withOpacity(.15),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                  style: TextStyle(color: Colors.white.withOpacity(.8)),
                  cursorColor: Colors.white,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 15, left: 40),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.white.withOpacity(.7),
                    ),
                    border: InputBorder.none,
                    hintMaxLines: 1,
                    hintText: "Password",
                    hintStyle: TextStyle(
                        fontSize: 14, color: Colors.white.withOpacity(.5)),
                  ),
                ),
              ),
            ),
          ),

          //

          const SizedBox(
            height: 20,
          ),

          //

          if (_authMode == AuthMode.Signup)
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaY: 15,
                  sigmaX: 15,
                ),
                child: FadeIn(
                  curve: Curves.easeInOut,
                  duration: Duration(seconds: 1),
                  child: Container(
                    height: size.width / 6,
                    width: size.width / 1,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(right: size.width / 30),
                    decoration: BoxDecoration(
                      color: Colors.pink.withOpacity(.15),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      validator: _authMode == AuthMode.Signup
                          ? (value) {
                              if (value == _passwordController.text) {
                                return null;
                              }
                              return 'Passwords do not match!';
                            }
                          : null,
                      style: TextStyle(color: Colors.white.withOpacity(.8)),
                      cursorColor: Colors.white,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(top: 15, left: 40),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.white.withOpacity(.7),
                        ),
                        border: InputBorder.none,
                        hintMaxLines: 1,
                        hintText: "Confirm Password",
                        hintStyle: TextStyle(
                            fontSize: 14, color: Colors.white.withOpacity(.5)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          //

          const SizedBox(
            height: 40,
          ),

          //

          //
          _isLoading
              ? CircularProgressIndicator()
              : CustomButton(
                  buttonString:
                      _authMode == AuthMode.Login ? "LOGIN" : "SIGN UP",
                  voidCallback: () {
                    _submit();
                  },
                ),

          const SizedBox(
            height: 40,
          ),

          //

          TextButton(
            onPressed: () {
              _switchAuthMode();
            },
            child: _authMode == AuthMode.Signup
                ? const Text(
                    "lOGIN INSTEAD",
                    style: TextStyle(color: Colors.white),
                  )
                : const Text(
                    "SIGN UP INSTEAD",
                    style: TextStyle(color: Colors.white),
                  ),
          ),

          Container(
            height: 60,
          )
        ],
      ),
    );
  }
}
