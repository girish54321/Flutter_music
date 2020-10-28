import 'package:flutter/material.dart';
import 'package:musicPlayer/home/HomeMain.dart';
import 'package:musicPlayer/home/home.dart';
import 'package:musicPlayer/screen/loginScreen.dart/AppButton.dart';
import 'package:musicPlayer/screen/loginScreen.dart/inputText.dart';

class SingUpScreen extends StatefulWidget {
  @override
  _SingUpScreenState createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
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
                          ),
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
                          Container(
                            child: AppButton(
                              buttonText: "SIGN UP",
                              function: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage()),
                                    (Route<dynamic> route) => false);
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
