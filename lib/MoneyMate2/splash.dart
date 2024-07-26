import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'loginwithmobilenumber.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAesQHw2Jb4cQG7Z_kr91wTIwdX5Fq2k18",
      appId: "1:397478883162:android:af509b2925b5eaf2fccd63",
      messagingSenderId: "",
      projectId: "moneymate2-fdfaf",
      storageBucket: "moneymate2-fdfaf.appspot.com",
    ),
  );
  runApp(MoneyMatesplash());
}

class MoneyMatesplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashNew(),
    );
  }
}

class SplashNew extends StatefulWidget {
  const SplashNew({super.key});

  @override
  State<SplashNew> createState() => _SplashNewState();
}

class _SplashNewState extends State<SplashNew> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MobileOtp()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Image.asset("assets/images/moneymatewhite.png"),
        ),
      ),
    );
  }
}