import 'package:flutter/material.dart';
import 'package:worldapp/main.dart';
//import 'package:worldapp/view/home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:worldapp/view/setting_view/language_screen.dart';
import 'package:worldapp/view/setting_view/about_screen.dart';

class Setting extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => new SettingState();
}

class SettingState extends State<Setting>
{
  DateTime currentBackPressTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: Colors.grey[350],
        height: height,
        child: Stack(
          children: <Widget>[
            _buildHeader(),
            _buildContentOne(),
            _buildContentTwo(),
            _buildContentThree(),
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
                print(height);
                Navigator.pop(context);
              }
          ),
          Padding(
            padding: EdgeInsets.only(left: 2.0),
            child: Text(
              "Settings",
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

  Widget _buildContentOne()
  {
    double maxHeight = MediaQuery.of(context).size.height;
    double height = MediaQuery.of(context).size.height * 0.75;
    return Container(
      margin: EdgeInsets.only(top: maxHeight > 700 ? height / 6.5 : height / 5),
      padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
      height: maxHeight > 700 ? height / 3.5 : height / 3,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: (){
              print("Home");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new MainWidget())
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Transform.scale(scale: 0.8, child: Image.asset("assets/iconsetting/icon-home.png"),),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Home",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: (){print("Bookmark");},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Transform.scale(scale: 0.8, child: Image.asset("assets/iconsetting/icon-bookmark.png"),),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Bookmark",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5.0),
                  child: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: null
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              print("Language");
              Navigator.push(context, MaterialPageRoute(builder: (context) => new LanguageScreen()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Transform.scale(scale: 0.8, child: Image.asset("assets/iconsetting/icon-world.png"),),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Language",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5.0),
                  child: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => new LanguageScreen()));
                      }
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContentTwo()
  {
    double maxHeight = MediaQuery.of(context).size.height;
    double height = MediaQuery.of(context).size.height * 0.75;
    return Container(
      margin: EdgeInsets.only(top: maxHeight > 700 ? height / 2.1 : height / 1.8),
      padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
      height: maxHeight > 700 ? height / 2.2 : height / 2,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: (){print("Send Feedback!");},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Transform.scale(scale: 0.8, child: Image.asset("assets/iconsetting/icon-email.png"),),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Send Feedback!",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: (){print("Share This App");},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Transform.scale(scale: 0.8, child: Image.asset("assets/iconsetting/icon-share.png"),),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Share This App",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: (){print("Rate This App");},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Transform.scale(scale: 0.8, child: Image.asset("assets/iconsetting/icon-star.png"),),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Rate This App",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: (){print("More App");},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Transform.scale(scale: 0.8, child: Image.asset("assets/iconsetting/icon-more.png"),),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "More App",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: (){print("Privacy Policy");},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Transform.scale(scale: 0.8, child: Image.asset("assets/iconsetting/icon-lock.png"),),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Privacy Policy",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Double tap to exit");
      return Future.value(false);
    }
    return Future.value(true);
  }

  Widget _buildContentThree()
  {
    double maxHeight = MediaQuery.of(context).size.height;
    double height = MediaQuery.of(context).size.height * 0.75;
    var heightOne = maxHeight > 600 ? height / 10 : height / 8.5;
    return Container(
      margin: EdgeInsets.only(top: maxHeight > 700 ? height / 1.03 : height / 0.93),
      padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
      height: maxHeight > 700 ? height / 11.3 : heightOne,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.info_outline, size: 30, color: Colors.deepPurple),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "About Us",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                )
              ],
            ),
            onTap: ()
            {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new AboutUs())
              );
            },
          ),
        ],
      ),
    );
  }
}
