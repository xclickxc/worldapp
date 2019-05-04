import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:worldapp/data/contribute_list.dart';
import 'package:worldapp/view/setting_view/skill_item.dart';
import 'package:worldapp/view/setting_view/contribute_item.dart';

class AboutUs extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => new AboutUsState();
}

class AboutUsState extends State<AboutUs>
{
  var facebookID = "https://fb.me/cuong98.nb";
  openFacebook() async {
    await canLaunch(facebookID) ? launch(facebookID) : debugPrint("Error");
  }
  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    return new Scaffold(
      body: Container(
        height: maxHeight,
        child: Column(
          children: <Widget>[
            _buildHeader(),
            _listBody()
          ],
        ),
      ),
    );
  }

  Widget _buildHeader()
  {
    double maxHeight = MediaQuery.of(context).size.height;
    double height = MediaQuery.of(context).size.height * 0.75;
    return Container(
      padding: EdgeInsets.only(top: 30.0, left: 10.0),
      height: maxHeight > 700 ? height / 8 : height / 6,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: (){
                print(maxHeight);
                Navigator.pop(context);
              }
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Text(
              "About",
              style: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.w700
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _listBody()
  {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height > 700 ? height - height / 8 : height - height / 6,
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                _buildInfoApp(),
                _buildSkillSupport(),
                _buildLanguageContribute(),
                _buildFooter()
              ],
            )
          )
        ],
      ),
    );
  }

  Widget _buildInfoApp()
  {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double heightOne = height > 600 ? height / 6.0 : height / 5;
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      height: height > 700 ? height / 5 : height / 4,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.language,color: Colors.deepPurple, size: 70,),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "World Tour",
                              style: TextStyle(
                                  fontSize: 27.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              color: Colors.black,
                            ),
                            child: Text("v1.0", style: TextStyle(color: Colors.white),),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "This app is used to browse web for popular repositories",
                          style: TextStyle(
                              fontSize: 15.0
                          ),
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  )
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0, left: 40, right: 40.0),
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                gradient: LinearGradient(
                    colors: [
                      Colors.orangeAccent,
                      Colors.pinkAccent
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Icon(FontAwesomeIcons.globeAmericas, color: Colors.white,),
                ),
                GestureDetector(
                  child: Icon(FontAwesomeIcons.facebook, color: Colors.white,),
                  onTap: openFacebook,
                ),
                GestureDetector(
                  child: Icon(FontAwesomeIcons.googlePlusG, color: Colors.white,),
                ),
                GestureDetector(
                  child: Icon(FontAwesomeIcons.solidPaperPlane, color: Colors.white,),
                ),
                GestureDetector(
                  child: Icon(FontAwesomeIcons.github, color: Colors.white,),
                ),
                GestureDetector(
                  child: Icon(FontAwesomeIcons.bug, color: Colors.white,),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSkillSupport()
  {
    return Column(
      children: <Widget>[
        ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: skillSupport.length,
            addAutomaticKeepAlives: true,
            itemBuilder: (context, index)
            {
              return SkillSupportItem(contribute: skillSupport[index],);
            }
        )
      ],
    );
  }

  Widget _buildLanguageContribute()
  {
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(left: 25.0, right: 25.0),
      child: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          Text(
            "Language Contributors",
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.pink
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15.0),
            height: height / 3.5,
            child: GridView.builder(
                addAutomaticKeepAlives: true,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: contributeLanguage.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: height > 600 ? 1/ 1.7 : 1 / 1.8
                ),
                itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector(
                    child: new ContributeItem(contribute: contributeLanguage[index],),
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        child: new CupertinoAlertDialog(
                          title: new Column(
                            children: <Widget>[
                              new Text("Language Contribute"),
                              new Text(contributeLanguage[index].name)
                            ],
                          ),
                          content: new Text(contributeLanguage[index].languageSupport),
                          actions: <Widget>[
                            new FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: new Text("OK")
                            )
                          ],
                        ),
                      );
                    },
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget _buildFooter()
  {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey)
        )
      ),
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.info),
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Open source licences",
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "Licences details for open source softwave",
                            style: TextStyle(
                                fontSize: 14.0
                            ),
                          )
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Icon(Icons.info),
              Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Changelog",
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "Contains of current and previous versions of this app.",
                          style: TextStyle(
                              fontSize: 14.0
                          ),
                        )
                      ],
                    ),
                  )
              )
            ],
          )
        ],
      ),
    );
  }

}