import 'package:acupoint_stimulator/constants.dart';
import 'package:acupoint_stimulator/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:acupoint_stimulator/utils.dart';
import 'dart:async';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Introduction',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: const TextTheme(
          headline5: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, height: 1.5),
          headline6: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 18),
          button: TextStyle(color: kPrimaryColor),
        ),
      ),
      home: const SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPage();
}

class _SplashPage extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const WelcomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: kPrimaryColor,
            alignment: Alignment.center,
            child: const Icon(
              Icons.health_and_safety,
              color: Colors.white,
              size: 100,
            )));
  }
}
