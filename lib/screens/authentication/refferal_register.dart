import 'package:ReferIt/services/auth.dart';
import 'package:ReferIt/shared/constants.dart';
import 'package:flutter/material.dart';

import '../loading.dart';

class RefferalRegister extends StatefulWidget {
  final Function toggleView;
  final Function toggleView2;
  RefferalRegister({this.toggleView, this.toggleView2});

  @override
  _RefferalRegisterState createState() => _RefferalRegisterState();
}

class _RefferalRegisterState extends State<RefferalRegister> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error = '';
  String refferal = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.green,
                elevation: 0.0,
                title: Text('Use Refferal to Register')),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (val) => val.length < 6
                          ? 'Enter a password with more than 5 characters'
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Refferal Code'),
                      onChanged: (val) {
                        setState(() {
                          refferal = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth
                              .registerWithRefferalAndEmailAndPassword(
                                  email, password, refferal);
                          // print('function refferal executed-----------------');
                          if (result == null) {
                            setState(() {
                              error = 'please supply valid email address';
                              loading = false;
                            });
                          }
                        }
                      },
                      color: Colors.green,
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 30),
                    FlatButton(
                        onPressed: () {
                          widget.toggleView();
                        },
                        child: Text(
                          'Already have an account? then Sign-in',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue),
                        )),
                    FlatButton(
                        onPressed: () {
                          widget.toggleView2();
                        },
                        child: Text(
                          'Don\'t have a Refferal Code? then Click Here',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue),
                        )),
                    SizedBox(height: 40),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
