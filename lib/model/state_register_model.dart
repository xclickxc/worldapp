import 'package:firebase_auth/firebase_auth.dart';

class StateRegister{
  bool isLoading;
  FirebaseUser firebaseUser;
  StateRegister({this.firebaseUser, this.isLoading = false});
}