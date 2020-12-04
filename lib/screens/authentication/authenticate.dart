import 'package:ReferIt/screens/authentication/refferal_register.dart';
import 'package:ReferIt/screens/authentication/register.dart';
import 'package:ReferIt/screens/authentication/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  bool showRegister = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  void toggleView2() {
    setState(() {
      showRegister = !showRegister;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      if (showRegister) {
        return Register(toggleView: toggleView, toggleView2: toggleView2);
      } else {
        return RefferalRegister(
            toggleView: toggleView, toggleView2: toggleView2);
      }
    }
  }
}
