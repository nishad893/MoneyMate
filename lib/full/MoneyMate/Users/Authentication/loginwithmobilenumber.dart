import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:moneymate2/full/MoneyMate/Users/Registration/Registration.dart';


import '../Login/MoneymateLogin.dart';

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

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MobileOtp(),
  ));
}

class MobileOtp extends StatefulWidget {
  const MobileOtp({super.key});

  @override
  State<MobileOtp> createState() => _MobileOtpState();
}

class _MobileOtpState extends State<MobileOtp> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  String phoneNumber = '';
  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpFieldVisibility = false;
  String verificationId = '';

  void verifyPhoneNumber() {
    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) async {
          // Handle successful authentication here
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verId, int? resendToken) {
        verificationId = verId;
        otpFieldVisibility = true;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verId) {},
    );
  }

  Future<void> verifyOtpCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpController.text,
    );
    await auth.signInWithCredential(credential).then((value) async {
      if (value.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegistrationScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Enter Mobile Number",
            style: TextStyle(fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.orange),
          ),
          SizedBox(height: 10,),
          Text(
            "An OTP will be sent to verify your mobile number",
            style: TextStyle(fontSize: 13,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          ),
          SizedBox(height: 50),
          IntlPhoneField(
            controller: phoneNumberController,
            initialCountryCode: 'IN',
            style: TextStyle(color: Colors.orange),
            decoration: InputDecoration(
              hintText: "Phone Number",
              hintStyle: TextStyle(color: Colors.orange),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (val) {
              phoneNumber = val.completeNumber;
            },
          ),
          SizedBox(height: 10),
          Visibility(
            visible: otpFieldVisibility,
            child: TextField(
              controller: otpController,
              decoration: InputDecoration(
                hintText: "OTP Code",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (otpFieldVisibility) {
                verifyOtpCode();
              } else {
                verifyPhoneNumber();
              }
            },
            child: Text(otpFieldVisibility ? 'Login' : 'Send OTP'),
          ),
          SizedBox(height: 10), // Adjust the spacing as needed
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Text(
              'Already have account?',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
