import 'package:flutter/material.dart';
import 'package:musicPlayer/provider/loginState.dart';
import 'package:musicPlayer/widgets/AppButton.dart';
import 'package:musicPlayer/widgets/inputText.dart';
import 'package:provider/provider.dart';
import 'package:rules/rules.dart';

class SingUpUi extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController userNameController;
  final Function createNewUser;

  const SingUpUi(
      {Key key,
      @required this.emailController,
      @required this.passwordController,
      @required this.userNameController,
      @required this.createNewUser})
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
    );
  }
}
