import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:worldapp/model/contribute_model.dart';

class SkillSupportItem extends StatelessWidget
{
  Contribute contribute;
  SkillSupportItem({this.contribute});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var heightOne = height > 600 ? height / 6.0 : height / 5;
    return Container(
      height: height > 700 ? height / 6.5 : heightOne,
      child: Stack(
        children: <Widget>[
          Container(
            height: 100,
            margin: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0, top: 10.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      contribute.colorLeft,
                      contribute.colorRight
                    ]
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 12.0, bottom: 10.0),
                  height: 55.0,
                  width: 55.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: contribute.image)
                  ),
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10.0, top: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                contribute.name,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white
                                ),
                              ),
                              Text(
                                contribute.skillSupport,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100
                                ),
                                softWrap: true,
                              )
                            ],
                          ),
                        )
                      ],
                    )
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
                padding: width > 400 ? EdgeInsets.only(left: width / 2.7) : EdgeInsets.only(left: width / 3.3),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  margin: EdgeInsets.only(left: 90.0, right: width > 400 ? width / 6.85 : width / 7, bottom: 5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(-1.0, 2.0),
                            color: Colors.grey,
                            spreadRadius: 1.0,
                            blurRadius: 3.0
                        )
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {print(height);},
                          child: Icon(FontAwesomeIcons.facebook, color: contribute.colorRight,)
                      ),
                      GestureDetector(
                          child: Icon(FontAwesomeIcons.facebookMessenger, color: contribute.colorRight,)
                      ),
                      GestureDetector(
                        child: Icon(FontAwesomeIcons.instagram, color: contribute.colorRight,),
                      ),
                    ],
                  ),
                )
            ),
          )
        ],
      ),
    );
  }
}