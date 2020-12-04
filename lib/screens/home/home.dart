import 'package:ReferIt/models/user.dart';
import 'package:ReferIt/screens/home/instruction.dart';
import 'package:ReferIt/screens/home/reward.dart';
import 'package:ReferIt/screens/home/settings.dart';
import 'package:ReferIt/services/auth.dart';
import 'package:ReferIt/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    String uid = user.uid;
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return SettingsForm();
          });
    }

    void share(BuildContext context, String str) {
      final RenderBox box = context.findRenderObject();
      final String text =
          "download the apk file from $str and use my refferal code $uid to get 20 reward points";
      Share.share(
        text,
        subject: 'sharing',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
      );
    }

    return StreamProvider<UserData>.value(
        value: FirestoreService(uid: uid).userData,
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    children: <Widget>[
                      Reward(),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text('Share This App'),
                  onTap: () {
                    share(context,
                        'https://github.com/nalini21/ReferIt/blob/main/app-release.apk');
                  },
                ),
                ListTile(
                  title: Text('Logout'),
                  onTap: () async {
                    await _auth.signOut();
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text(
              'ReferIt',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              FlatButton.icon(
                  onPressed: () {
                    return _showSettingsPanel();
                  },
                  icon: Icon(Icons.settings, color: Colors.white),
                  label: Text(
                    'settings',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ))
            ],
          ),
          body: Instructions(),
        ));
  }
}
