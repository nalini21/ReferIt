import 'package:ReferIt/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Reward extends StatefulWidget {
  @override
  _RewardState createState() => _RewardState();
}

class _RewardState extends State<Reward> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    var name = user.name;
    var reward = user.reward;
    return Container(
      child: Column(children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text(
            'Welcome,',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            name.toString(),
            style: TextStyle(
                color: Colors.yellow,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ]),
        SizedBox(
          height: 10,
        ),
        Text(
          'You have earned',
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
        Text(
          reward.toString(),
          style: TextStyle(
              color: Colors.yellow, fontSize: 45, fontWeight: FontWeight.bold),
        ),
        // SizedBox(
        //   height: 5,
        // ),
        Text(
          'reward points',
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
      ]),
    );
  }
}
