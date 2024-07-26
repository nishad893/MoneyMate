import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Settings.dart';
import 'Spending.dart';
import 'categories.dart';
import 'loginwithmobilenumber.dart';
import 'transcation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDKK6kO3aR8cLb90qASqcmOP3YhrPBYQm0",
      appId: "1:866409671969:android:ff79734a13ea31dec96260",
      messagingSenderId: "",
      projectId: "moneymate666",
      storageBucket: "moneymate666.appspot.com",
    ),
  );
  runApp(MoneyMateApp());
}

class MoneyMateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthenticationWrapper(), // Start with authentication wrapper
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Or loading indicator
        }
        if (snapshot.hasData) {
          User? user = FirebaseAuth.instance.currentUser;
          String uid = user!.uid;
          return MoneyMatehome(uid: uid); // Navigate to home with uid
        } else {
          return  MobileOtp(); // Navigate to authentication screen
        }
      },
    );
  }
}

class MoneyMatehome extends StatefulWidget {
  final String uid;

  MoneyMatehome({required this.uid});

  @override
  _MoneyMatehomeState createState() => _MoneyMatehomeState();
}

class _MoneyMatehomeState extends State<MoneyMatehome> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    SpendingPage(),
    TransactionPage(),
    CategoriesPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Spending',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        onTap: _onItemTapped,
      ),
    );
  }
}
