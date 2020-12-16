import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:musicPlayer/helper/helper.dart';
import 'package:musicPlayer/screen/auth/loginScreen/loginUi.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<UserCredential> signInWithGoogle(Function changeLoginState,
      Function addUser, Function updateFavList) async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential newUser =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print("ONLY USR-----------------------------");
      print(newUser.user.displayName);

      addUser(newUser.user.uid, newUser.user.displayName, newUser.user.email,
          newUser.user.photoURL);
      updateFavList();
      changeLoginState(true);
    } catch (e) {
      Helper().showSnackBar(e.toString(), "ERROR", context, true);
    }
  }

  comeingSoonMssage(text) {
    Helper().showSnackBar('Coming Soon', text, context, true);
  }

  userLogin(Function changeLoginState, Function addUser,
      Function updateFavList) async {
    await Helper().showLoadingDilog(context).show();
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
      changeLoginState(true);
      updateFavList();
      await Helper().showLoadingDilog(context).hide();
    } on FirebaseAuthException catch (e) {
      await Helper().showLoadingDilog(context).hide();
      if (e.code == 'user-not-found') {
        Helper().showSnackBar(
            'No user found for that email.', 'error', context, true);
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Helper().showSnackBar(
            'Wrong password provided for that user.', 'error', context, true);
      }
    } catch (e) {
      await Helper().showLoadingDilog(context).hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginUi(
          emailController: emailController,
          userLogin: userLogin,
          passwordController: passwordController,
          comeingSoonMssage: comeingSoonMssage,
          signInWithGoogle: signInWithGoogle),
    );
  }
}
