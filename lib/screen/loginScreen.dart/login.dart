import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/home/HomeMain.dart';
import 'package:musicPlayer/home/home.dart';
import 'package:musicPlayer/screen/SingUpScreen/SingUpScreen.dart';
import 'package:musicPlayer/screen/loginScreen.dart/AppButton.dart';
import 'package:musicPlayer/screen/loginScreen.dart/inputText.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

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
                              FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: SingUpScreen()));
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
                          ),
                          new Text(
                            "Password",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff000000).withOpacity(0.50),
                            ),
                          ),
                          InputText(
                            password: true,
                            hint: "Password",
                          ),
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
                          Container(
                            child: AppButton(
                              buttonText: "SIGN IN",
                              function: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AudioServiceWidget(
                                                child: MyHomePage())),
                                    (Route<dynamic> route) => false);
                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (BuildContext context) =>
                                //         MyHomePage(),
                                //   ),
                                //   result: (route) => true,
                                // );
                              },
                            ),
                          )
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
