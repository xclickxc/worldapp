import 'package:flutter/material.dart';
import 'package:worldapp/model/state_register_model.dart';
import 'package:worldapp/view/profile_view/state_widget.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:math' as math;
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:worldapp/view/setting_view/setting_screen.dart';
import 'package:worldapp/view/profile_view/login_screen.dart';
import 'package:worldapp/main.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen>
{
  GlobalKey _key = GlobalKey();
  File _image;
  File _imageCover;
  StateRegister appState;
  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).stateRegister;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: _buildContent(),
    );
  }

  Widget _buildContent()
  {
    if (appState.isLoading)
    {
      return Center(
        child: new CircularProgressIndicator(),
      );
    }
    else if (!appState.isLoading && appState.firebaseUser == null)
    {
      return new LoginScreen();
    }
    else
    {
      return MainWidget();
    }
  }

  Future getImageCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future getImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageCover = image;
    });
  }

  Future getImageCoverCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageCover = image;
    });
  }

  Future getImageCoverGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Widget _buildBody()
  {
    double height = MediaQuery.of(context).size.height / 3;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      height: height - 50,
      decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
    );
  }

  Widget _buildHeader()
  {
    double maxHeight = MediaQuery.of(context).size.height;
    double height = MediaQuery.of(context).size.height * 2/3;
    return Container(
      height: height - 50,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperOne(),
            child: Image(
              image: appState.firebaseUser.photoUrl == null
                  ? AssetImage("assets/profile_3.jpg")
                  : NetworkImage(appState.firebaseUser.photoUrl),
              fit: BoxFit.cover,
              height: height / 2,
              width: 1440.0,
              colorBlendMode: BlendMode.srcOver,
              color: new Color.fromARGB(120, 20, 10, 40),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height / 2 - 45),
            child: Stack(
              children: <Widget>[
                Transform.rotate(
                  angle: math.pi,
                  child: ClipPath(
                    clipper: WaveClipperOneOne(),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      height: height / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0)),
                          color: Colors.deepPurple
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildHalfHeader(),
          Padding(
            padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.settings, color: Colors.white,),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new Setting())
                      );
                    }
                ),
                IconButton(
                    icon: Icon(Icons.camera_alt, size: 35.0, color: Colors.white,),
                    onPressed: () async {
                      return showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context)
                          {
                            return AlertDialog(
                              title: Text("Choose Image Cover"),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              ),
                              content: Container(
                                height: 50.0,
                                alignment: Alignment.bottomLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.videocam),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5.0),
                                            child: Text(
                                              "Take A Photo",
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      onTap: () {
                                        getImageCoverCamera();
                                        Navigator.of(context, rootNavigator: true).pop('dialog');
                                      },
                                    ),
                                    GestureDetector(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.perm_media),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5.0),
                                            child: Text(
                                              "Select A Photo",
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      onTap: (){
                                        getImageCoverGallery();
                                        Navigator.of(context, rootNavigator: true).pop('dialog');
                                      },
                                    )
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        fontSize: 20.0
                                    ),
                                  ),
                                  onPressed: (){Navigator.pop(context);},
                                )
                              ],
                            );
                          }
                      );
                    })
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: maxHeight > 600 ? height / 2 - 95 : height / 2 - 100),
            child: Transform.scale(
              scale: maxHeight > 600 ? 1 : 0.8,
              child: Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.deepPurple, width: 5.0
                          )
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey, width: 2.0
                                )
                            ),
                            child: CircleAvatar(
                              backgroundImage: appState.firebaseUser.photoUrl == null
                                  ? AssetImage("assets/profile_3.jpg")
                                  : NetworkImage(appState.firebaseUser.photoUrl),
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 100.0, left: 95.0),
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.deepPurpleAccent, width: 3),
                            color: Colors.white
                        ),
                        child: IconButton(
                            icon: Icon(Icons.camera_alt),
                            onPressed: () async {
                              return showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context)
                                  {
                                    return AlertDialog(
                                      title: Text("Choose Avatar"),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                      ),
                                      content: Container(
                                        height: 50.0,
                                        alignment: Alignment.bottomLeft,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            GestureDetector(
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(Icons.videocam),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 5.0),
                                                    child: Text(
                                                      "Take A Photo",
                                                      style: TextStyle(
                                                          fontSize: 18.0,
                                                          fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              onTap: () {
                                                getImageCamera();
                                                Navigator.of(context, rootNavigator: true).pop('dialog');
                                              },
                                            ),
                                            GestureDetector(
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(Icons.perm_media),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 5.0),
                                                    child: Text(
                                                      "Select A Photo",
                                                      style: TextStyle(
                                                          fontSize: 18.0,
                                                          fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              onTap: (){
                                                getImageGallery();
                                                Navigator.of(context, rootNavigator: true).pop('dialog');
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                fontSize: 20.0
                                            ),
                                          ),
                                          onPressed: (){Navigator.pop(context);},
                                        )
                                      ],
                                    );
                                  }
                              );
                            }
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
//          Positioned(
//            bottom: 110.0,
//            left: 185,
//            child: AnimatedFab()
//          ),
        ],
      ),
    );
  }

  Widget _buildHalfHeader()
  {
    double maxHeight = MediaQuery.of(context).size.height;
    double height = MediaQuery.of(context).size.height * 2/3 ;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: maxHeight > 600 ? height / 2 + 60 : height / 2 + 40),
      child: Transform.scale(
        scale: maxHeight > 600 ? 1 : 0.8,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              InkWell(
                child: Text(
                  "${appState.firebaseUser.displayName}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500
                  ),
                ),
                onTap: () async
                {
                  return showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context)
                      {
                        return AlertDialog(
                          title: Text("Change Nickname"),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                          content: Container(
                            height: 50.0,
                            alignment: Alignment.bottomLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                TextFormField(
                                  decoration: InputDecoration(
                                      hintText: "${appState.firebaseUser.displayName}"
                                  ),
                                )
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    fontSize: 20.0
                                ),
                              ),
                              onPressed: (){Navigator.pop(context);},
                            ),
                            FlatButton(
                              child: Text(
                                "OK",
                                style: TextStyle(
                                    fontSize: 20.0
                                ),
                              ),
                              onPressed: (){Navigator.pop(context);},
                            )
                          ],
                        );
                      }
                  );
                },
              ),
              Padding(
                key: _key,
                padding: EdgeInsets.only(top: height / 50, left: width / 5, right: width / 5),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                child: Text(
                                  "1.0M",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18.0
                                  ),
                                ),
                                onTap: ()
                                {
                                  print(maxHeight);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              "followers",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              color: Colors.cyan,
                              shape: BoxShape.circle,
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "200",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18.0
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              "visited",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              color: Colors.indigoAccent,
                              shape: BoxShape.circle,
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "996",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18.0
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              "photos",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Future<bool> onPressed()
  {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Do You Want Sign Out?"),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("No")
            ),
            FlatButton(
                onPressed: ()
                {
                  StateWidget.of(context).signOut();
                  Navigator.pop(context, false);
                },
                child: Text("Yes")
            )
          ],
        )
    );
  }
}

class WaveClipperOneOne extends CustomClipper<Path> {
  bool reverse;

  WaveClipperOneOne({this.reverse=false});

  @override
  Path getClip(Size size) {

    if(!reverse) {
      Offset firstEndPoint = Offset(size.width * .5,size.height-30);
      Offset firstControlPoint = Offset(size.width * .25,size.height-40);
      Offset secondEndPoint = Offset(size.width,size.height - 50);
      Offset secondControlPoint = Offset(size.width * .75,size.height-20);

      final path = Path()
        ..lineTo(0.0, size.height)
        ..quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy)
        ..quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy)
        ..lineTo(size.width, 0.0)
        ..close();
      return path;
    }else {
      Offset firstEndPoint = Offset(size.width * .5,20);
      Offset firstControlPoint = Offset(size.width * .25,30);
      Offset secondEndPoint = Offset(size.width,50);
      Offset secondControlPoint = Offset(size.width * .75,10);

      final path = Path()
        ..quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy)
        ..quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy)
        ..lineTo(size.width, size.height)
        ..lineTo(0.0, size.height)
        ..close();
      return path;
    }

  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}