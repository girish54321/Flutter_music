import 'package:flutter/material.dart';

class Heading1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Text(
      "Headline 1",
      style: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.w700,
        fontSize: 40,
      ),
    );
  }
}

class LargeTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Text(
      "Large Title",
      style: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.w700,
        fontSize: 34,
      ),
    );
  }
}

class Headline2 extends StatelessWidget {
  final String text;

  const Headline2({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Text(
      text,
      style: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.w700,
        fontSize: 28,
      ),
    );
  }
}

class Headline3 extends StatelessWidget {
  final String text;

  const Headline3({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Text(
      text,
      style: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.w700,
        fontSize: 22,
      ),
    );
  }
}

class Headline4 extends StatelessWidget {
  final String text;

  const Headline4({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Text(
      text,
      maxLines: 2,
      style: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
    );
  }
}

class Headline5 extends StatelessWidget {
  final String text;

  const Headline5({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Text(
      text,
      maxLines: 1,
      style: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.w600,
        fontSize: 17,
      ),
    );
  }
}

class LargeBody extends StatelessWidget {
  final String text;

  const LargeBody({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Text(
      text,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: 17,
      ),
    );
  }
}

class Body extends StatelessWidget {
  final String text;

  const Body({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Text(
      text,
      style: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.w500,
        fontSize: 15,
      ),
    );
  }
}

class CaptionL extends StatelessWidget {
  final String text;

  const CaptionL({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Text(
      text,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: 13,
      ),
    );
  }
}

class SMALLCAPTION extends StatelessWidget {
  final String text;

  const SMALLCAPTION({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Text(
      text,
      style: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.w500,
        fontSize: 11,
        // color: Color(0xff000000).withOpacity(0.40),
      ),
    );
  }
}
