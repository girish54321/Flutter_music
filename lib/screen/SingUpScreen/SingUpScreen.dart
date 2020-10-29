import 'package:flutter/material.dart';
import 'package:musicPlayer/helper.dart';
import 'package:musicPlayer/home/HomeMain.dart';
import 'package:musicPlayer/home/home.dart';
import 'package:musicPlayer/provider/loginState.dart';
import 'package:musicPlayer/screen/loginScreen.dart/AppButton.dart';
import 'package:musicPlayer/screen/loginScreen.dart/inputText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:rules/rules.dart';

class SingUpScreen extends StatefulWidget {
  @override
  _SingUpScreenState createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();

  createNewUser(Function changeLoginState, Function addUser) async {
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    pr.style(
        message: 'Loading..',
        padding: EdgeInsets.all(16.0),
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: Container(
            padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
        elevation: 6.0,
        insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 19.0,
          fontWeight: FontWeight.w600,
        ));
    await pr.show();
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

      await pr.hide();
    } on FirebaseAuthException catch (e) {
      await pr.hide();
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
      await pr.hide();
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
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(18.0),
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      height: 480.00,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0.00, 5.00),
                            color: Color(0xff242424).withOpacity(0.22),
                            blurRadius: 15,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(4.00),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sign Up,",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 30,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                          new Text(
                            "Sign in to Continue",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff929292),
                            ),
                          ),
                          SizedBox(height: 22),
                          new Text(
                            "User Name",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff000000).withOpacity(0.50),
                            ),
                          ),
                          InputText(
                              password: false,
                              hint: "User Name",
                              textEditingController: userNameController,
                              validator: (userName) {
                                final userNameRule = Rule(
                                  userName,
                                  name: 'User Name',
                                  isRequired: true,
                                );
                                if (userNameRule.hasError) {
                                  return userNameRule.error;
                                } else {
                                  return null;
                                }
                              }),
                          new Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff000000).withOpacity(0.50),
                            ),
                          ),
                          InputText(
                              password: false,
                              hint: "Email",
                              textEditingController: emailController,
                              validator: (email) {
                                final emailRule = Rule(email,
                                    name: 'Email',
                                    isRequired: true,
                                    isEmail: true);
                                if (emailRule.hasError) {
                                  return emailRule.error;
                                } else {
                                  return null;
                                }
                              }),
                          new Text(
                            "Password",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff000000).withOpacity(0.50),
                            ),
                          ),
                          InputText(
                              textEditingController: passwordController,
                              password: true,
                              hint: "Password",
                              validator: (password) {
                                final passWordRule = Rule(password,
                                    name: 'Password',
                                    isRequired: true,
                                    minLength: 6);
                                if (passWordRule.hasError) {
                                  return passWordRule.error;
                                } else {
                                  return null;
                                }
                              }),
                          Consumer<LoginStateProvider>(
                            builder: (context, loginStateProvider, child) {
                              return Container(
                                child: AppButton(
                                  buttonText: "SIGN UP",
                                  function: () {
                                    // loginStateProvider.changeLoginState(true);
                                    // Navigator.of(context).pop();
                                    if (_formKey.currentState.validate()) {
                                      createNewUser(
                                          loginStateProvider.changeLoginState,
                                          loginStateProvider.addUser);
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
