import 'package:ReferIt/models/user.dart';
import 'package:ReferIt/screens/loading.dart';
import 'package:ReferIt/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:ReferIt/shared/constants.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  // GlobalKey globalKey = GlobalKey();
  String _currentName;
  bool _hasBeenPressed = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: FirestoreService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(
                    'Update your Username',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 100),
                    child: TextFormField(
                      initialValue: userData.name,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'enter username'),
                      validator: (val) =>
                          val.isEmpty ? 'please enter a name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await FirestoreService(uid: user.uid).updateUserData(
                            userData.uid,
                            _currentName ?? 'someone',
                            userData.reward);
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'update',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Your Refferal Code',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    decoration: BoxDecoration(color: Colors.grey),
                    child: Text(
                      user.uid,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 20),
                  FlatButton(
                      color: _hasBeenPressed ? Colors.white : Colors.blue,
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: user.uid));
                        setState(() {
                          _hasBeenPressed = true;
                        });
                      },
                      child: Text(
                        'Copy to Clipboard',
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
