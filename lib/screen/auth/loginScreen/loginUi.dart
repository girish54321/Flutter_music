import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/helper/helper.dart';
import 'package:musicPlayer/provider/Fav_list.dart';
import 'package:musicPlayer/provider/loginState.dart';
import 'package:musicPlayer/screen/auth/SingUpScreen/singUpScreen.dart';
import 'package:musicPlayer/widgets/AppButton.dart';
import 'package:musicPlayer/widgets/SocialLoginButton.dart';
import 'package:musicPlayer/widgets/inputText.dart';
import 'package:provider/provider.dart';
import 'package:rules/rules.dart';

class LoginUi extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function userLogin;
  final Function comeingSoonMssage;
  final Function signInWithGoogle;
  const LoginUi(
      {Key key,
      @required this.emailController,
      @required this.passwordController,
      @required this.userLogin,
      this.comeingSoonMssage,
      this.signInWithGoogle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return LayoutBuilder(
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
                    height: 470.00,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                new Text(
                                  "Welcome,",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30,
                                    color: Color(0xff000000),
                                  ),
                                ),
                                new Text(
                                  "Sign in to Continue",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff929292),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Helper()
                                    .goToPage(context, SingUpScreen(), false);
                              },
                              child: Text(
                                "Sign Up",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 22),
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: new Text(
                            "Forgot Password?\n",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Consumer<FavListProvider>(
                          builder: (context, favListProvider, child) {
                            return Consumer<LoginStateProvider>(
                              builder: (context, loginStateProvider, child) {
                                return Container(
                                  child: AppButton(
                                    buttonText: "Log In",
                                    function: () {
                                      if (_formKey.currentState.validate()) {
                                        userLogin(
                                            loginStateProvider.changeLoginState,
                                            loginStateProvider.addUser,
                                            favListProvider.updateList);
                                      }
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 22),
                    child: Text(
                      "-OR-",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "SF Pro Display",
                        fontSize: 18,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  SocialLoginButton(
                      function: () {
                        comeingSoonMssage("FaceBook");
                      },
                      title: "Sign In with Facebook",
                      icon: Icon(
                        EvaIcons.facebook,
                        color: Colors.blue,
                      )),
                  SizedBox(
                    height: 22,
                  ),
                  Consumer<FavListProvider>(
                    builder: (context, favListProvider, child) {
                      return Consumer<LoginStateProvider>(
                        builder: (context, loginStateProvider, child) {
                          return SocialLoginButton(
                              function: () {
                                signInWithGoogle(
                                    loginStateProvider.changeLoginState,
                                    loginStateProvider.addUser,
                                    favListProvider.updateList);
                              },
                              title: "Sign In with Google",
                              icon: Icon(
                                EvaIcons.google,
                                color: Colors.orange,
                              ));
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
