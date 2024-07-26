// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'home.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(LoginScreen());
// }
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _rememberMe = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadSavedCredentials();
//   }
//
//   void _loadSavedCredentials() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _usernameController.text = prefs.getString('username') ?? '';
//       _passwordController.text = prefs.getString('password') ?? '';
//       _rememberMe = prefs.getBool('rememberMe') ?? false;
//     });
//   }
//
//   void _saveCredentials() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (_rememberMe) {
//       prefs.setString('username', _usernameController.text);
//       prefs.setString('password', _passwordController.text);
//     } else {
//       prefs.remove('username');
//       prefs.remove('password');
//     }
//     prefs.setBool('rememberMe', _rememberMe);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login to MoneyMate'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: <Widget>[
//               TextFormField(
//                 controller: _usernameController,
//                 decoration: InputDecoration(labelText: 'Username'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your username';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   return null;
//                 },
//               ),
//               Row(
//                 children: [
//                   Checkbox(
//                     value: _rememberMe,
//                     onChanged: (value) {
//                       setState(() {
//                         _rememberMe = value!;
//                       });
//                     },
//                   ),
//                   Text('Remember login details'),
//                 ],
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _login,
//                 child: Text('Login'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _login() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: _usernameController.text,
//           password: _passwordController.text,
//         );
//
//         _saveCredentials();
//
//         //Navigator.of(context).pushReplacementNamed('MoneyMatehome');
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MoneyMatehome(uid: userCredential.user!.uid)));
//       } on FirebaseAuthException catch (e) {
//         // Handle error
//         print(e.message);
//       }
//     }
//   }
// }
