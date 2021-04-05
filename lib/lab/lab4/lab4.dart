import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'google_sign_in.dart';
import 'signin.dart';
import 'package:provider/provider.dart';

class LabFourth extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: ChangeNotifierProvider(
            create: (context) => GoogleSignInProvider(),
            child: StreamBuilder(
              stream: FirebaseAuth.instance.onAuthStateChanged,
              builder: (context, snapshot) {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                if (provider.isSigningIn) {
                  return buildLoading();
                } else if (snapshot.hasData) {
                  return LoggedInWidget();
                } else {
                  return SignUpWidget();
                }
              },
            )),
      );
  Widget buildLoading() => Center(child: CircularProgressIndicator());
}
