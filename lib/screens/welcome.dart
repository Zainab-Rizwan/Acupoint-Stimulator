import 'package:acupoint_stimulator/constants.dart';
import 'package:flutter/material.dart';
import 'package:acupoint_stimulator/screens/verify_email_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:acupoint_stimulator/screens/auth_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
          body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          } else if (snapshot.hasData) {
            return const VerifyEmailPage();
          } else {
            return const AuthPage();
          }
        },
      ));
}

