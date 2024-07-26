import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneymate2/full/MoneyMate/Users/Login/MoneymateLogin.dart';


main(){
runApp(MaterialApp(
home: RegistrationScreen(),
));
}

class RegistrationScreen extends StatefulWidget {
@override
State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
late CollectionReference _userCollection;

final _nameController = TextEditingController();
final _usernameController = TextEditingController();
final _emailController = TextEditingController();
final _passwordController = TextEditingController();
final _confirmPasswordController = TextEditingController();
bool _isPasswordVisible = false;
bool _isConfirmPasswordVisible = false;
@override
void initState() {
// TODO: implement initState
_userCollection = FirebaseFirestore.instance.collection("users");
super.initState();
}
final FirebaseAuth auth = FirebaseAuth.instance;
var _formKey = GlobalKey<FormState>();


@override
Widget build(BuildContext context) {
return Scaffold(
body: Container(
width: double.infinity,
decoration: BoxDecoration(
gradient: LinearGradient(
begin: Alignment.topCenter,
end: Alignment.bottomCenter,
colors: [Colors.deepOrange, Colors.white],
),
),
child: Center(
child: Padding(
padding: const EdgeInsets.all(20.0),
child: SingleChildScrollView(
child: Form(
key: _formKey,
child: Container(
padding:
const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(15),
boxShadow: [
BoxShadow(
color: Colors.black26,
blurRadius: 10,
offset: Offset(0, 10),
),
],
),
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
Text(
'  MoneyMate Account',
style: TextStyle(color: Colors.orange,
fontSize: 25,
fontWeight: FontWeight.bold,
),
),
SizedBox(height: 10),
Text(
'Enter Your details',
style: TextStyle(color: Colors.black
,fontWeight: FontWeight.bold,fontSize: 15),

),
SizedBox(height: 20),
Icon(
Icons.person,
size: 50,
color: Colors.orange,
),
SizedBox(height: 20),
TextFormField(
controller:_nameController,
decoration: InputDecoration(
hintText: "Full Name",
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(10),
),
contentPadding: EdgeInsets.symmetric(horizontal: 15),
),
validator: (name) {
if (name!.isEmpty) {
return "Enter some Value";
} else {
return null;
}
},
// onSaved: (ename) {
//   name = ename;
// },
),
SizedBox(height: 10),
TextFormField(
controller: _usernameController,
decoration: InputDecoration(
hintText: "Username",
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(10),
),
contentPadding: EdgeInsets.symmetric(horizontal: 15),
),
),
SizedBox(height: 10),
TextFormField(
controller: _emailController,
decoration: InputDecoration(
hintText: "Email",
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(10),
),
contentPadding: EdgeInsets.symmetric(horizontal: 15),
),
validator: (value) {
if (value!.isEmpty || !value.contains('@')) {
return 'Please enter a valid email';
}
return null;
},
// onSaved: (eemail) {
//   email = eemail;
// },
),
SizedBox(height: 10),
Row(
children: [
Expanded(
child: TextFormField(
controller: _passwordController,
decoration: InputDecoration(
hintText: "Password",
suffixIcon: IconButton(
icon: Icon(
_isPasswordVisible ? Icons.visibility : Icons.visibility_off,
),
onPressed: () {
setState(() {
_isPasswordVisible = !_isPasswordVisible;
});
},
),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(10),
),
contentPadding:
EdgeInsets.symmetric(horizontal: 15),
),
obscureText: !_isPasswordVisible,
validator: (value) {
if (value!.isEmpty || value.length < 6) {
return 'Please enter a password with at least 6 characters';
}
return null;
},
// onSaved: (epass) {
//   pass = epass;
// },
),
),
SizedBox(width: 10),
Expanded(
child: TextFormField(
controller: _confirmPasswordController,
decoration: InputDecoration(
hintText: "Confirm Password",
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(10),
),
contentPadding:
EdgeInsets.symmetric(horizontal: 15),
suffixIcon: IconButton(
icon: Icon(
_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
),
onPressed: () {
setState(() {
_isConfirmPasswordVisible = !_isConfirmPasswordVisible;
});
},
),
),
obscureText: !_isConfirmPasswordVisible,
validator: (value) {
if (value != _passwordController.text) {
return 'Passwords do not match';
}
return null;
},
// validator: (cnpassword) {
//   if (cnpassword!.isEmpty ||
//       cnpassword.length < 6 ||
//       password == cnpassword) {
//     return "Password Incorrect";
//   }
//   return "Password Incorrect";
// }),
),
)],
),
SizedBox(height: 10),
Row(
children: [
Checkbox(value: true, onChanged: (bool? value) {}),
Expanded(
child: Text(
'I have accepted the terms and conditions'),
),
],
),
SizedBox(height: 20),
Container(
width: double.infinity,
child: ElevatedButton(
onPressed: () {
_register(_nameController.text, _emailController.text,_passwordController.text);
},
style: ElevatedButton.styleFrom(
padding: EdgeInsets.symmetric(vertical: 15),
backgroundColor: Colors.orange,

),
child: Text(
'Continue',
style: TextStyle(
color: Colors.white,
fontSize: 16,
),
),
),
),
SizedBox(height: 20),
// Text(
//   'I have an account, LOGIN',
//   style: TextStyle(color: Colors.grey),
// ),
],
),
),
),
),
),
),
),
);
}
void _register( String name,String email,String username) async {

if (_formKey.currentState!.validate()) {
try {
UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
email: _emailController.text,
password: _passwordController.text,
);

// Save additional details to Firestore
await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
'name': _nameController.text,
'username': _passwordController.text,
'email': _emailController.text,
});

// Navigate to the login screen
//Navigator.of(context).pushReplacementNamed('LoginScreen');
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
} on FirebaseAuthException catch (e) {
// Handle error
print(e.message);
}
}
}}
