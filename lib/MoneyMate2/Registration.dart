// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:moneymate2/MoneyMate/MoneymateLogin.dart';
//
//
//
// main(){runApp(MaterialApp(home: RegistrationScreen(),));}
// class RegistrationScreen extends StatefulWidget {
//   @override
//   _RegistrationScreenState createState() => _RegistrationScreenState();
// }
//
// class _RegistrationScreenState extends State<RegistrationScreen> {
//   late CollectionReference _userCollection;
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _usernameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   bool _isPasswordVisible = false;
//   bool _isConfirmPasswordVisible = false;
//   @override
//   void initState() {
//     // TODO: implement initState
//     _userCollection = FirebaseFirestore.instance.collection("users");
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Text(
//           'Finish creating your MoneyMate Account',
//           style: TextStyle(fontSize: 30),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: <Widget>[
//               Text(
//                 'Tell us about you.',
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(labelText: 'First Name',hintText: "Enter Your First Name"),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your first name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _usernameController,
//                 decoration: InputDecoration(labelText: 'Last Name',hintText: "Enter Your Last Name"),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a lastname';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: 'User Name',hintText: "Enter Your Email "),
//                 validator: (value) {
//                   if (value!.isEmpty || !value.contains('@')) {
//                     return 'Please enter a valid email';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   hintText: "Enter a Strong Password",
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isPasswordVisible = !_isPasswordVisible;
//                       });
//                     },
//                   ),
//                 ),
//                 obscureText: !_isPasswordVisible,
//                 validator: (value) {
//                   if (value!.isEmpty || value.length < 6) {
//                     return 'Please enter a password with at least 6 characters';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _confirmPasswordController,
//                 decoration: InputDecoration(
//                   labelText: 'Confirm Password',
//                   hintText: "Enter The Same Password ",
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
//                       });
//                     },
//                   ),
//                 ),
//                 obscureText: !_isConfirmPasswordVisible,
//                 validator: (value) {
//                   if (value != _passwordController.text) {
//                     return 'Passwords do not match';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'By clicking Continue, you agree to our Terms and acknowledge our Privacy Policy.',
//                 style: TextStyle(fontSize: 10),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed:(){ _register(_nameController.text, _emailController.text,_passwordController.text);},
//                 child: Text('Continue'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _register( String name,String email,String username) async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: _emailController.text,
//           password: _passwordController.text,
//         );
//
//         // Save additional details to Firestore
//         await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
//           'name': _nameController.text,
//           'username': _passwordController.text,
//           'email': _emailController.text,
//         });
//
//         // Navigate to the login screen
//         //Navigator.of(context).pushReplacementNamed('LoginScreen');
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
//       } on FirebaseAuthException catch (e) {
//         // Handle error
//         print(e.message);
//       }
//     }
//   }
// }
