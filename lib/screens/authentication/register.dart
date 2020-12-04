// import 'package:ReferIt/screens/authentication/refferal_register.dart';
import 'package:ReferIt/services/auth.dart';
import 'package:ReferIt/shared/constants.dart';
import 'package:flutter/material.dart';
import '../loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  final Function toggleView2;
  Register({this.toggleView, this.toggleView2});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            //backgroundColor: Colors.blueAccent,
            appBar: AppBar(
                backgroundColor: Colors.green,
                elevation: 0.0,
                title: Text('Register to the App')),
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
                    RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
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
                          'have a Refferal Code? then Click Here',
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
