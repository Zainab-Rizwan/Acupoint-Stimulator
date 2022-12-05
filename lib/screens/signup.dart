import 'package:firebase_auth/firebase_auth.dart';
import 'package:acupoint_stimulator/main.dart';
import 'package:acupoint_stimulator/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:acupoint_stimulator/constants.dart';

class SignUpScreen extends StatefulWidget {
  final Function() onClickedSignIn;

  const SignUpScreen({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  bool _obscureText = true;
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/waves.png',
                      fit: BoxFit.cover,
                      width: size.width,
                      alignment: Alignment.topCenter,
                    ),
                  ],
                ),
                const Text('SIGN UP',
                    style: TextStyle(
                      fontSize: 26,
                      color: kdarkblue,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 35),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: emailController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kdarkblue),
                      ),
                      labelText: 'EMAIL',
                      labelStyle: TextStyle(color: kdarkblue),
                      border: UnderlineInputBorder(),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && EmailValidator.validate(email)
                            ? 'Enter a valid email'
                            : null,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: kdarkblue),
                        ),
                        labelText: 'PASSWORD',
                        labelStyle: const TextStyle(color: kdarkblue),
                        border: const UnderlineInputBorder(),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 5
                        ? 'Enter min. 6 characters'
                        : null,
                  ),
                ),
                const SizedBox(height: 70),
                SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: kPrimaryColor,
                        textStyle: const TextStyle(fontSize: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: signUp,
                      child: const Text('SIGN UP'),
                      //parameters of Button class
                    )),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      height: 5,
                      color: kdarkblue,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                    text: "Don't have an account? ",
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignIn,
                        text: 'Sign In',
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil(
      (route) => route.isFirst,
    );
  }
}
