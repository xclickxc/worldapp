import 'package:flutter/material.dart';
import 'package:worldapp/model/contribute_model.dart';

class ContributeItem extends StatelessWidget
{
  Contribute contribute;
  ContributeItem({Key key, this.contribute}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          width: 50,
          child: contribute.image != null
              ? CircleAvatar(backgroundImage: contribute.image,)
              : CircleAvatar(backgroundColor: contribute.color,),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Column(
            children: <Widget>[
              Text(
                contribute.name,
                style: TextStyle(
                    fontSize: 16.0
                ),
              ),
              Text(contribute.languageSupport)
            ],
          ),
        )
      ],
    );
  }
}