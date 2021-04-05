import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/lab/lab4/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class SignUpWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpWidget1();
  }
}

class SignUpWidget1 extends State {
  @override
  Widget build(context) {
    return Scaffold(
      body: Center(
        child: OutlineButton.icon(
          label: Text('Sign In with Google'),
          shape: StadiumBorder(),
          padding: EdgeInsets.all(10),
          highlightedBorderColor: Colors.black,
          textColor: Colors.black,
          icon: FaIcon(FontAwesomeIcons.google, color: Colors.black),
          onPressed: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.login();
          },
        ),
      ),
    );
  }
}
