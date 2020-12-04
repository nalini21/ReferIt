import 'package:ReferIt/screens/authentication/authenticate.dart';
import 'package:ReferIt/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    //return either authentication screen or home screen
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
