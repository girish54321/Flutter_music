import 'package:flutter/material.dart';
import 'package:musicPlayer/helper/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicPlayer/screen/auth/SingUpScreen/singUpUi.dart';

class SingUpScreen extends StatefulWidget {
  @override
  _SingUpScreenState createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();

  createNewUser(Function changeLoginState, Function addUser) async {
    await Helper().showLoadingDilog(context).show();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
      print(userCredential);
      addUser(userCredential.user.uid, userNameController.text.trim(),
          emailController.text.trim());
      changeLoginState(true);
      Navigator.of(context).pop();
      await Helper().showLoadingDilog(context).hide();
    } on FirebaseAuthException catch (e) {
      await Helper().showLoadingDilog(context).hide();
      if (e.code == 'weak-password') {
        Helper().showSnackBar(
            'The password provided is too weak.', 'error', context, true);
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Helper().showSnackBar('The account already exists for that email.',
            'error', context, true);
        print('The account already exists for that email.');
      }
    } catch (e) {
      await Helper().showLoadingDilog(context).hide();
      print(e);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingUpUi(
        createNewUser: createNewUser,
        emailController: emailController,
        passwordController: passwordController,
        userNameController: userNameController,
      ),
    );
  }
}
