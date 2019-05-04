import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:circular_check_box/circular_check_box.dart';
import 'package:worldapp/view/profile_view/login_screen.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:worldapp/animation/scale_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignupScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => new SignupScreenState();
}

class SignupScreenState extends State<SignupScreen>
{
  final _formKey = new GlobalKey<FormState>();

  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final nickNameController = new TextEditingController();

  bool _success;
  String _userEmail;

  String validateEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if(!regExp.hasMatch(value)){
      return "Invalid Email";
    }else {
      return null;
    }
  }

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
//            _buildFooter()
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
      padding: EdgeInsets.only(right: height*0.1 * 1.3),
      height: height / 2.3,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Image.asset(
          "assets/imageRegister/signup_demo.png",
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
        left: - width / 4.5,
        top: - height / 3.6,
        child: Transform.rotate(
          angle: math.pi / 3.3,
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
        right: width * 0.1 / 5,
        top: height / 8,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "World Tour",
              style: TextStyle(
                  fontSize: width > 360 ? 30.0 : 25.0,
                  fontWeight: FontWeight.w700
              ),
            ),
            Icon(Icons.language, size: width > 360 ? 70.0 : 60, color: Colors.deepPurple,),
          ],
        )
    );
  }

  Widget _buildFormLogin()
  {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Positioned(
        top: height > 600 ? height / 3.2 : height / 3.6,
        child: Transform.scale(
          scale: height > 600 ? 1 : 0.8,
          child: Container(
            margin: EdgeInsets.only(top: 10.0),
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 30.0),
                  child: Text(
                    "Signup",
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
                          padding: EdgeInsets.only(left: height > 600 ? 30.0 : 0.0, right: height > 600 ? 30.0 : 0.0),
                          child: TextFormField(
                            controller: nickNameController,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            decoration: InputDecoration(
                              hintText: "Nickname",
                              labelText: "Nick Name",
                              labelStyle: TextStyle(
                                  fontSize: 18.0
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty)
                              {
                                return "Nickname can't empty";
                              }
                              if (value.length < 4)
                              {
                                return "Nickname too short";
                              }
                            },
                            onSaved: (value) => emailController.text = value,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: height > 600 ? 30.0 : 0.0, right: height > 600 ? 30.0 : 0.0),
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            decoration: InputDecoration(
                              hintText: "Email",
                              labelText: "Email",
                              labelStyle: TextStyle(
                                  fontSize: 18.0
                              ),
                            ),
                            validator: validateEmail,
                            onSaved: (value) => emailController.text = value,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: height > 600 ? 30.0 : 0.0, right: height > 600 ? 30.0 : 0.0),
                          child: TextFormField(
                            controller: passwordController,
                            maxLines: 1,
                            autofocus: false,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "********",
                              labelText: "Password",
                              labelStyle: TextStyle(
                                  fontSize: 18.0
                              ),
                              alignLabelWithHint: true,
                            ),
                            validator: (value) {
                              if (value.isEmpty)
                              {
                                return "Password can't empty";
                              }
                              if (value.length < 8)
                              {
                                return "Password must be 8 character";
                              }
                            },
                            onSaved: (value) => passwordController.text = value,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: height > 600 ? 30.0 : 0.0, right: height > 600 ? 30.0 : 0.0),
                          child: TextFormField(
                            controller: passwordController,
                            maxLines: 1,
                            autofocus: false,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "********",
                              labelText: "Repeat Password",
                              labelStyle: TextStyle(
                                  fontSize: 18.0
                              ),
                              alignLabelWithHint: true,
                            ),
                            validator: (value) => value.isEmpty  ? "Password can't be empty" : null,
                            onSaved: (value) => passwordController.text = value,
                          ),
                        ),
                      ],
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(top: 35.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: height > 600 ? 30.0 : 0.0),
                        child: GradientButton(
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
                              "SIGNUP",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20.0
                              ),
                            ),
                            callback: ()
                            {
                              print("SIGNUP");
                              if (_formKey.currentState.validate())
                              {
                                _register(emailController.text, passwordController.text, nickNameController.text);
                              }
                            }
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width > 360 ? width * 0.1 : width / 8),
                        child: CircularCheckBox(
                          value: _value1,
                          onChanged: _value1Changed,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 0.0),
                        child: Text("Signup and Login"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _register(String email, String password, String name) async {
    final FirebaseUser user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).catchError((exception){
      print(exception.message);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(exception.message),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text("Dismiss")
              ),
            ],
          )
      );
    });
    await user.sendEmailVerification();
    assert(user != null);
    assert(await user.getIdToken() != null);
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });

      await Firestore.instance.collection("users").document(user.uid).setData({
        'uid': user.uid,
        'email': user.email,
        'displayName': name
      });

      await _auth.currentUser().then((update) {
        UserUpdateInfo userUpdateInfo = UserUpdateInfo();
        userUpdateInfo.displayName = name;
        update.updateProfile(userUpdateInfo);
      });

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Sign Up Successfully! Login Now"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text("No")
              ),
              FlatButton(
                  onPressed: ()
                  {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => new LoginScreen()), ModalRoute.withName('/'));
                  },
                  child: Text("Yes")
              )
            ],
          )
      );
    } else {
      _success = false;
    }

  }

  Widget _buildFooter()
  {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Positioned(
        top: height > 700 ? height / 1.2 : height / 1.15,
        child: Transform.scale(
          scale: height > 600 ? 1 : 0.8,
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
                        "Or",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[600]
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: height > 600 ? 35.0 : 20.0),
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
                                  new TextSpan(text: "Have An Account? "),
                                  new TextSpan(text: "Login Now", style: TextStyle(color: Colors.blue[800]))
                                ]
                            )
                        ),
                        onTap: ()
                        {
                          print("Signup");
                          Navigator.pushReplacement(context, ScaleRoute(widget: new LoginScreen()));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }



}