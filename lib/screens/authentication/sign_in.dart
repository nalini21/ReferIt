import 'package:ReferIt/services/auth.dart';
import 'package:ReferIt/shared/constants.dart';
import 'package:flutter/material.dart';

import '../loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
//text field state
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            //backgroundColor: Colors.blueAccent,
            appBar: AppBar(
                backgroundColor: Colors.green,
                elevation: 0.0,
                title: Text('Sign in to the App')),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              // child: RaisedButton(
              //     child: Text('Sign In annonymously'),
              //     onPressed: () async {
              //       dynamic result = await _auth.signInAnon();
              //       if (result == null) {
              //         print('not able to sign in');
              //       } else {
              //         print('signed in');
              //         print(result.uid);
              //       }
              //       //print(result);
              //     }),
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
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
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
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error =
                                  'could not sign in with those credentials';
                              loading = false;
                            });
                          }
                        } else {}
                      },
                      color: Colors.green,
                      child: Text(
                        'Sign-in',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 30),
                    FlatButton(
                        onPressed: () {
                          widget.toggleView();
                        },
                        child: Text(
                          'Don\'t have any account?, then Register',
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
