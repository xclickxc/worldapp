import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

Future<GoogleSignInAccount> getSignedInAccount(GoogleSignIn googleSignIn) async
{
  //Is the user already signed in ?
  GoogleSignInAccount account = googleSignIn.currentUser;
  //Try to sign in the previous user
  if (account == null)
  {
    account = await googleSignIn.signInSilently();
  }
  return account;
}

Future<FirebaseUser> getCurrentUser(FirebaseAuth auth) async
{
  FirebaseUser user = await auth.currentUser();
  return user;
}

Future<void> signOutEmailAndPassword() async
{
  return FirebaseAuth.instance.signOut();
}

Future<FirebaseUser> signIntoFirebase(GoogleSignInAccount googleSignInAccount) async
{
//  GoogleSignIn _googleSignIn =  GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;
//  GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
  AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken
  );

  FirebaseUser user = await _auth.signInWithCredential(credential);
  return user;
}

Future<FirebaseUser> signIntoFirebase2() async
{
  GoogleSignInAccount googleSignInAccount;
  FirebaseAuth _auth = FirebaseAuth.instance;
//  GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
  AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken
  );

  FirebaseUser user = await _auth.signInWithCredential(credential);
  return user;
}