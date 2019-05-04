import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:worldapp/model/state_register_model.dart';
import 'package:worldapp/utils/authentication.dart';

class StateWidget extends StatefulWidget
{
  final StateRegister stateRegister;
  final Widget child;
  StateWidget({@required this.child, this.stateRegister});

  static _StateWidgetState of(BuildContext context)
  {
    return (context.inheritFromWidgetOfExactType(_StateDataWidget) as _StateDataWidget).data;
  }

  @override
  State<StatefulWidget> createState() => new _StateWidgetState();

}

class _StateWidgetState extends State<StateWidget>
{
  StateRegister stateRegister;
  GoogleSignInAccount googleSignInAccount;
  FirebaseUser user;
  String email;
  String password;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.stateRegister != null)
    {
      stateRegister = widget.stateRegister;
    }
    else
    {
      stateRegister = new StateRegister(isLoading: true);
      initUser();
      initUserEmailPassword(email, password);
    }
  }

  Future<Null> initUser() async
  {
    googleSignInAccount = await getSignedInAccount(googleSignIn);
    if (googleSignInAccount == null)
    {
      setState(() {
        stateRegister.isLoading = false;
      });
    }
    else
    {
      await signInWithGoogle();
    }
  }

  Future<Null> initUserEmailPassword(String email, String password) async
  {
    user = await getCurrentUser(_auth);
    if (user == null)
    {
      setState(() {
        stateRegister.isLoading = false;
      });
    }
    else
    {
      await signInWithEmailPassword(email, password);
    }
  }

  Future<Null> signInWithGoogle() async
  {
    if (googleSignInAccount == null)
    {
      //Start the sign-in process
      googleSignInAccount = await googleSignIn.signIn();
    }
    FirebaseUser firebaseUser = await signIntoFirebase(googleSignInAccount);
    setState(() {
      stateRegister.isLoading = false;
      stateRegister.firebaseUser = firebaseUser;
    });
  }

  Future<Null> signInWithEmailPassword(String email, String password) async
  {
    if (user == null)
    {
      user = await _auth.signInWithEmailAndPassword(email: email, password: password);
    }
    setState(() {
      stateRegister.isLoading =  false;
      stateRegister.firebaseUser = user;
    });
  }

  Future<Null> signOut() async {
    // Sign out from Firebase and Google
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
    // Clear variables
    googleSignInAccount = null;
    stateRegister.firebaseUser = null;
    setState(() {
      stateRegister= StateRegister(firebaseUser: null);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new _StateDataWidget(
        data: this,
        child: widget.child
    );
  }
}

class _StateDataWidget extends InheritedWidget
{
  final _StateWidgetState data;
  _StateDataWidget({Key key, @required this.data, @required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_StateDataWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

}