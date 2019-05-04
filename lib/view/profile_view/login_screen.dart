import 'package:flutter/material.dart';
import 'package:worldapp/view/profile_view/signup_screen.dart';
import 'dart:math' as math;
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:worldapp/animation/scale_route.dart';
import 'state_widget.dart';

class LoginScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
{
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _value1 = false;
  void _value1Changed(bool value)
  {
    setState(() {
      _value1 = value;
      if (_value1)
      {
        print("Remember Password");
      }
      else{
        print("Don't Remember Password");
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: <Widget>[
            _buildHeader(),
            _buildFormLogin(),
            _buildFooter()
          ],
        ),
      ),
    );
  }

  Widget _buildHeader()
  {
    return Stack(
      children: <Widget>[
        _buildRectangleOne(),
        _buildBackground(),
        _buildNameApp(),
      ],
    );
  }

  Widget _buildBackground()
  {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: height*0.1 * 1.3),
      height: height / 2.3,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Image.asset(
          "assets/imageRegister/login_demo.png",
          height: height / 3,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildRectangleOne()
  {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Positioned(
        left: width / 4.5,
        top: - height / 3.6,
        child: Transform.rotate(
          angle: - math.pi / 3.3,
          child: Container(
            height: height / 1.7,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.tealAccent,
                      Colors.lightBlue
                    ]
                )
            ),
          ),
        )
    );
  }

  Widget _buildNameApp()
  {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Positioned(
        left: width * 0.1 / 5,
        top: height / 8,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.language, size: width > 360 ? 70.0 : 60, color: Colors.deepPurple),
            Text(
              "World Tour",
              style: TextStyle(
                  fontSize: width > 360 ? 30.0 : 25,
                  fontWeight: FontWeight.w700
              ),
            )
          ],
        )
    );
  }

  Widget _buildFormLogin()
  {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Positioned(
        top: height > 600 ? height / 3.2 : height / 3.5,
        child: Container(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: "Email or nickname",
                              labelText: "Username",
                              labelStyle: TextStyle(
                                  fontSize: 18.0
                              )
                          ),
                          validator: (value) => value.isEmpty ? "Email can't empty" : null,
                          onSaved: (value) => emailController.text = value,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "********",
                            labelText: "Password",
                            labelStyle: TextStyle(
                                fontSize: 18.0
                            ),
                            alignLabelWithHint: true,
                          ),
                          validator: (value) => value.isEmpty ? "Password can't empty" : null,
                        ),
                      )
                    ],
                  )
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 30.0, top: 15.0),
                    child: GestureDetector(
                      onTap: (){print("Forgot Password");},
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                            color: Colors.indigoAccent,
                            fontSize: 15.0
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: CircularCheckBox(
                        value: _value1,
                        onChanged: _value1Changed,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: width > 360 ? 80.0 : 20),
                      child: Text("Remember Me"),
                    ),
                    GradientButton(
                        increaseHeightBy: 15,
                        increaseWidthBy: 65,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                        gradient: Gradients.buildGradient(
                            Alignment.bottomLeft, Alignment.bottomRight,
                            <Color>[
                              Colors.tealAccent,
                              Colors.blueAccent
                            ]
                        ),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20.0
                          ),
                        ),
                        callback: ()
                        {
                          print("Login");
                          StateWidget.of(context).signInWithEmailPassword(emailController.text, passwordController.text).catchError((e)
                          {
                            print(e.message);
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(e.message),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () => Navigator.pop(context, false),
                                        child: Text("Dismiss")
                                    ),
                                  ],
                                )
                            );
                          }
                          );
                        }
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget _buildFooter()
  {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Positioned(
        top: height > 600 ? height / 1.4 : height / 1.35,
        child: Container(
          width: width,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Social Login",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey[600]
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: height > 600 ? 25.0 : 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: <Color>[
                                Colors.blue,
                                Colors.blue[800]
                              ]
                          )
                      ),
                      child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.facebookF,
                            color: Colors.white,
                            size: 25.0,
                          ),
                          onPressed: () async{
                            return showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context)
                                {
                                  return AlertDialog(
                                    title: Text("Coming Soon"),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
                                    ],
                                  );
                                }
                            );
                          }
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: <Color>[
                              Colors.redAccent,
                              Colors.redAccent
                            ]
                          )
                      ),
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.google,
                          color: Colors.white,
                          size: 25.0,
                        ),
                        onPressed: ()
                        {
                          print("Google");
                          StateWidget.of(context).signInWithGoogle();
                        }
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: <Color>[
                            Colors.lightBlueAccent,
                            Colors.blueAccent
                          ]
                        )
                      ),
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.twitter,
                          color: Colors.white,
                          size: 25.0,
                        ),
                        onPressed: () async {
                          return showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context)
                              {
                                return AlertDialog(
                                  title: Text("Coming Soon"),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
                                  ],
                                );
                              }
                          );
                        }
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: SweepGradient(
                          colors: <Color>[
                            Colors.purple,
                            Colors.pinkAccent,
                            Colors.orangeAccent
                          ]
                        )
                      ),
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.instagram,
                          color: Colors.white,
                          size: 25.0,
                        ),
                        onPressed: () async {
                          return showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context)
                              {
                                return AlertDialog(
                                  title: Text("Coming Soon"),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
                                  ],
                                );
                              }
                          );
                        }
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: height > 600 ? 50.0 : 30.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black
                          ),
                          children: <TextSpan>[
                            new TextSpan(text: "New user? "),
                            new TextSpan(text: "Signup", style: TextStyle(color: Colors.blue[800]))
                          ]
                        )
                      ),
                      onTap: ()
                      {
                        print("Signup");
                        Navigator.pushReplacement(context, ScaleRoute(widget: new SignupScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
